From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [PATCH] INSTALL: minor typo fix
Date: Wed, 28 Jan 2015 06:09:52 +1300
Message-ID: <CAFOYHZBiMvU5=EpX7qn0wwrUwfZ2xzATKqRo4zPH+xmro7wVbA@mail.gmail.com>
References: <1422375312-3798-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, GIT <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 18:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG9eI-0007Hn-I4
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 18:09:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409AbbA0RJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 12:09:54 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:33058 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbbA0RJx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 12:09:53 -0500
Received: by mail-pd0-f181.google.com with SMTP id g10so19915769pdj.12
        for <git@vger.kernel.org>; Tue, 27 Jan 2015 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=to4LmuCzAtimbeeYezB0juA2TNzqfxfKQf6TypnmzXM=;
        b=pDE6Eu0WoUyhKQdGB849/jiaJ/bllYSuypstaJmVeK1caTLA+s5DLDThXZItDFUfNE
         sgm2EVpp3punNBuC54csSOu4IPzcNN7360et2EjvBtZ6Cqc4gtuRcW7zP8NGduD+gl/I
         rE7QSgJAYK//dw61N3uL1/WByYg4H89KAgXkZcVatdxvSeYrBM9jXfG3sutdKQ7RKO21
         FOKvjeqtdI9e0lA+7YLUTHLsQbgOVlVAn1L8bjt+ZqBuuqOFRXaGzDD4tDyzRpVLn/9t
         YgTN9YKS1E5U+WHsMPxWFE2ljycWBgdH07lxEmJApHKjQCXwnTppymAMU2qqy9z6wtK0
         B4AA==
X-Received: by 10.68.226.131 with SMTP id rs3mr4007808pbc.24.1422378592272;
 Tue, 27 Jan 2015 09:09:52 -0800 (PST)
Received: by 10.70.109.199 with HTTP; Tue, 27 Jan 2015 09:09:52 -0800 (PST)
In-Reply-To: <1422375312-3798-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263077>

Hi Alexander

On Wed, Jan 28, 2015 at 5:15 AM, Alexander Kuleshov
<kuleshovmail@gmail.com> wrote:
> Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
> ---
>  INSTALL | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/INSTALL b/INSTALL
> index ffb071e..6f1c3d5 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -53,7 +53,7 @@ or
>
>  As a caveat: a profile-optimized build takes a *lot* longer since the
>  git tree must be built twice, and in order for the profiling
> -measurements to work properly, ccache must be disabled and the test
> +measurements to work properly, cache must be disabled and the test
>  suite has to be run using only a single CPU.  In addition, the profile
>  feedback build stage currently generates a lot of additional compiler
>  warnings.
> --

That's not a typo ccache[1] is a compiler cache tool that can be used
to speed up rebuilding object files. I don't know anything about the
profile enabled builds but I imagine it has something to do with
needing the 2nd build to produce difference object files from the
first (with ccache enabled I imagine the 2nd build would result in
identical output since on source files are changed between builds).

--
[1] - https://ccache.samba.org/
