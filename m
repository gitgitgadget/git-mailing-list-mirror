From: "David Aguilar" <davvid@gmail.com>
Subject: Re: [ANNOUNCE] git-cola 1.3.4
Date: Thu, 25 Dec 2008 23:59:17 -0800
Message-ID: <402731c90812252359r5b6b9420hcadbfa076f561feb@mail.gmail.com>
References: <20081225233625.GA11029@gmail.com>
	 <1230277737.14882.54.camel@starfruit>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "R. Tyler Ballance" <tyler@slide.com>
X-From: git-owner@vger.kernel.org Fri Dec 26 09:00:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LG7ce-0005bB-A7
	for gcvg-git-2@gmane.org; Fri, 26 Dec 2008 09:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753864AbYLZH7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Dec 2008 02:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbYLZH7T
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Dec 2008 02:59:19 -0500
Received: from wf-out-1314.google.com ([209.85.200.171]:34302 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753850AbYLZH7S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Dec 2008 02:59:18 -0500
Received: by wf-out-1314.google.com with SMTP id 27so3768968wfd.4
        for <git@vger.kernel.org>; Thu, 25 Dec 2008 23:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=6Wey7jZeB9BHC4wSCukPsjbnmw92s8R7IBUtggUfZzQ=;
        b=AQHCGuJnPhmZzLNsmPzPy8BpYC0FIZroP9wwb4ZeACtMwZvPbfEOhEaDHzPylbbBY3
         uFLAukJnTSK9lil1eKrjPxttfjCGvkHmdSerM+hbfFyjs1uKnPUb2r7mQ3i7UO9YHbgI
         5wmqYS2a/jwzw12h7gNSlrO1HRyX2RyDShOJc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=R6/MKyTIqC0E746uKuWfO2YbMJBjZVglKtukMR/JmGtrkjOZqdkf/Oref+rF9YEghg
         9u/2T2ZoXXzaG8rLDqyhJcgPBXyPVQle9TB3kocpob70HrCU3LZMRLcrKD1VfEb+8GjX
         kug47SaJtcYU2URDoWDC9yXxHjCT14lAg34Oc=
Received: by 10.142.58.20 with SMTP id g20mr4320091wfa.191.1230278357375;
        Thu, 25 Dec 2008 23:59:17 -0800 (PST)
Received: by 10.142.241.20 with HTTP; Thu, 25 Dec 2008 23:59:17 -0800 (PST)
In-Reply-To: <1230277737.14882.54.camel@starfruit>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103922>

On Thu, Dec 25, 2008 at 11:48 PM, R. Tyler Ballance <tyler@slide.com> wrote:
>
> Looks pretty nice, I was trying to give this a whirl on Python 2.6 and
> was receiving the following errors while trying to build:
>
>
>        tyler@starfruit:~/source/git/git-cola> /usr/bin/python setup.py
>        build
>        Traceback (most recent call last):

>            pyqtver = utils.run_cmd('pyuic4', '--version').split()[-1]

>        OSError: [Errno 8] Exec format error
>        tyler@starfruit:~/source/git/git-cola>
>
>
> openSUSE 11.1 (my current OS) ships with 2.6 by default now, so I'm
> curious as to the environment you're running cola in?
>
> Looks fancy, can't wait to get it running :)
>
> Cheers
> --
> -R. Tyler Ballance
> Slide, Inc.
>

I'm on debian.  There's official debian packages these days that are
making their way into both ubuntu and debian.

I'm probably doing something wrong since maybe pyuic4 isn't supposed
to be called via subprocess.Popen()?  See the INSTALL file under
'build issues'.  Your pyuic4 is missing a shebang line at the top of
the file.  I'm not sure if that's a packaging bug (openSUSE) or pyqt4
bug.  debian's pyuic4 has a #!/bin/sh line at the top and thus doesn't
have this issue.  I should probably change it so that it works either
way...  i'll see if I can work around that.
-- 
    David
