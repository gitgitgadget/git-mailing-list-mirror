From: Stefan Beller <sbeller@google.com>
Subject: Re: gitk: "lime" color incompatible with older Tk versions
Date: Mon, 2 May 2016 09:20:43 -0700
Message-ID: <CAGZ79kaO9T+Qc=M6s_ZdpAfLZCVQEYNF=zNxDWArDmsA7jjCWg@mail.gmail.com>
References: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Janke <floss@apjanke.net>, Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon May 02 18:20:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axGaY-0002HI-9p
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 18:20:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbcEBQUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 12:20:47 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:33652 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbcEBQUo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 12:20:44 -0400
Received: by mail-io0-f169.google.com with SMTP id f89so172366050ioi.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 09:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=pSuWezxXGzDGFZw+qITTOy10yaNxosX2PSJjAS0WPVQ=;
        b=pbfEB1JCGPfgj8krufXuykh6CxgijQh/qfI0majubQ/D2pQ4gf5ZAA8wByEbrX/gfz
         46ooTvi5Q5hMG5mvsqZDHfy+SsTz0Pniu1C5N/j4SAL5aV16+6mi0NjLdkVeVI1wwug9
         OAWlr4J5JpwHcr8f3VPr6J5spnMpRedNnIYEyWjFucHTKI+lUjJp735NN0jJVS1RMwq6
         2VmAJmwPnkNfY/mvSaBEEZ37z8Q2yT8rFeu25IG8fN2S2P1g11z282leNFlx90pcQfnm
         rkypT8FyhqMnVw/ubqv9G8Xw3/zywu7cJIatLPIkxUzMXujCccJALlak75F21AoBjHn8
         2ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pSuWezxXGzDGFZw+qITTOy10yaNxosX2PSJjAS0WPVQ=;
        b=J9xHgB6/3SW4c7DF6lckJC33UgEBTWvNpQm3Y/jAYIRnwD4ubQWqUiHzofIDR9FL5f
         u0ImS5OLTh2OEEiEGmWuZaa1wBz6Kmbxw87P6neniII300zvMXK0SaX+PdtJFSMQRyah
         rni7sXyBQfaGKh/OgmBDB/nLJd64I8J1K7Lfcz91Na9bQGDIUNHNEJymWn8ims0nQ21D
         oyMs8XGPNl2Qr9BsyrMIKghzm4BtG8cah81Lv5PgBA5o8kInwECSY7U8Gc7RMbRQ3KIV
         sc8ZZjA8mhD4PEAntvvzkH9B9oeJhQMI7oxv9ksP/QjQ7qNtkvVyqFrKlZz/5sM0/DtV
         yvXQ==
X-Gm-Message-State: AOPr4FVlbEig5Lwcr5Qf+e27zoatMDm0ar9YFmWHRYG1feTrzxJ8DdhPK4z+TwqxE31fQPxEAJh/+2C2LKfU9b4u
X-Received: by 10.107.161.68 with SMTP id k65mr46019927ioe.110.1462206043872;
 Mon, 02 May 2016 09:20:43 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 2 May 2016 09:20:43 -0700 (PDT)
In-Reply-To: <03babaa1-9011-0010-c4b3-6cad8109d3ab@apjanke.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293239>

+ Paul Mackerras, who maintains gitk

On Sun, May 1, 2016 at 10:03 AM, Andrew Janke <floss@apjanke.net> wrote:
> Hi, git folks,
>
> I'm having trouble running gitk on Mac OS X 10.9.5. The gitk program uses
> the color "lime", which is not present in older versions of Tk, apparently
> including the Tk 8.5 which ships with 10.9.
>
> When I try to launch it, I get this error.
>
> |$ gitk Error in startup script: unknown color name "lime" (processing
> "-fore" option) invoked from within "$ctext tag conf m2 -fore [lindex
> $mergecolors 2]" (procedure "makewindow" line 347) invoked from within
> "makewindow" (file "/usr/local/bin/gitk" line 12434)|
>
> This compatibility problem was noted before back in 2012, in
> http://www.mail-archive.com/git%40vger.kernel.org/msg14496.html.
>
> Would you consider switching from lime to a hex value color, for
> compatibility with users of older versions of Tk? A patch to do so is below;
> only the file gitk-git/gitk needs to be changed.
>
> Cheers,
> Andrew Janke
>
>
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index 805a1c7..db5560d 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -2265,7 +2265,7 @@ proc makewindow {} {
>      set h [expr {[font metrics uifont -linespace] + 2}]
>      set progresscanv .tf.bar.progress
>      canvas $progresscanv -relief sunken -height $h -borderwidth 2
> -    set progressitem [$progresscanv create rect -1 0 0 $h -fill lime]
> +    set progressitem [$progresscanv create rect -1 0 0 $h -fill "#99FF00"]
>      set fprogitem [$progresscanv create rect -1 0 0 $h -fill yellow]
>      set rprogitem [$progresscanv create rect -1 0 0 $h -fill red]
>      }
> @@ -3397,7 +3397,7 @@ set rectmask {
>         0x00, 0x00, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f,
>         0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0xfc, 0x0f, 0x00, 0x00};
>  }
> -image create bitmap reficon-H -background black -foreground lime \
> +image create bitmap reficon-H -background black -foreground "#99FF00" \
>      -data $rectdata -maskdata $rectmask
>  image create bitmap reficon-o -background black -foreground "#ddddff" \
>      -data $rectdata -maskdata $rectmask
> @@ -12188,7 +12188,7 @@ if {[tk windowingsystem] eq "aqua"} {
>      set extdifftool "meld"
>  }
>
> -set colors {lime red blue magenta darkgrey brown orange}
> +set colors {"#99FF00" red blue magenta darkgrey brown orange}
>  if {[tk windowingsystem] eq "win32"} {
>      set uicolor SystemButtonFace
>      set uifgcolor SystemButtonText
> @@ -12206,12 +12206,12 @@ if {[tk windowingsystem] eq "win32"} {
>  }
>  set diffcolors {red "#00a000" blue}
>  set diffcontext 3
> -set mergecolors {red blue lime purple brown "#009090" magenta "#808000"
> "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070" "#ff70b0"}
> +set mergecolors {red blue "#99FF00" purple brown "#009090" magenta
> "#808000" "#009000" "#ff0080" cyan "#b07070" "#70b0f0" "#70f0b0" "#f0b070"
> "#ff70b0"}
>  set ignorespace 0
>  set worddiff ""
>  set markbgcolor "#e0e0ff"
>
> -set headbgcolor lime
> +set headbgcolor "#99FF00"
>  set headfgcolor black
>  set headoutlinecolor black
>  set remotebgcolor #ffddaa
> @@ -12226,7 +12226,7 @@ set linehoverfgcolor black
>  set linehoveroutlinecolor black
>  set mainheadcirclecolor yellow
>  set workingfilescirclecolor red
> -set indexcirclecolor lime
> +set indexcirclecolor "#99FF00"
>  set circlecolors {white blue gray blue blue}
>  set linkfgcolor blue
>  set circleoutlinecolor $fgcolor
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
