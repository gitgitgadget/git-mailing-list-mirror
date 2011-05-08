From: "Bernhard R. Link" 
	<brl+ccmadness@pcpool00.mathematik.uni-freiburg.de>
Subject: Re: [PATCH 16/48] i18n: git-pull eval_gettext + warning message
Date: Sun, 8 May 2011 18:52:54 +0200
Message-ID: <20110508165254.GA20654@pcpool00.mathematik.uni-freiburg.de>
References: <1304857280-14773-1-git-send-email-avarab@gmail.com> <1304857280-14773-17-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 18:53:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJ7E5-00078Y-MV
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 18:53:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab1EHQw5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 12:52:57 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:39984
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751856Ab1EHQw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 12:52:56 -0400
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1QJ7Dy-0007a8-MS; Sun, 08 May 2011 18:52:54 +0200
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1QJ7Dy-0005No-KH; Sun, 08 May 2011 18:52:54 +0200
Content-Disposition: inline
In-Reply-To: <1304857280-14773-17-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173161>

* =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> [110508 14:23]:
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>
> ---
>  git-pull.sh |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/git-pull.sh b/git-pull.sh
> index 06dcd81..79ba9ab 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -217,9 +217,9 @@ then
>  	# $orig_head commit, but we are merging into $curr_head.
>  	# First update the working tree to match $curr_head.
> =20
> -	echo >&2 "Warning: fetch updated the current branch head."
> -	echo >&2 "Warning: fast-forwarding your working tree from"
> -	echo >&2 "Warning: commit $orig_head."
> +	echo >&2 "$(eval_gettext "Warning: fetch updated the current branch=
 head.
> +Warning: fast-forwarding your working tree from
> +Warning: commit \$orig_head.")"

echo "$(...)"

sounds quite wasteful and harder to read than necessary.
The same also happens in later patches.
