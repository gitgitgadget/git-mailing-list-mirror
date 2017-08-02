Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC50420899
	for <e@80x24.org>; Wed,  2 Aug 2017 13:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbdHBNqm (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 09:46:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:30103 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbdHBNql (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 09:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1501681599;
        l=942; s=domk; d=aepfle.de;
        h=Content-Disposition:Content-Type:MIME-Version:Subject:To:From:Date;
        bh=GTgJ3M/juXxMGA2U9Br5gpYx6oe2yUamL+1glBgHQsk=;
        b=m8zqTBipGUX6B6y8c1BVwLmjLSGL4p3sbnHFY9TmVzSvbA/Cwx3eGOWTTSZeVcHZ65
        /0H+tESDI3ph+l6xTU0x34ZUWWUe8NINe6EciSEhecyRlb/V2vyTW0IjA/n4v1rLzA32
        dz0snrFPbTF7aHGTWE7cCxMRfG5e7lryUIBo4=
X-RZG-AUTH: :P2EQZWCpfu+qG7CngxMFH1J+yackYocTD1iAi8x+OWi/zfN1cLnAYQ78mmFeN6Aqp4B5pIVlTUWUm3u3pWh1+4rEzpLBkg==
X-RZG-CLASS-ID: mo00
Received: from aepfle.de ([2001:a61:102e:7fff:27ee:68a5:7ddc:d3db])
        by smtp.strato.de (RZmta 41.1 AUTH)
        with ESMTPSA id k0732at72DkdIBj
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate)
        for <git@vger.kernel.org>;
        Wed, 2 Aug 2017 15:46:39 +0200 (CEST)
Date:   Wed, 2 Aug 2017 15:46:35 +0200
From:   Olaf Hering <olaf@aepfle.de>
To:     git@vger.kernel.org
Subject: git send-email -v n fails
Message-ID: <20170802134635.GA19311@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
User-Agent: Mutt/1.8.3 (7113)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I think send-email should understand all options of format-patch.
At least for '-v n' this fails, one has to type '--reroll-count n' as a
workaround with git version 2.13.3:

+ git send-email -v 2 --annotate --confirm=always --to-cmd=scripts/get_maintainer.pl 'HEAD^'
fatal: ambiguous argument '2': unknown revision or path not in the working tree.
Use '--' to separate paths from revisions, like this:
'git <command> [<revision>...] -- [<file>...]'
format-patch -o /tmp/fVUtbB6OWI 1 HEAD^: command returned error: 128

Olaf

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCWYHXtwAKCRBdQqD6ppg2
fvHcAKCKhmQr5AaVMq1vPqXTiRS9jOIVIgCeP+J1mbLUqw5wiK5fimdFwpgcEf8=
=IHuK
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
