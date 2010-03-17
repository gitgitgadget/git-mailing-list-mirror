From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH 01/16] xdl_merge(): add optional ancestor label to 
	diff3-style output
Date: Wed, 17 Mar 2010 15:22:52 +0100
Message-ID: <36ca99e91003170722m6642ca5q93b2669feaf3dea2@mail.gmail.com>
References: <20100317113655.GA25470@progeny.tock>
	 <20100317114653.GA25641@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Monnier <monnier@iro.umontreal.ca>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 15:23:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nru9E-0007Q9-8N
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 15:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab0CQOWy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Mar 2010 10:22:54 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:40428 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698Ab0CQOWx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 10:22:53 -0400
Received: by fxm19 with SMTP id 19so1105838fxm.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j+hzIOoN9vvHbngbg8ESXnmBpLecU+CCzv0xDDpkJWc=;
        b=eN1r54/15jjVsjjwIOLNQfuD/oy2FdbsafAST7VCIvH4fDZZMbl/sH3TaKPl6mcAdQ
         eZ//5xdbdiAFHmbuYQb1yb+mr/JMkDl8PwwcZKZGGb6U0EJVY7hlQoDtjVYCMuOJlIPR
         z0rqb4bBjXzLcGEkqIbPVdoRyykY3k/hhqmJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mHmfKDXueIiQXewpl2TC6UP5QfmdubEXTb2vkEduggdgOwf8W5O/VDYzHOg/g8qEoe
         6jnvyB4ATsgF/m9FLMpwzKwQWWsWEJI2mn30ZvjS99ZMsZt8AC0+MrfSycdA8ei9yVsx
         hTgNwF9BxOTxPCNJZIKb86bjOmQtHWP+YjQxA=
Received: by 10.223.92.142 with SMTP id r14mr7523180fam.93.1268835772547; Wed, 
	17 Mar 2010 07:22:52 -0700 (PDT)
In-Reply-To: <20100317114653.GA25641@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142393>

On Wed, Mar 17, 2010 at 12:46, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
> index 8cbe45e..3a0ae14 100644
> --- a/xdiff/xmerge.c
> +++ b/xdiff/xmerge.c
> @@ -397,6 +406,7 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t=
 *xscr1, const char *name1,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int flags, xmp=
aram_t const *xmp, mmbuffer_t *result) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xdmerge_t *changes, *c;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0xpparam_t const *xpp =3D &xmp->xpp;
> + =C2=A0 =C2=A0 =C2=A0 const char * const ancestor_name =3D xmp->ance=
stor;

Style. * should be aligned to the variable name.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0int i0, i1, i2, chg0, chg1, chg2;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int level =3D flags & XDL_MERGE_LEVEL_MASK=
;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0int style =3D flags & XDL_MERGE_STYLE_MASK=
;

=46WIW:

    Acked-by: Bert Wesarg <Bert.Wesarg@googlemail.com>
