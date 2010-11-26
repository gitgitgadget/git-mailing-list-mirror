From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 1/5] cache.h: remove surrounding brackes and realign CE_* constants
Date: Fri, 26 Nov 2010 17:20:11 -0200
Message-ID: <AANLkTinwP=tDYyeyjX8uUChtvOeVmT4QfZjxT0A67hop@mail.gmail.com>
References: <1290795467-7570-1-git-send-email-pclouds@gmail.com>
	<1290795467-7570-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Niedier <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 20:20:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PM3qK-0001FC-Sx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 20:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755342Ab0KZTUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Nov 2010 14:20:15 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64911 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752509Ab0KZTUO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Nov 2010 14:20:14 -0500
Received: by bwz15 with SMTP id 15so2100948bwz.19
        for <git@vger.kernel.org>; Fri, 26 Nov 2010 11:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GN3M2bP0Gyrn3c5agSlB1ZwiNGu4rrfk3bAt9Tj1rgk=;
        b=vXkHqG/WehQI/fQ0RayAjoGu5gpzg9CJ/WCcN7I5M03+MS02TKL//DSsd7VNnPpAXT
         Xhc7lEo6OoRf2IIpytQ87PZiM0zUiOLKsiq214MoZPhxAu52yIFPtv2tA0+lQNfwVVM3
         wRvUN8PyUPEauAQKrGRjUqXxtBql9EQbqZubM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=iyMi35lmSg9dkP6ny8yjWpPAoE3W+GDuqt6RgfOrOfY74q3/V39fC7asWqUyM0JWx7
         ArsK3qyJ8AZ5MkxYRwjX3II6YOhGpiCjSnDw7xD1lyqAlgWneq7c8Hf0ZXaZNCJeS4hJ
         71Q3yo0TVO79dxycQ1zBmahCwTeJzlCgmX0iA=
Received: by 10.204.114.141 with SMTP id e13mr2315398bkq.94.1290799211567;
 Fri, 26 Nov 2010 11:20:11 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Fri, 26 Nov 2010 11:20:11 -0800 (PST)
In-Reply-To: <1290795467-7570-2-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162276>

2010/11/26 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> =C2=A0cache.h | =C2=A0 25 ++++++++++++-------------
> =C2=A01 files changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 33decd9..4819cf5 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -170,26 +170,25 @@ struct cache_entry {
> =C2=A0*
> =C2=A0* In-memory only flags
> =C2=A0*/
> -#define CE_UPDATE =C2=A0 =C2=A0(0x10000)
> -#define CE_REMOVE =C2=A0 =C2=A0(0x20000)
> -#define CE_UPTODATE =C2=A0(0x40000)
> -#define CE_ADDED =C2=A0 =C2=A0 (0x80000)
> +#define CE_UPDATE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
10000
> +#define CE_REMOVE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
20000
> +#define CE_UPTODATE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x40000
> +#define CE_ADDED =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
80000
>
Thanks for fixing this. Maybe these hex can be rewriting as 1 << 0, 1
<< 1 and so on?
