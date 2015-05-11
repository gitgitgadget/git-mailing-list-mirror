From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/6] new-command.txt: mention the common command groups
Date: Mon, 11 May 2015 02:47:00 -0400
Message-ID: <CAPig+cTwRawmrX2MHyUhC9Dm3CaCGANZdgOV=TKJ3Fqx2OWwXQ@mail.gmail.com>
References: <1431191856-10949-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431191856-10949-6-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 08:47:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrhUZ-0000mS-Vt
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 08:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbbEKGrD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 May 2015 02:47:03 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35456 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbbEKGrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 May 2015 02:47:01 -0400
Received: by ieczm2 with SMTP id zm2so100973899iec.2
        for <git@vger.kernel.org>; Sun, 10 May 2015 23:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=5auvaw/IwXzDAn5inYOcEV5RNYEW6TyKpIlQBzhMycw=;
        b=UmQwZaX2Jj58YpyZiKjfnBDYzKzzALmIH3yTIahCS5mrZ1ALJddu1B2XwaKXV6jHW2
         /auClvN34O30POr9J+Kdyqu6euZrHAHR2hHS9R068s9Wy/2IWXW57Erh8qIf+Gx3shTD
         PZa8Z83Z9yfQBWpsSNzWPu3+6W0QBSzyn+OczBoine6b+8/QFCbClRU2yRC7va0v3wme
         o345S6HqUnI3WBAdOZ+Y56roysrpisVmjCX64QBrNsu7Cirf1AnHBsZl3kfs8v7AbiSI
         LAnDLSzrsxoUo9WqwPnH9/2EXSoqPykfHH3Y8tQqg4h2dt2QC3/EHHK0KkBS9nHjJWpU
         gUew==
X-Received: by 10.50.66.230 with SMTP id i6mr11302315igt.22.1431326820428;
 Sun, 10 May 2015 23:47:00 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 10 May 2015 23:47:00 -0700 (PDT)
In-Reply-To: <1431191856-10949-6-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: KB-Rm9mNNG3dSUHs02d6BZkThfs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268761>

On Sat, May 9, 2015 at 1:17 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> In the 6. step, add information about the common group commands
> found in command-list.txt.

I don't feel too strongly about it, but as this is such a minor
change, and as it is directly related to the addition of the [common]
second in command-list.txt, it also would make sense just to fold this
change into the patch which introduces [common] (that is, v5 patch
3/6).

> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Documentation/howto/new-command.txt b/Documentation/howt=
o/new-command.txt
> index d7de5a3..e7b0cc2 100644
> --- a/Documentation/howto/new-command.txt
> +++ b/Documentation/howto/new-command.txt
> @@ -95,7 +95,9 @@ your language, document it in the INSTALL file.
>  that categorizes commands by type, so they can be listed in appropri=
ate
>  subsections in the documentation's summary command list.  Add an ent=
ry
>  for yours.  To understand the categories, look at git-commands.txt
> -in the main directory.
> +in the main directory. If the new command is part of the typical Git
> +workflow and you believe it's common enough to be mentioned in
> +'git help', map this command to a common group in the column [common=
]
>
>  7. Give the maintainer one paragraph to include in the RelNotes file
>  to describe the new feature; a good place to do so is in the cover
> --
> 2.4.0
