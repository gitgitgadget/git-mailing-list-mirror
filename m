From: Matthew Cengia <mattcen@gmail.com>
Subject: Re: Bizarre git merge behaviour
Date: Thu, 21 Nov 2013 17:37:12 +1100
Message-ID: <20131121063710.GH26413@debian.cengia.id.au>
References: <l6hbgg$oej$1@ger.gmane.org>
 <528C62BE.7060803@viscovery.net>
 <20131120120326.GD26413@debian.cengia.id.au>
 <528CAB40.8030107@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Nov 21 07:37:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjNtT-0007sC-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 07:37:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750844Ab3KUGhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Nov 2013 01:37:34 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36740 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750782Ab3KUGhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Nov 2013 01:37:34 -0500
Received: by mail-pd0-f179.google.com with SMTP id r10so7708200pdi.24
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 22:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vHZCQtNLMDUv0xMKOTdWSIdOA1RYHos4LnkbUzXWxr4=;
        b=wU4e74Io3QO/EQzRBFpV+7FbHLBZPtlD2eaEuowvMIS8FWlzqqr+8YvmQjQDQ9NMUc
         2WZe7ogIZV/n7L1mI7+cVK85P30OOHQ7ks+mI++DUk1rK4KDOiasdnyFcd/wuoJf7Xuc
         jOLipjaa65lek2mDo+dM6v+7jUVKnrAqlSR6mtod8Bw3PJA/IHPOab5vPFGe8S3c870L
         iSiFRz0mNJhavQ8M3xGzBrqvhR5Hc7rG+kui7Z9FMmk0sK9r/oh/O3FDoH+CnBsSYgOA
         aE8r4Os6MNUICNfgHXr+sACBOUWRsp8KuuU9X+MWagpk+PYHlVsJGCWi34dTH2Vkql8Y
         KVXg==
X-Received: by 10.68.248.33 with SMTP id yj1mr4623217pbc.45.1385015853470;
        Wed, 20 Nov 2013 22:37:33 -0800 (PST)
Received: from localhost (c110-22-201-130.sunsh4.vic.optusnet.com.au. [110.22.201.130])
        by mx.google.com with ESMTPSA id fk4sm48745414pab.23.2013.11.20.22.37.31
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Nov 2013 22:37:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <528CAB40.8030107@viscovery.net>
X-PGP-Fingerprint: DB91 CFEF 322D C608 385F  563C 2F88 1AC6 4A16 1033
X-PGP-Key: http://cengia.id.au:2080/~mattcen/pubkey.asc
X-Homepage: http://cengia.id.au:2080/~mattcen
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238109>


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2013-11-20 13:29, Johannes Sixt wrote:
[...]
> UU ppcadm/modules/quarantine.py
>=20
> That's strange. I can't tell what is going on. Perhaps you have some
> criss-cross merges in your history that merge-recursive trips over?
>=20
> Sorry, I don't know how to help you further.

Hah! I worked it out!

$coworker erroneously did a "git merge -s ours" into the branch I was
merging in, and it undid more changes than he intended, which is what
resulted in *everything* breaking for me.

I've appropriately chastised him and most importantly understand why the
problem occured, which puts my mind at ease.

Thanks again for all your help.

--=20
Regards,
Matthew Cengia

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQJ8BAEBCgBmBQJSjaoWXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwMjI1MjY2QUFCMThBOUQwNEMxOUQ0QjY3
QTdFMzdGMzNCMjI3MkU4AAoJEHp+N/M7InLoNZcP/iDKW34qzsFSZ6NCXSszS1jn
pH2vcUrKW4Xjjxdzg90efzi/P/9TqY9EBiitRKSKiwupT2P5XJBhdtkjsOXbzWTO
MImeFjsLTsgJNcIF2m0aLoQo9AGjHdy2Ctf08x4XRxUMrH2GFXFCjkM49bWgr8Wl
nlOP3qgATRy+J2HLS4N+S1Ysow52xTA//QFUFQ1BAKoXpaxpsKTTLHW/PEMAmHP5
rb32S1VEeWeZY/Ll8qSAt1q0r4y5HeMEL9vziIzkBSW5ATyg8n7iz+wdzDIPYZUt
s5scXxNANyyZvcIQJJHmnCRRkGaZWiXeilYkeiYtejlKMdhPKLRAsEXK4aFq1oSh
MT1i+voJi6lWHS7fQDLwLXg7yqCvhGm4sfLJzLc0xGBB4xcM77ACPrAyxx1iScOd
h57t/mM+fV5PFdamKldoVWNi4/JGa6Nt/Xbi7/ia4gP8INLTxG8JblYEFL2azm16
UFeQsyu9OVyK8GkQebyJS5IBYt+WRINrQoAGhcvFWjiu5UAmsQcnY9JtXNtQOyX9
8+f5Tcmrp3vHeZ/j/LJg97L7P3VLDk0j547GFBNEXT/aA8Q/wAjfBuoVmqrH7GTl
c4uhCSseYJ/QNF9Qg+Jq2WpYhJF4BeAcgTAQujaO8k1uo1Bl4P8vwBfEwaMHm+lv
MogCZ1muUycyXFtGJ+B0
=mQDn
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
