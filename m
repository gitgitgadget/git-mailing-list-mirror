From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] githooks.txt: Improve the intro section
Date: Mon, 25 Apr 2016 01:35:43 -0400
Message-ID: <CAPig+cRYBChNVT2cixdzMCvO36Np-RdvTuccFshRoUDWnJv1Rw@mail.gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 07:35:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auZBV-0007d2-RL
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 07:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752738AbcDYFfo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Apr 2016 01:35:44 -0400
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35735 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbcDYFfo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2016 01:35:44 -0400
Received: by mail-ig0-f195.google.com with SMTP id fn8so9700988igb.2
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 22:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=3m3pySOCAxhuN7IQw0XvB+sMvQUnPg/zsLcmQmqzOuo=;
        b=rV0aGg8xks6pXuqoGxNGP2RyZNOntsgNkKwX4P66cgKL6mpbZ/xCGwSJya2R0KJ05f
         mUoRp1gpqNBHaiuc1IJpcDKETRpR8mhuWUj5k7Z85CZ7wWiGj0WitXF8vOJ0BrTZWmTU
         I0jO7ZJhccafX8uNfaC+p1LimCXwlaiGLsMO1b4xZMSKS0v6WIi66wr4IAp7ZWmwt8uX
         P+2W77ytxCdexLYSUJIL/cGmWiSfpb59Vg0kYb59WLPFNJNcwKbkmGWV8uZWDRXNnNlg
         NgSA+O6SKjw+Ffr5QvDLM9FKLVDSFAs+ACzZk+J8n4cC9BAKBeKXwapmKRU3fi14bTIh
         ZfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=3m3pySOCAxhuN7IQw0XvB+sMvQUnPg/zsLcmQmqzOuo=;
        b=FE076tpZ9pHifiqwiI9Pp46pJg3ZlzcK3gniA71sgE2w87N2SGL6vZWZ3SyztjINMH
         nXLFAmpRbceu7DKtYEAB6s+GxKyjPAvdPBX8pw5PGkB8UAFNd976gGDyOF+/Zza29IFn
         x6q5wV4NBqgV+mtrrfDT8xqbZNHKULLs0iVxQCYGTbjA2vB8hHLwR1cohEUfBihGqFUx
         kvF5/utH1UB+rREv3a6Ct2KhCmFPvft/UMBUBbjmRoODDE4Ms2LNz1VUJgrTME0edBH6
         yiMrM9JGl2n2FwbiE4K2otXjNWx4BCapTS6MzNQ3Rvv1uMK4Yh9cJAfyRwM4Jp2ahAmd
         l62A==
X-Gm-Message-State: AOPr4FUxcTBNfjK0O8D+ZICX2xQSKIkTuVjO0gZUMISa3QAVuQyd2gq24ifRqlgsMcvPRB72TPOdY0e9AXASEg==
X-Received: by 10.50.49.15 with SMTP id q15mr9769751ign.73.1461562543484; Sun,
 24 Apr 2016 22:35:43 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Sun, 24 Apr 2016 22:35:43 -0700 (PDT)
In-Reply-To: <1461529229-15222-1-git-send-email-avarab@gmail.com>
X-Google-Sender-Auth: IjJmu2i_Mk3R4gnEMOOC8LulKc4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292450>

On Sun, Apr 24, 2016 at 4:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change the documentation so that:
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
> @@ -130,7 +130,11 @@ The template directory will be one of the follow=
ing (in order):
>  The default template directory includes some directory structure, su=
ggested
> -"exclude patterns" (see linkgit:gitignore[5]), and sample hook files=
 (see linkgit:githooks[5]).
> +"exclude patterns" (see linkgit:gitignore[5]), and example hook file=
s.
> +
> +The example are all disabled by default. To enable a hook, rename it

s/example/examples/

> +by removing its `.sample` suffix. See linkgit:githooks[5] for more
> +info on hook execution.
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> @@ -13,18 +13,26 @@ $GIT_DIR/hooks/*
> +Hooks are programs you can place in the `$GIT_DIR/hooks` directory t=
o
> +trigger action at certain points. Hooks that don't have the executab=
le
> +bit set are ignored.
> +
> +When a hook is called in a non-bare repository the working directory
> +is guaranteed to be the root of the working tree, in a bare reposito=
ry
> +the working directory will be the path to the repository. I.e. hooks
> +don't need to worry about the user's current working directory.
> +
> +Hooks can get their arguments via the environment, command-line
> +arguments, and stdin. See the documentation for each below hook for
> +details.
> +
> +When 'git init' is run it may depending on its configuration copy

s/may/&,/
s/configuration/&,/

> +hooks to the new repository, see the the "TEMPLATE DIRECTORY" sectio=
n
> +in linkgit:git-init[1] for details. When the rest of this document
> +refers to "default hooks" we're talking about the default template
> +shipped with Git.
> +
> +The currently supported hooks are described below.
