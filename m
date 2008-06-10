From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: Date parsing
Date: Tue, 10 Jun 2008 17:27:58 +0200
Message-ID: <bd6139dc0806100827m434748a6u8ce232e1ad967377@mail.gmail.com>
References: <bd6139dc0806100758xb41d08dh18e3051088b707e5@mail.gmail.com>
	 <484E98BA.70808@viscovery.net>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 17:29:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K65mM-0002jr-1k
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 17:28:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122AbYFJP2E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYFJP2D
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 11:28:03 -0400
Received: from wf-out-1314.google.com ([209.85.200.168]:44130 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752889AbYFJP2B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 11:28:01 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2636241wfd.4
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OHx4NFFSpVaUhq8mvhCJF6BwYjNiFR6jlJv+JLntPh8=;
        b=ZaVlREcuuSoKHo5JBcq4jWNH647TvRg5YP9vy/i3EXEZLhDlPTbCms7tQU3cREaw08
         MGrrEuaBQidEiO1VR0VVaIWT2o+QUuw9UJsiQWk9Y4Joz3e7DhvKVfhjoyYGGXCgGpKm
         KNYuFork5pq91UT4AbI28Lj8Nw6F2bueemsMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=UnCoj4AeaSTI0oEn52T9/9wvZfQq6pWrItcUr0xLUtPax4oNrHff/1heEK3w6eH25V
         4D6Z/1uZnK226AonyQNwi3dKEIz7Y5gpleh7pqCh4fG7b4QGm/WQImf3EPS1U/shIJ8v
         nWExLzy9nuz5plgOCXe8iTNka2vDfpDbylIl4=
Received: by 10.142.177.7 with SMTP id z7mr306647wfe.15.1213111678907;
        Tue, 10 Jun 2008 08:27:58 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Tue, 10 Jun 2008 08:27:58 -0700 (PDT)
In-Reply-To: <484E98BA.70808@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84518>

On Tue, Jun 10, 2008 at 5:07 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Since you did not give a timezone, your local timezone is taken,
> presumably MET, which has daylight saving time in July, but not in
> January. This is OK.

Ah, then I agree the timezone change makes sense, although magical
ordering switching is still bothering me.

-- 
Cheers,

Sverre Rabbelier
