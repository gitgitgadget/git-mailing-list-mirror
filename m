From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/3] githooks.txt: Amend dangerous advice about 'update'
 hook ACL
Date: Sun, 24 Apr 2016 13:32:39 -0700
Message-ID: <CA+P7+xqveyG7RTWb2k8UsFWRwjvM6JJkveRr3NV-bammqSkpkQ@mail.gmail.com>
References: <1461529229-15222-1-git-send-email-avarab@gmail.com> <1461529229-15222-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 24 22:33:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auQiH-00048h-E0
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 22:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146AbcDXUdA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Apr 2016 16:33:00 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:36068 "EHLO
	mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbcDXUdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2016 16:33:00 -0400
Received: by mail-oi0-f42.google.com with SMTP id x201so160050237oif.3
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VyrFfbsbzxPsxcebqVH7x9Cjw6NZQTanhBXSW/dxmdc=;
        b=NPQpeXbcn8tkmp37o7nUoHywhSnmubTpOidnB2pGGBFAdudOwQnRbM8xgKu1qDGGJm
         9uYYpKaC584zcvp1CI9oznY2ISaw+QyjUGnwkSMO5FarebrRK5trHh8czr18NuVrc8TL
         HlUKPiogEvTVzrPSSyIvg1ZRxu+wLJJKCYfbbW/Lp8w/pM5tkp+f/ANL8ZlWB88OUhAH
         KGWyMa6VUAnGs5aBB4tYQOnTpBFl45o7lVR4Hf5vXE5Eaj80Rzv4xeE6Xzg1TXJRaHci
         Bht/gPFQW+JaiM64eM8fC+Xrn2AV18iger04E9BOF+jlyYszY6kHmEw3Y+pINse3blGi
         AEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VyrFfbsbzxPsxcebqVH7x9Cjw6NZQTanhBXSW/dxmdc=;
        b=X4EZwpL9E4W25gtozDjgz62PEM1iUAahAn8qb8ybHzPeTybzWiWaH9y2l2M+HHtEiR
         fP0glfBobJXnwMR6r7fOGhNKYxChOKUFxTcsg32KyLckxK52HvQYOqz+35wb1XQgkZVM
         oNVnuE2Jz47914z1+/ijqfiBcJVdJcTpC1AGk8aZEaOEFRzFNyQ0/xsj9fNubvFiVz0k
         51KeBFut8+wxbjw4FAqzWVIdVbxeahCdzqikkO+uw8sWhVNXk9+fBgYTbUvTmbpbr1+K
         YQO0FMzD9Ec+Z1R1a0mYwshh9ugWGLcGA0Qm8vXSVwRGhLg60Z80Jz/Uh0YoH2aWB9UE
         mOLg==
X-Gm-Message-State: AOPr4FUfAgj/KWzZ7h7bZehrkzF2MTMDKQ7VMtQnJvHwR2jxnkIiVukJTKHZ3S8yr7RVDBJ63YDY2QGLmshn9Q==
X-Received: by 10.157.49.1 with SMTP id e1mr10748571otc.148.1461529979064;
 Sun, 24 Apr 2016 13:32:59 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Sun, 24 Apr 2016 13:32:39 -0700 (PDT)
In-Reply-To: <1461529229-15222-2-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292441>

On Sun, Apr 24, 2016 at 1:20 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Any ACL you implement via an 'update' hook isn't actual access contro=
l
> if the user has login access to the machine running git, because they
> can trivially just built their own git version which doesn't run the
> hook.
>
> Change the documentation to take this dangerous edge case into accoun=
t,
> and remove the mention of the advice originating on the mailing list,
> the users reading this don't care where the idea came up.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.c=
om>
> ---
>  Documentation/githooks.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 2f3caf7..e9d169e 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -275,9 +275,13 @@ does not know the entire set of branches, so it =
would end up
>  firing one e-mail per ref when used naively, though.  The
>  <<post-receive,'post-receive'>> hook is more suited to that.
>
> -Another use suggested on the mailing list is to use this hook to
> -implement access control which is finer grained than the one
> -based on filesystem group.
> +Another use for this hook to implement access control which is finer
> +grained than the one based on filesystem group. Note that if the use=
r
> +pushing has a normal login shell on the machine receiving the push
> +implementing access control like this can be trivially bypassed by
> +just using not executing the hook. In those cases consider using

"by just using not executing the hook."

This grammar doesn't make sense. It doesn't quite match what you said
in the commit message either.

> +e.g. linkgit:git-shell[1] as the login shell to restrict the user's
> +access.
>
>  Both standard output and standard error output are forwarded to
>  'git send-pack' on the other end, so you can simply `echo` messages
> --
> 2.1.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
