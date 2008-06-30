From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 03:10:56 -0700 (PDT)
Message-ID: <m3r6afgrme.fsf@localhost.localdomain>
References: <200806301149.18115.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Mon Jun 30 12:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGMa-00037k-LF
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbYF3KLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 06:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755034AbYF3KLD
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:11:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:22481 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753709AbYF3KLB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:11:01 -0400
Received: by ug-out-1314.google.com with SMTP id h2so218415ugf.16
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=28RTP7rgFMgwJjM/FHFguEN2deVc3cYXvh4bck/ZKsg=;
        b=b+tr2VyGm0lMOWYsQHCaiphk8JQBCzWtGT6SndSkMhuzd1PQuGZrdcSSkiDoN0dqJE
         A4XPSa3s+aHnVs89GCHbAi/h/ImXY9Keg5GLe+NHDSr7VaOpYRwo6UMdkZbS4+fWW2xD
         S4yu3cbItAnIpi/CJkQeXn24v5OjRowE/UOcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=qByHaXbqxxvixrDEYAfZdxYz8WTsYl1gKJYRdLZj7AV/vlVn158KJSyikGT/v92oDq
         xCa09/ms9mXbnQhRisLXLj6eOAFqhyEFuvEBUVU8UyYc59DcmY0FRIwXHOae6EH58X5O
         k5J8kayc9D0zCKfflgFdTiyTMd9Yqln1spTHY=
Received: by 10.67.116.4 with SMTP id t4mr3681774ugm.54.1214820657476;
        Mon, 30 Jun 2008 03:10:57 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.122])
        by mx.google.com with ESMTPS id p32sm716990ugc.44.2008.06.30.03.10.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 03:10:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5UAAqld018320;
	Mon, 30 Jun 2008 12:10:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5UAAofD018316;
	Mon, 30 Jun 2008 12:10:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200806301149.18115.J.Wielemaker@uva.nl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86900>

Jan Wielemaker <J.Wielemaker@uva.nl> writes:

> I'm a bit puzzled. I have a bare repository, somehow without any files
> in refs/heads.

Do you have .git/packed-refs file? How do you have gc.packrefs set
("git config --get gc.packrefs")? What are the git version on the
clients that have trouble accessing repository, and what protocol
(transport merhod) do they use: "file", http(s)/ftp, git, ssh?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
