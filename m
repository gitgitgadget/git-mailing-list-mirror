From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] trace.c: mark file-local function static
Date: Thu, 16 Dec 2010 21:43:50 -0200
Message-ID: <AANLkTimBtpOx_GBzC=g4V6jW2aiF7Hg8uALWt2NQFFZG@mail.gmail.com>
References: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Vasyl'" <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 00:49:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTNZn-0003iL-9Y
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 00:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753143Ab0LPXta convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Dec 2010 18:49:30 -0500
Received: from mail-bw0-f42.google.com ([209.85.214.42]:58718 "EHLO
	mail-bw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab0LPXt3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 18:49:29 -0500
X-Greylist: delayed 337 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2010 18:49:28 EST
Received: by bwz13 with SMTP id 13so303443bwz.1
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b8emJK/uKdhps1Gda28ToNKJlTEXqeP1WxgYyFFpqTA=;
        b=dtRfN8in9Oa1hEYi8+9ryLpUoQBWiH+wRX6cZljSMyhgnF/amXo8FORpVKs0+x+Ubm
         TWnPsNOmjWE6MUNuGQj1J174YoynBRScHupw0D142sSOWER5so+ekR8R33RKysqziwUv
         EU9kZiKIFkiCHv/yz1XlBjETsq2z6Cd01qssw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VVx0lqmxlikgCmtBKWkfEEJ6rUa3hWiO6UYmR4VgkecKI5Yas1vM5W0sRgp4IdyJxl
         nOaMbxIjrUe0ie/J/VEjVI63Aupgep5CeQGcUKq87qczAxIirX+1Jg1dAYKPO/k1RUcE
         f6BDUOp8BFp9004dMYfLff999YwvzYYxf3zy8=
Received: by 10.204.59.76 with SMTP id k12mr71916bkh.70.1292543030243; Thu, 16
 Dec 2010 15:43:50 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Thu, 16 Dec 2010 15:43:50 -0800 (PST)
In-Reply-To: <AANLkTinxJdASW6mQVU50grA2mUz6gt+gUND30VRK=BCN@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163841>

On Thu, Dec 16, 2010 at 8:38 PM, Vasyl' <vvavrychuk@gmail.com> wrote:
> Signed-off-by: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
> ---
> =C2=A0trace.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/trace.c b/trace.c
> index 1e560cb..62586fa 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -25,7 +25,7 @@
> =C2=A0#include "cache.h"
> =C2=A0#include "quote.h"
>
> -void do_nothing(size_t unused)
> +static void do_nothing(size_t unused)
> =C2=A0{
> =C2=A0}
>
If it means something, this looks sane to me.

Acked-by: Thiago Farina <tfransosi@gmail.com>

> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
