From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCHv7 0/2] Rewriting repack in C
Date: Fri, 30 Aug 2013 09:17:19 +0200
Message-ID: <522046FF.3030700@googlemail.com>
References: <1377808774-12505-1-git-send-email-stefanbeller@googlemail.com> <xmqqob8g2p8t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig417B561C157AA601BDCD5C10"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 09:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFIxS-0002aA-F5
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 09:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755435Ab3H3HRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 03:17:22 -0400
Received: from mail-ea0-f180.google.com ([209.85.215.180]:54387 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755366Ab3H3HRW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 03:17:22 -0400
Received: by mail-ea0-f180.google.com with SMTP id h10so711662eaj.11
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=i/phenFPyIagOY+aRAl5vI1q6JW0Spg7PlPopEuWNMI=;
        b=jkI3ZoybIej9RPGCtDY41CNShYHZb92iUu/DHC1bTIm5nIOKK9uoN3SmQUVRpDnPvX
         1PXW5GPOy1NZLpig28RMVMDcn17Ypaeho+vrVRehxSFEDQm5TRmUa2vG1qHI80ksFnkt
         xO1weaFdrupn9xKOEVCvZG9/blvjqjHkgTV++8vk1o2DPZMPjyDkzNRmFiAyG60l0Kek
         pER4JvXjFAWxG+rPY1PfmidrC2QOVJc3vLg2IaWe7uFjWqX010uCaNLAWrcfZCQYNvA5
         e9lPp5T+ne+vrGTcg4iaXKALmv450c4BUrYQOTscgqY1H1PvsZ1ApERLmqSNmLJvvN46
         yMAA==
X-Received: by 10.15.75.73 with SMTP id k49mr10244288eey.36.1377847040985;
        Fri, 30 Aug 2013 00:17:20 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id a6sm52211707eei.10.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 30 Aug 2013 00:17:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130803 Thunderbird/17.0.8
In-Reply-To: <xmqqob8g2p8t.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233429>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417B561C157AA601BDCD5C10
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/29/2013 10:53 PM, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@googlemail.com> writes:
>=20
>> Here is a diff since the last time sending this patch series:
>=20
> This is very readable.
>=20
> There may be people who misread "LOOSE" as "LOSE"; the option -A is=20
> about making the unreachable ones loose so that they can be expired,
> so let's rename it LOOSEN_UNREACHABLE to avoid confusion.
>=20
> Thanks.
>=20

This would be very appreciated. I am no native speaker, so please
correct any variable naming, which could potentially be missleading.

I've seen you've already put a squashing proposal on top of
origin/sb/repack-in-c, it looks great, so feel free to squash it
into the first commit.

Thanks,
Stefan



--------------enig417B561C157AA601BDCD5C10
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIEb/AAoJEJQCPTzLflhqlhoQAOnF91NFAf82lOjFgj2/D6kk
PvNeNw4VhxWFiVtbm5Bch0Ool3FlaXKj69g0CVEHfpuGgbKHI7I2TQwnYssFBjTa
u0I23DaNy8SRGTIacnbbNGgCwKHlPJ1EhcwR8rgF1n8phfVHKm5Bqyu7Q9a/mxjg
FiPxiOLkR9HEqN9l+luurTy0FVfYah7tmC/P3b5oujDhTaC+r4fe95LsM61nsbnJ
SA2gxDZ708IJleKKV84kxvABcztGyc6bHImVvnLJRKref15C98dSImr/5P2yoIfC
REQEFOBy9usaCksOX4Lr5VneNJB88X1imBAWujITkarWimdJ7hIbdMV/C2D4lrwf
yU6O7T+oy7pB3A/xYZxvBOfh/m+ycEgCe4Wp3WXKCsABdr8CN9k5Hd1BK/qTwtwm
y8xr14sAphyE3ZLC0eOxdjn1Yem3FglTSRun+PgIF7u3wvz1IVCFuC6rLtWoeDyi
mB34vFjezdQLp+ExFgQ5mdIEJOzR+fGY9awrPsOTkdxsjSTSZj2i3nMX+dhs/6dm
Rvuv/GRMyqjjl3RZcx2lFGDBBNJJpx2zb+TOe0ZywCXEBnplp2bo+2Z2mWYJMM4C
AcusBm3d5qvuUyQK8fYqBVcBhHV9ZMBLjVJoY/Gi5sZn/XKW/pgq5+UGYX5KMoh1
GvqraYfW+4HoLHEdT1I6
=pNWc
-----END PGP SIGNATURE-----

--------------enig417B561C157AA601BDCD5C10--
