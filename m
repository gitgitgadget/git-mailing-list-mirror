From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Does content provenance matter?
Date: Mon, 07 May 2012 16:12:59 -0700 (PDT)
Message-ID: <m3397ba8lh.fsf@localhost.localdomain>
References: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kelly Dean <kellydeanch@yahoo.com>
X-From: git-owner@vger.kernel.org Tue May 08 01:13:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRX7H-0001r7-D9
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 01:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757676Ab2EGXND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 19:13:03 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:40776 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab2EGXNB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 19:13:01 -0400
Received: by werb10 with SMTP id b10so1559713wer.19
        for <git@vger.kernel.org>; Mon, 07 May 2012 16:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ay4aNAVvkd1Jz30i/r0ZpydFPIKz50Pv+I1+68sJvrM=;
        b=zmkNy3GNU8MqeptTvE3ZmDh1Iyuq9W4kt489rgSlV6f+AX6VgFmve2wPcgc1F26CCE
         Eaai+7/Y7V00hXsYkE4FZgT3OnGlv+JZo3E7lPFWs/lMCJWVvFBAwUDqNIKc5VS/JOVk
         YWnrnFaIFwVJ1UabHeTMByTnYx0pY9loy4Ymz7C8Iaf8PkArjowHe4mxQF3gA0fXESon
         cAGcwyhVf0R9vlw7hF4GCwee/26xnt1ksrK1rmqaT0cYtpCDxb2HaK9VB3LjbqC1ORp5
         0HIIMwoj0bnluPsF//uRioThAJ5bwlqsu3a8c6UYOo/pLmUDbnzZ4iXu8AJihvRBHIKY
         T5oQ==
Received: by 10.216.135.199 with SMTP id u49mr11153393wei.7.1336432380535;
        Mon, 07 May 2012 16:13:00 -0700 (PDT)
Received: from localhost.localdomain (adhb18.neoplus.adsl.tpnet.pl. [79.184.157.18])
        by mx.google.com with ESMTPS id fl2sm39100839wib.2.2012.05.07.16.12.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 07 May 2012 16:12:59 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q47NCxZe026350;
	Tue, 8 May 2012 01:12:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q47NCw24026347;
	Tue, 8 May 2012 01:12:58 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1336250956.54413.YahooMailClassic@web121505.mail.ne1.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197324>

Kelly Dean <kellydeanch@yahoo.com> writes:

> The basic question is, if provenance doesn't matter, then why does a
> git commit record its parent(s)? Why not omit this information, and
> figure it out at search time (by looking at all commits with older
> timestamps),

Because it is not possible to do in reliable way in face of parallel
concurrent branchy development by multiple developers... some of which
can have badly set clock.

Also, multiple merges of the same branch.
-- 
Jakub Narebski
