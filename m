From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/4] api-builtin.txt: explain common command groups
Date: Sun, 3 May 2015 16:02:07 -0400
Message-ID: <CAPig+cT0aurG9gS2CrwMPG2B4xrAbhvwNJtAjYz7UYc4x1TiEA@mail.gmail.com>
References: <554405D5.9080702@gmail.com>
	<55456990.6000509@gmail.com>
	<55456AD3.7090908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 03 22:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yp05d-00019q-Vc
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 22:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbbECUCK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 May 2015 16:02:10 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36668 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618AbbECUCI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 May 2015 16:02:08 -0400
Received: by iebrs15 with SMTP id rs15so118094784ieb.3
        for <git@vger.kernel.org>; Sun, 03 May 2015 13:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=pvNKXk7ZIkUauVbeZVbs8z2o+PPxmKkt2aSTmNurSkQ=;
        b=dMlK4Z0FnGV08buugjOKR6mubFnVHUfPUPmVLDGJDtu1hiATC0WM9ROxRkl+4kI97O
         IKx1edJ6s2xznsI1jMN0MpisQqv+JPjHkGcZQKhuutzaIaeLu0uaebr2KN4tzoE59vK9
         A2+GpsN7tOj4h9nT9EhAilSHnoF8Ax/1OJ//U/ZcTUR4OTLPliJ8pRnmmt1q6mRZ1bKd
         6aih9rchdoaAqE3k48ZhkswpgMXGVzFJyNYKviGtPBKqbzU+n6nc4/7E+7l6Eb92+eaH
         127sqwVMrxkgjRNYBnCSJiw6Yen8B+GZ7HT2LGdWrHR4rCYo3MbN2Q6kb/6JuRGDBwTq
         pCaA==
X-Received: by 10.42.207.206 with SMTP id fz14mr24958613icb.34.1430683327793;
 Sun, 03 May 2015 13:02:07 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 3 May 2015 13:02:07 -0700 (PDT)
In-Reply-To: <55456AD3.7090908@gmail.com>
X-Google-Sender-Auth: OmMenQKLO19TQYIcxHPCd5uA6Gc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268288>

On Sat, May 2, 2015 at 8:24 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Update api-builtin.txt to explain how to add the group information
> for common commands.
>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
> ---
> diff --git a/Documentation/technical/api-builtin.txt
> b/Documentation/technical/api-builtin.txt
> index 22a39b9..76baba8 100644
> --- a/Documentation/technical/api-builtin.txt
> +++ b/Documentation/technical/api-builtin.txt
> @@ -50,7 +50,11 @@ Additionally, if `foo` is a new command, there are=
 3 more
> things to do:
>   . Write documentation in `Documentation/git-foo.txt`.
>  -. Add an entry for `git-foo` to `command-list.txt`.
> +. Add an entry for `git-foo` to `command-list.txt`. If foo is consid=
ered
> +  a 'common' command, add 'common-x_group' as the third value,
> +  where x_group is one of the existing themes:
> +
> +       git-foo        mainporcelain common-3_worktree
>   . Add an entry for `/git-foo` to `.gitignore`.

Unfortunately, this change breaks Asciidoc formatting by making the
following ".Add an entry..." item get glued to the new "git-foo..."
example. Fix by inserting a blank line after the "git-foo...". (And
try formatting it yourself to ensure that it is working as expected.)

=46inally, all of your patches are whitespace-damaged and fail to apply
to the code-base. Did you paste them into your email client or some
such? If possible, try to send patches via git-send-email since it
does a good job of protecting against whitespace and other types of
damage.
