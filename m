From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 21:56:57 +0100
Message-ID: <m2hbcvz8me.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2ipxc27zi.fsf@gmail.com> <m239og12pe.fsf@gmail.com>
	<4D3FFB0F.9070700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 26 21:57:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiCQU-0000q9-6u
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 21:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858Ab1AZU5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 15:57:08 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60984 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753481Ab1AZU5H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 15:57:07 -0500
Received: by wwa36 with SMTP id 36so1430661wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 12:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:mail-followup-to
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=cSw+PK5ikYs5i6+0o0saJ6tsuAvSGcHVPXuiDPODHl8=;
        b=FPrxZOtERyVIFNiMKuYRgqjP99o0OV6S53aHwZWhvgRSYNaeFzNBVGXE4Wvduy9VW8
         qQ3hv89SiW1eP1n26/fB61E8Qz0yQNoHUDNTz5ohOk7OIkqmt8cZx+DFVV0/fNsprjEM
         9hfslxghtPAG4wHi2JdHJdAOqRAqTsg4oW0Gc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=hLF91JVcuL3w9rTFPQjAMq4J7UgfMQypiqaM1CwsgEsDzOZGaL9hY6c3YBXlqfkqdI
         if3U3Gpnz9EKxkeLoqklRdSwWodjYQZ/vXgJcYWFD9k8weJznVom5LMh5MEmqFRHVbbX
         pIQ+qbhIfx+rjfwBOjxtz2+I2Az+GAyakHPUQ=
Received: by 10.227.137.5 with SMTP id u5mr109471wbt.6.1296075426299;
        Wed, 26 Jan 2011 12:57:06 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id w25sm201132wbd.23.2011.01.26.12.57.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 12:57:04 -0800 (PST)
Mail-Followup-To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
In-Reply-To: <4D3FFB0F.9070700@viscovery.net> (Johannes Sixt's message of
	"Wed, 26 Jan 2011 11:44:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165544>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Please don't set Mail-Followup-To; it's disliked on this list.

Just out of curiosity, I'd like to know why, since it has no annoyance
for those who are replying to my emails.

>
>
> Am 1/26/2011 9:36, schrieb Francis Moreau:
>> I tried to reproduce something similar but with a far more simple re=
po:
>>=20
>>=20
>> <v2.6.28> 1.f o
>>               |
>>           1.e o (merge)
>>               | \
>>           1.d o  o 2.c (merge)
>>               |  | \
>>           1.c o  o  o 3.a "Remove blacklist_iommu()"
>>               |  | /
>>               |  o 2.a
>>               | /
>>           1.b o
>>               |
>> <v2.6.27> 1.a o "Introduce blacklist_iommu()"
>>               |
>>               o Init
>>=20
>> Basically this repo 3 branches: master, 2, 3. Master branch introduc=
es
>> the "blacklist_iommu()" function with commit 1.a, and branch "3" rem=
oves
>> it at commit 3.a.
>> ...
>> So in this case there's no need to pass the '-m' flag and git-log(1)=
, by
>> default walks through all the commits:
>
> To reproduce the real history, you have to modify your example in thr=
ee ways:
>
> 1. 2.a must be forked off of Init, not 1.b; i.e., this commit does no=
t
> contain "blacklist_iommu".
>
> 2. Drop the side branch that removes the word. (Drop at least the com=
mit.)
>
> 3. The merge 1.e (which resembles d847059) must be modified such that=
 it
> takes the contents of 2.c rather than 1.d.
>
> IOW, "blacklist_iommu" is not removed explicitly by a commit, but rat=
her
> by a merge of one branch that has it and another one that doesn't hav=
e it.
>
> Look closely at d847059: The commit message hints at a conflict in
> intel_iommu.c,

But how did you find out d847059 ?

Did you use Ren=E9's method ?

Thanks
--=20
=46rancis
