From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH] completion: complete --move for git branch
Date: Mon, 6 Jun 2016 16:16:29 +0200 (CEST)
Message-ID: <582640631.360243.1465222588996.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1465218971-14118-1-git-send-email-ville.skytta@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>
X-From: git-owner@vger.kernel.org Mon Jun 06 16:04:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9v93-00063i-1X
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jun 2016 16:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742AbcFFOEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 10:04:40 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:49993 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751118AbcFFOEk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 10:04:40 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 9EFEA2597;
	Mon,  6 Jun 2016 16:04:37 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-wU_Y19xjJy; Mon,  6 Jun 2016 16:04:37 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 8F2612591;
	Mon,  6 Jun 2016 16:04:37 +0200 (CEST)
In-Reply-To: <1465218971-14118-1-git-send-email-ville.skytta@iki.fi>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: completion: complete --move for git branch
Thread-Index: 902mD2prWI/KgsAoqtCM2jmQYddxQg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296511>

Hi,

Ville Skytt=C3=A4 <ville.skytta@iki.fi> writes:
>          while [ $c -lt $cword ]; do
>                  i=3D"${words[c]}"
>                  case "$i" in
> -                -d|-m)        only_local_ref=3D"y" ;;
> -                -r)        has_r=3D"y" ;;
> +                -d|-m|--move)        only_local_ref=3D"y" ;;

"While you're at it" you might want to do the same thing for
`--delete`.

> +                -r)                has_r=3D"y" ;;

You are introducing an additional tab here that you probably didn't
want.

>                  esac
>                  ((c++))
>          done
> @@ -979,7 +979,7 @@ _git_branch ()
>                          --color --no-color --verbose --abbrev=3D --n=
o-abbrev
>                          --track --no-track --contains --merged --no-=
merged
>                          --set-upstream-to=3D --edit-description --li=
st
> -                        --unset-upstream
> +                        --unset-upstream --move
>                          "
>                  ;;
>          *)

Thanks,
R=C3=A9mi
