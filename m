Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62F781F404
	for <e@80x24.org>; Tue,  6 Mar 2018 19:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeCFT14 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 14:27:56 -0500
Received: from mx1.riseup.net ([198.252.153.129]:56525 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933101AbeCFT1y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 14:27:54 -0500
X-Greylist: delayed 441 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Mar 2018 14:27:54 EST
Received: from cotinga.riseup.net (cotinga-pn.riseup.net [10.0.1.164])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id D67EB1A0A90
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 11:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1520364032; bh=J78XI3LfDmTLgiNBEMsCfxpr0IBowPzKGBX0kbeZ1tQ=;
        h=Date:From:To:Subject:From;
        b=cX244VCDhASnBcYI2Kiup3pYW0LStmxVaIJJ2xGE3SKeDJtOoWqSfB11P8pTSSQd5
         AX1QCASv5P3s5qGIEIMB8EMel6J50u3SnTexB/Ij2aY82/WqUFuW3ZgrSpg15EsyJy
         X6zC7y2//Tb8oqLCti3x0gNWm2tdeoye1wDMLABM=
X-Riseup-User-ID: DDFB3719A56FA886C112F1E4120310BA097A036AA8772F048900E43CB0DE5116
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by cotinga.riseup.net with ESMTPSA id 3DE72865A0
        for <git@vger.kernel.org>; Tue,  6 Mar 2018 11:20:32 -0800 (PST)
Date:   Tue, 6 Mar 2018 14:20:17 -0500
From:   Sean Behan <seanwbehan@riseup.net>
To:     git@vger.kernel.org
Subject: Bug: moving submodules that have submodules inside them causes a
 fatal error in git status
Message-ID: <20180306192017.GA5797@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I encountered this error when moving some submodules in vim, basically if you
have a submodule that has submodules inside it and you try to move it you'll
encouter a fatal error with `git status`. I have a pastebin example of this
here: https://ptpb.pw/5g9-/bash

Appologies if this is an invalid bug report.

I'm running Git version: 2.16.2 (Debian Unstable)

--

Sean Behan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEqrfkzcfAOXOnlTsZmSkJCkGZyZMFAlqe6eEACgkQmSkJCkGZ
yZP5nQ//aOD9vmgNoxbtQhHHl6xShkUI/H5YWh9021Siik2mASG7MIz69xDUNb1q
TJeHCXBGLk04ngNPVuLAwdSH/Sma5qcaYzoGcRmED4Pv5RNX/IeZ6BHdAzbJEbga
u/oh6Ii1IDqHmi0t4ghPVndlrPnuinHiZMbvScA4fMhfEkrJsjkaFZcSs2boLKP1
GKRs9FlezEOCHyFcdE4UM/wGMQW0ZZiMspq/N1XEyjuE54GZEeMRyUCGcHZnn5xL
1fcC7EqOPm/uvhKq8ZYKXZlz0B/7N0+dSnXJUArG6feQZ7BYYOy4FSE+fAvRoeKa
hMWjeyvlEsckK+4gq4N96D6FAtEJ5NLuP+UAAsDpFP6lLFLVMymZy17Te6Q2pDmg
wCvvGDbhyODR9zmQAD6xJHDzNSeywHFRsBX9W+Kb2yiN5WS6YtxXf22cyNNyC6e3
9OWTi7Z9gzNxH3n9f6PaH7EnsJZL1xviMfpI+mZSWR70c1bN/1XNya31Wo68S2gK
hg5CpIbYFORcKRd9GK4KHLBL0pb0f10cuHKhXCIdLPruFj16+7E2q7aXqRwri4Xe
Bjjikss8aWzjDZzyv4ATkLC3anpE2LTLgZR6ovf+lqgfeIQaSlPuJfIAtf6+qBK/
ecdYN2GIBaYJ/HTPmO0FfZTpNNlAAYSYTG/fTfIO4rppFWI1+6c=
=NMm3
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
