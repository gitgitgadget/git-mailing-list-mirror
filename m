From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] Add new git-cc-cmd helper to contrib
Date: Sun, 11 Nov 2012 22:48:31 +0530
Message-ID: <CALkWK0ksDBbWfxbT=PbKiWaC87vghTADPqcy+ujgJ9iZOVZv0w@mail.gmail.com>
References: <1352653804-2203-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 18:19:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXbBi-0004lt-Ro
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 18:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753271Ab2KKRS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 12:18:59 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58732 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753170Ab2KKRS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 12:18:59 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so3679814wgb.1
        for <git@vger.kernel.org>; Sun, 11 Nov 2012 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MLuIv1oM6c1dnWUsi15HtO5IuB81MvHkfkhVMfCgfkI=;
        b=vIxqD0IsidDK+s3gFfFIAq69m7mCWO75X3D5T92UAOULFlTeE1QZ3dtOeCoNGHuvxw
         gZ4NMHRZ8EXccIEhxxWTAOwhUcTkokqyBHgFKzqORRqLUASifHStD4pJtLwtTviTqC0l
         JdfE/2AxTZGG9J7QtZZD8WwkWQp7PyalMQlKCRDTdJ5ddjnMPUi9vELOMBpyAKTrrIOg
         oo4NcLuL1M8+uOasZnT0sMIkGWe4kl9uY5exiRgACul1D+8HoV/+jCZ/7k+saSZD4/Bn
         QFynsMjpKt8Hik4PPS4Wixg/DzM3d88+LTmvWNTU4LfX5IIS160GXkqk4gHB6nL/ptSp
         E7Kg==
Received: by 10.180.95.201 with SMTP id dm9mr11431907wib.3.1352654337568; Sun,
 11 Nov 2012 09:18:57 -0800 (PST)
Received: by 10.217.61.2 with HTTP; Sun, 11 Nov 2012 09:18:31 -0800 (PST)
In-Reply-To: <1352653804-2203-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209424>

Hi Felipe,

Felipe Contreras wrote:
> The code finds the changes in each commit in the list, runs 'git blame'
> to see which other commits are relevant to those lines, and then adds
> the author and signer to the list.
>
> Finally, it calculates what percentage of the total relevant commits
> each person was involved in, and if it passes the threshold, it goes in.

This is very cool.

> diff --git a/contrib/cc-cmd/git-cc-cmd b/contrib/cc-cmd/git-cc-cmd
> new file mode 100755
> index 0000000..17b14d4
> --- /dev/null
> +++ b/contrib/cc-cmd/git-cc-cmd
> @@ -0,0 +1,186 @@
> +#!/usr/bin/env ruby

Just out of curiosity, why didn't you write it in Python?  (I noticed
that you wrote remote-hg and remote-bzr in Python, and assumed that it
was your preferred language)

> +$alias_file = "~/.mutt/aliases"

Please read sendemail.aliasfiletype instead of assuming mutt.

Ram
