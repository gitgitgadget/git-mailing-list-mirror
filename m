From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 2/2] Fix t4013 with commit date in mbox 'From COMMIT DATE' 
	header lines
Date: Fri, 16 Apr 2010 19:59:32 +0200
Message-ID: <o2jadf1fd3d1004161059z5b85989br9984fac87ac7e92b@mail.gmail.com>
References: <20100416075251.GA25147@arachsys.com>
	 <2b1d2ec748f3a28e7210f235df29703fd425e08a.1271436192.git.chris@arachsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Chris Webb <chris@arachsys.com>
X-From: git-owner@vger.kernel.org Fri Apr 16 19:59:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2ppN-000769-IR
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 19:59:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757306Ab0DPR7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 13:59:36 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:53800 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab0DPR7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Apr 2010 13:59:35 -0400
Received: by bwz25 with SMTP id 25so3445942bwz.28
        for <git@vger.kernel.org>; Fri, 16 Apr 2010 10:59:33 -0700 (PDT)
Received: by 10.103.11.8 with HTTP; Fri, 16 Apr 2010 10:59:32 -0700 (PDT)
In-Reply-To: <2b1d2ec748f3a28e7210f235df29703fd425e08a.1271436192.git.chris@arachsys.com>
Received: by 10.102.243.26 with SMTP id q26mr1306203muh.34.1271440772981; Fri, 
	16 Apr 2010 10:59:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145088>

It is better if you squash this patch into the earlier one, then the
tests always pass.

Santi

On Fri, Apr 16, 2010 at 6:42 PM, Chris Webb <chris@arachsys.com> wrote:
> Signed-off-by: Chris Webb <chris@arachsys.com>
> ---
> =A0t/t4013-diff-various.sh | =A0 =A03 ++-
> =A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index dae6358..ce42d3f 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -110,7 +110,8 @@ do
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "\$ git $cmd"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0git $cmd |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sed -e "s/^\\(-*\\)$V\=
\(-*\\)\$/\\1g-i-t--v-e-r-s-i-o-n\2/" \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -e "s/^\\(.*mix=
ed; boundary=3D\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -e "s/^\\(.*mix=
ed; boundary=3D\"-*\\)$V\\(-*\\)\"\$/\\1g-i-t--v-e-r-s-i-o-n\2\"/" \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -e "s/^\\(From =
[0-9a-f][0-9a-f]*\\) .*/\\1 Mon Sep 17 00:00:00 2001/"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0echo "\$"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} >"$actual" &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if test -f "$expect"
> --
> 1.7.0.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
