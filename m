From: Marco Craveiro <marco.craveiro@gmail.com>
Subject: Re: Ignore on commit
Date: Fri, 5 Oct 2012 07:09:05 +0100
Message-ID: <CAKRNd4w1LPEBxhfRNzSwwFDQen_Sif+EYQXcAxnJPP6GU-Q5nw@mail.gmail.com>
References: <CAKRNd4w4Z-LS9O5ffkbTSZ0Guv4KCmWR=AtW3EpxQ2sSgazG=Q@mail.gmail.com>
	<506DEC50.7090402@obry.net>
	<CAKRNd4wbT_boRyFOOL_95FBW4ws8Zzz2ubVCfXuRSevzPdhW9g@mail.gmail.com>
	<CAH5451mpJw4+noUF+FkZJS+Y2oq2ThFeG7wSOCdbVaMQPNgUJA@mail.gmail.com>
	<CANgJU+XSYWObCsGVnWwaaSB9iZQnfU_y095uzEm5-YXMaUoU_w@mail.gmail.com>
	<CAMK1S_jfdW3BepELgPPoUf3qWwmU-o3o8OpMVimdfkERUJkymQ@mail.gmail.com>
	<CAH5451ki_JFntWZwxcUqvWKwZn62Vfg=MkF3xwiX1p3ARULQfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sitaram Chamarty <sitaramc@gmail.com>,
	demerphq <demerphq@gmail.com>, pascal@obry.net,
	git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 05 09:01:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TK1uc-0002NU-1w
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 09:01:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848Ab2JEHBU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2012 03:01:20 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:39684 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751672Ab2JEHBT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2012 03:01:19 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1406110oag.19
        for <git@vger.kernel.org>; Fri, 05 Oct 2012 00:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Vgmgr7/yjM5Ga4EOrQM8uho/DFkX8RGQ0XySEQFbCjU=;
        b=074aY7quoyDtW6F9EXkDE1iwSeUaOiG1HXMIOuntg3gCgNe3CAZjoq0o0x1bFzbd42
         vtylY2qkPMMfE/5hR9/7tm1Pf0fUShEmfvHaWMNq3GkpXIStkW67Nlu8KZUZ/cGI26R7
         u2+zI3W2UihaDDr8gS9+5SQqfqolr88NEEGZnLU4qNQBgpULtmBDIFiDz6P4omVRF01f
         J57v81iIjzqqw8CAl3ca0/Gl4ElTeKb4WtyWe9psEdEYO0ThqOdbgzykJLnNRTvnxgp+
         jgsEt0ncN7hruWRXXrNNwfo6NeJrdsvDyMH8hbKhkheT+5xMogAF1fuEs70zvGAuyP9x
         4H7A==
Received: by 10.60.12.42 with SMTP id v10mr6150323oeb.131.1349417345776; Thu,
 04 Oct 2012 23:09:05 -0700 (PDT)
Received: by 10.76.102.20 with HTTP; Thu, 4 Oct 2012 23:09:05 -0700 (PDT)
In-Reply-To: <CAH5451ki_JFntWZwxcUqvWKwZn62Vfg=MkF3xwiX1p3ARULQfA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207077>

<git update-index --assume-unchanged>
> From the help page:
>
> --assume-unchanged, --no-assume-unchanged
>     ...
>
>     This option can be also used as a coarse file-level mechanism to
> ignore uncommitted changes in tracked files (akin to what .gitignore
>     does for untracked files).
>
> Seems like it does everything required. I tested and it correctly
> hides changes that I want hidden. The only thing I can't see how to do
> is get git status to show files with the assume unchanged  bit set. I
> think there is no way currently, but that might be a nice addition to
> make the initial request feature complete. It could show either all
> files with the bit set, or files with the bit set that have been
> changed (or this could be configurable).

This is indeed the solution outlined in [4] on my original post:

http://gitready.com/intermediate/2009/02/18/temporarily-ignoring-files.html

The presence in git status is quite important or else one has to
change the regular workflow with a second status command.

Cheers

Marco
-- 
So young, and already so unknown -- Pauli

blog: http://mcraveiro.blogspot.com
