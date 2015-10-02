From: Mike Rappazzo <rappazzo@gmail.com>
Subject: Re: can't install on OS X
Date: Fri, 2 Oct 2015 08:02:45 -0400
Message-ID: <CANoM8SWptQZPOJVwX48h6D8HEV1jo=gYzJcvsp2nc2BnX4TrKg@mail.gmail.com>
References: <560E2936.6020101@prodsyse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Spencer Graves <spencer.graves@prodsyse.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 14:03:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zhz3Q-0000dt-9a
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 14:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbbJBMDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 08:03:07 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:35080 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbbJBMDG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 08:03:06 -0400
Received: by vkao3 with SMTP id o3so58253071vka.2
        for <git@vger.kernel.org>; Fri, 02 Oct 2015 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=97XQ+Rj1TIhADrDBLFvbq+nisL6uMr1CvidOq0BJ1ds=;
        b=V7By6nmXC5Z9jx2hbQ+LrKmgi66QEQzxhDuNalQLZp+ErjjQczU2x6Wsi/9TYBB8hd
         SPz+YSzunt6TWvby2UnTtPqWBIVAGoQl7vd1Cgdp8wlspaLxwROR6piu6lZv64P6Q3jy
         Ab6h22bev3334cFB5CMKBZbX8ssNjLpRxaQWW1BnIJSl9uTCHsqFvRBmZS8LjRGabiCt
         OdHIm0nDmxrL3fGdLyCcHdky5UA1xxVJDNoHdusOxSvPLI1vM2Ip0rZZO36TOt6eLGR+
         uQXswrPJqQ4R0aW68N8qt1TraO2N1WZiFvbT8KfiIKYt+emlujAT+ChFegGY2GIvIafb
         VJtg==
X-Received: by 10.31.161.142 with SMTP id k136mr9945785vke.17.1443787384641;
 Fri, 02 Oct 2015 05:03:04 -0700 (PDT)
Received: by 10.103.80.201 with HTTP; Fri, 2 Oct 2015 05:02:45 -0700 (PDT)
In-Reply-To: <560E2936.6020101@prodsyse.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278919>

Looks like you have it installed properly.  The typical usage is from
the terminal, (try `git --version` to be sure).  There is also a
pretty great UI packaged with git called git-gui.  You should be able
to make a link or an alias to it in your Applications folder (or
invoke it from the terminal `git gui`).

On Fri, Oct 2, 2015 at 2:50 AM, Spencer Graves
<spencer.graves@prodsyse.com> wrote:
> What's the procedure for installing Git under OS X 10.11?
>
>
> I downloaded "git-2.5.3-intel-universal-mavericks.dmg" per instructions.
> When I tried to install it, I first had trouble because it wasn't from the
> Mac App Store nor an "identified developer".  I ultimately found "System
> Preferences" > "Security & Privacy" > "Click the lock to make changes" >
> entered password > AND clicked to "Allow apps downloaded from: Anywhere".
> Then the install appeared to run and  proclaimed, "The installation was
> successful."  However, git is not listed under "Applications", and RStudio
> says, "Git was not detected on the system path."
>
>
> "README.txt" says I need "sudo mv /usr/bin/git /usr/bin/git-system".  I
> tried that and got, "mv: rename /usr/bin/git to /usr/bin/git-system:
> Operation not permitted" (after entering my password).  [My directory now
> includes "/usr/local/git", and "/usr/bin" includes git, git-cvsserver,
> git-receive-pack, git-shell, git-upload-archive, and git-upload-pack.]
>
>
> Suggestions?  Thanks, Spencer Graves
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
