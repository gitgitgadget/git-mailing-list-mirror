From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] Git User's Survey 2009 - second trial run, and question 
	about announcing it
Date: Sat, 4 Jul 2009 02:19:25 +0300
Message-ID: <94a0d4530907031619x3d1296eenf9198b4ab5e43f67@mail.gmail.com>
References: <200907030130.24417.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Graham Perks <graham@kace.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 01:19:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMs2Y-0005nV-Hr
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 01:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755878AbZGCXTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2009 19:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754988AbZGCXTX
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jul 2009 19:19:23 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:13905 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754424AbZGCXTX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2009 19:19:23 -0400
Received: by fg-out-1718.google.com with SMTP id e21so792479fga.17
        for <git@vger.kernel.org>; Fri, 03 Jul 2009 16:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BpwCgGSpo17wYlqL8gIHzbWCEYsVzgKz3mA+Epx0m6g=;
        b=aj03DHlzo9iemyFlkn8Dcyox8yXDK4Ld8EgsXE8j8XKy9FcMNKLVAgfo89huQG2Dgf
         OvdTTg55r19cJ5DY2PaY0777MYHAT4Ao2S8d4KRuq1uAQwDGwBWhGb/ha8uZhdZiFaw1
         zimzU5UhOeU6sKPFRUmVn6v5SiVm9/rp2xdRk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YbyyL4A2nB6eMXAg57VqQ6UcSHqf2ClgeCWdGNdMj3iOMTt15/CEcnz4mvcwLR7kzI
         4cJ6Nh78T0H3o2cTn38MVEjDJHP/q18YIGvViBuNBBceekgXTtNi0+E+UXgN6avmWMns
         49l1V0nIOdaubt+H+z9W1Y5zLZU3FgbsQGMp4=
Received: by 10.86.58.9 with SMTP id g9mr1215365fga.18.1246663165722; Fri, 03 
	Jul 2009 16:19:25 -0700 (PDT)
In-Reply-To: <200907030130.24417.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122711>

2009/7/3 Jakub Narebski <jnareb@gmail.com>:
> The last replacements reminds me of the problem of announcing this
> survey.  Where to submit note announcing "Git User's Survey 2009"
> (tentative date of survey is 15 July 2009 -- 15 September 2009)?
> How such note should look like?

I'm not sure what you mean. I think the best place to announce these
kinds of things is through a post in an official blog.

> 8. How do/did you obtain Git (install and/or upgrade)?
>    * binary package (includes automatic updates in usual situation)
>    * source package or script
>    * source tarball
>    * pull from (main) repository
>
> Explanation: binary package covers pre-compiled binary (e.g. from rpm
> or deb binary packages); source package covers things like deb-src and
> SRPMS/src.rpm; source script is meant to cover installation in
> source-based distributions, like 'emerge' in Gentoo, and it includes
> automatic update in source-based Linux distributions.
>
> Note that this question is multiple choices question because one can
> install Git in different ways on different machines or on different
> operating systems.

It's a bit complicated and missing some, how about:
8. How do/did you obtain Git?
 * package management (apt, yum, etc.)
 * binary package or installer (.deb, .exe) <-
 * source package or script (deb-src, src.rpm)
 * source tarball
 * pull from (main) repository

- 9. What operating system do you use Git on?
+ 9. On which operating system(s) do you use Git?

- 13. Which git hosting site do you use for your projects?
+ 13. Which hosting site(s) do you use for your projects?

> 20. Overall, how happy are you with Git?
>    * unhappy
>    * not so happy
>    * happy
>    * very happy
>    * completely ecstatic

Let's leave room for git haters too:
 * I hate it

- 21. In you opinion, which areas in Git needs improvement?
+ 21. In you opinion, which areas of Git need improvement?

- 23. How do you compare current version with version from year ago?
+ 23. How do you compare the current version with the one from one year ago?

> 25. Have you tried to get Git help from other people?
> 26. What channel did you use to request help?
> 27. If yes, did you get these problems resolved quickly and to your liking?

"If yes" on 27 is out of context:

- 25. Have you tried to get Git help from other people?
+ 25. Have you tried to get help regarding Git from other people?
26. If yes, did you get these problems resolved quickly and to your liking?
27. What channel did you use to request help?

- 28. Which communication channels do you use?
+ 28. Which communication channel(s) do you use?

- 29. How did you heard about this Git User's Survey?
+ 29. How did you hear about this survey?

- 30. What other comments or suggestions do you have that are not
covered by the questions above?
+ 30. Any other comments or suggestions?

Best regards.

-- 
Felipe Contreras
