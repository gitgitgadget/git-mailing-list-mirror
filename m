From: Taylor Hedberg <tmhedberg@gmail.com>
Subject: Re: Merging only a subdirectory from one branch to the other
Date: Tue, 7 Feb 2012 10:24:57 -0500
Message-ID: <20120207152457.GB2662@foodlogiq3-xp-d620>
References: <CAHVO_90MQamw7oB8ry5YBEWSnRnxDZvQ4ApVuuv4AYR6VRuXSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Tue Feb 07 16:33:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Run2l-0008Ro-AU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 16:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755304Ab2BGPdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 10:33:14 -0500
Received: from tmh.cc ([173.230.128.92]:48673 "EHLO elara.tmh.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608Ab2BGPdN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 10:33:13 -0500
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Feb 2012 10:33:13 EST
Received: by elara.tmh.cc (Postfix, from userid 1001)
	id 0DEAC3420C; Tue,  7 Feb 2012 15:25:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on elara.tmh.cc
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,FREEMAIL_FROM
	autolearn=unavailable version=3.3.2
Received: from foodlogiq3-xp-d620 (rrcs-70-61-89-105.midsouth.biz.rr.com [70.61.89.105])
	by elara.tmh.cc (Postfix) with ESMTPSA id 927BF341B6;
	Tue,  7 Feb 2012 15:24:59 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAHVO_90MQamw7oB8ry5YBEWSnRnxDZvQ4ApVuuv4AYR6VRuXSw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190179>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Howard Miller, Tue 2012-02-07 @ 09:38:22+0000:
> I have a branch with a particular subdirectory tree. The tree has a
> lot of history. However, all the history for that subdirectory is
> exclusive to it (no commits changed anything outside it). I now need
> to merge that subdirectory into a completely different branch without
> loosing any history. I think git-read-tree might have something to do
> with it but I don't understand the help file at all. Any help
> appreciated.

You might find git-subtree [1] useful for this. The `git subtree split`
sub-command in particular enables you to factor out the history of a
particular subdirectory in your repo into a separate branch, which you
could then merge into some other branch as desired.


[1] https://github.com/apenwarr/git-subtree

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPMUJJAAoJEDTWeng2oxKKRtEP/1NIMpevXkPy77mNEEjvMKTC
5gklvpkyQDJ6CSNlXsTsH4D5P1mvbfU9CPl6zlA0RpQKo8mb9oEm+ywLTEaqQI2D
RYt3n/o4T6Sk8RvMwttQnT6+rFHt2InLIY2T4UgDzfxvWATexCRP9iC41Kgntd1s
L3OZi1m2XSg39iyZvjP/3UYl96dkx6mEpB+Mmh1zU+UW6sfxuhd0ekq2lw4FARaq
PIZLGzkm1ZwTSwQCMxP8g+0ioP2x2gQQomRK8AiN4TTrxTkjPYd3AV0BArjeC/H4
MSbI5dplSHbZd7voPcc63X2NK2FFSqzZssrcW2/ul0PkB7NvjMPpwhB54L2JXOvx
1ATloVaUxjM+c1alXApn/1rtxLauyNvkZpC21hzeIe4L7Mt2woYREpGe83QKkeis
17LTX2wcJRcmBifg0PcAp3aM3g9dwZdyMnXSRRVn97mxUShahUzblAS4Ey3HY3bo
7L6cM+rBzU6d0Ce70FCVgSdvaDudJF88oEqTb2JGKVXsJuDxigzgwrObDESK0X8s
R7aWq+pcxJZVshBtP+/lstBDa+7BOQrjSeRVnwIx06ZiVShGimmZzCuLgqAuTLfj
yxMU2VCyMy5Ndhn9fI8rWdtk6Ld+kEFeXl2p3aYJMPo5VpVAxVzw4/EbXhUsm8We
ovqPSJQ8MmH6JR6LZyMK
=Ztfz
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
