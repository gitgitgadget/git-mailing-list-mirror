From: "John Yesberg" <john.yesberg@gmail.com>
Subject: Re: git-daemon on Windows?
Date: Thu, 12 Jun 2008 16:23:20 +0100
Message-ID: <1033a22d0806120823j40185f9dj28672803490f8bdb@mail.gmail.com>
References: <63c5d3820806110551y69e895eeg4fde4bfdaf22bbf2@mail.gmail.com>
	 <484FD8FA.3060003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Chris Hoffman" <chris.c.hoffman@gmail.com>, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 12 17:24:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6oeu-00009x-Ed
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 17:24:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752371AbYFLPXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 11:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752384AbYFLPXW
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 11:23:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:33729 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbYFLPXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 11:23:21 -0400
Received: by yx-out-2324.google.com with SMTP id 31so414201yxl.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=XxkoS08L46yK/m22eaoZmS0dN60T46ywoiGMO+/Haeo=;
        b=u7JuoNdyNyUhYuv6GcOC9rKm3aMc0ot71ndMz90OMe2+eTabbZnzCY/dtl7em6nbTD
         y7HVO0C5/D3b3g8Qa9wLHg9WHpOL+X2zaHrCcZPizSRxr50PprZj4Vf6macfHVdVaGHS
         GYt3CWzH2uYr6eXQJINArfe5hbBnu29bua2mI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=twt3/EMWG3feLsgE+2ExlVjqkS2v/dGdKhHRoxJlXVmI4wTKeFW4dQcr0sOWAKDHUr
         Y7eX0QchMpc3Hkp+EG5Z1mQpW9rCWP6MIsdW0GZPC3XtpFDHDzHTomOxJZcUKM6yd3xg
         ajsIpL1Eas8AsKY/peqe73d4DQWGYXdO7h3+4=
Received: by 10.151.112.4 with SMTP id p4mr2514951ybm.167.1213284200548;
        Thu, 12 Jun 2008 08:23:20 -0700 (PDT)
Received: by 10.151.14.21 with HTTP; Thu, 12 Jun 2008 08:23:20 -0700 (PDT)
In-Reply-To: <484FD8FA.3060003@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84759>

I'm trying to learn about this too.
I found the gittutorial
http://www.kernel.org/pub/software/scm/git/docs/gittutorial.html
useful.
See the section "Using git for collaboration", which explains how use
can use a shared filesystem.

Or maybe I don't understand the subtleties of the issue.

John.

On Wed, Jun 11, 2008 at 2:54 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Chris Hoffman schrieb:
>> Is there a distribution of the git server for Windows, or am I totally
>> missing the point of git?  Will a simple file share work, or do I have
>> to worry about file locking and such (e.g., two people try to commit
>> at the same time).
>
> You are missing *some* point of git: Usually, everyone has his own
> repository, hence, commits that happen concurrently won't be a problem.
>
> But you must exchange your work, and for this it is common that everyone
> in addition has a publically accessible (bare) repository. These you can
> place on a normal file share. I do this all the time.
>
> You *can* choose to have only a single (bare) repository that everyone
> uses to exchange work. But then you do have to worry about concurrent
> *pushes* that get in the way of each other. You have this problem no
> matter which form of server you chose (file share, ssh, git daemon,
> WebDAV). If you go this route, you need a policy how people publish their
> work (eg. branch namespaces). msysgit and 4msysgit do it this way.
>
> -- Hannes
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
