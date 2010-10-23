From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] Sync "git diff -h" with the manual, show options summary.
Date: Sat, 23 Oct 2010 16:02:49 -0200
Message-ID: <AANLkTi=kETrjKccdVo188mKjX59mWeCRLVwGpiVP-oQ1@mail.gmail.com>
References: <1287840825-6491-1-git-send-email-ydirson@altern.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Sat Oct 23 20:02:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9iQj-0004y2-1J
	for gcvg-git-2@lo.gmane.org; Sat, 23 Oct 2010 20:02:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab0JWSCv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Oct 2010 14:02:51 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:34939 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754665Ab0JWSCv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Oct 2010 14:02:51 -0400
Received: by bwz11 with SMTP id 11so1371518bwz.19
        for <git@vger.kernel.org>; Sat, 23 Oct 2010 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zSzdFL20ePb3J2UAfWhNz9PVbcfSTYzG0J7tP+SRznc=;
        b=HMg6FuclYxNs5Ob0Za8OWwP4f0d2g6awfa1uKDQ1n0wEV3Hnh/EBm7HLaj+SrJqxq+
         dCXDhIfWECcMCBap6I40VcjA2QZDN/uTZJPV0Sr0R+owGCqftH5J0vK4IrjPxq8mIP6Q
         G0KsG9Gn3/CJrzJlQ87siq2c4bjt/SdoCS+T0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FNfnYw1z9u0Na6erl+VVj98s/c5YVrXF3mJGPcR72Tl6QRbSnTUC4/raIC8r+zaJQP
         QbW6lK5ctQgoqTi5zEvyQCaoHlmbAmqJ7T/Y7dfqzKrv0SIM7En2gTAzgkVkDdOVWby2
         EBvNrJB4ZIfndrE6NY7Wgc1Kphas6SnSKVozw=
Received: by 10.204.80.97 with SMTP id s33mr3271755bkk.182.1287856969734; Sat,
 23 Oct 2010 11:02:49 -0700 (PDT)
Received: by 10.204.72.82 with HTTP; Sat, 23 Oct 2010 11:02:49 -0700 (PDT)
In-Reply-To: <1287840825-6491-1-git-send-email-ydirson@altern.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159803>

On Sat, Oct 23, 2010 at 11:33 AM, Yann Dirson <ydirson@altern.org> wrot=
e:
> Signed-off-by: Yann Dirson <ydirson@altern.org>
> ---
> =C2=A0builtin/diff.c | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/diff.c b/builtin/diff.c
> index a43d326..8736225 100644
> --- a/builtin/diff.c
> +++ b/builtin/diff.c
> @@ -22,7 +22,8 @@ struct blobinfo {
> =C2=A0};
>
> =C2=A0static const char builtin_diff_usage[] =3D
> -"git diff <options> <rev>{0,2} -- <path>*";
> +"git diff [<common diff options>] <commit>{0,2} -- <path>*"

Why change from <options> to <common diff options> ?
