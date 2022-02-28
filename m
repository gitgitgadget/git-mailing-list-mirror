Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFEFC433EF
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 09:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiB1Jzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:55:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiB1Jzv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 04:55:51 -0500
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 28 Feb 2022 01:55:12 PST
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8322069CF2
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 01:55:12 -0800 (PST)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 116695FAD9
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 10:48:16 +0100 (CET)
From:   Rolf Eike Beer <eb@emlix.com>
To:     git@vger.kernel.org
Subject: Please add support for "git merge --continue -S"
Date:   Mon, 28 Feb 2022 10:48:14 +0100
Message-ID: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1966856.TFcz1LWo6C"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart1966856.TFcz1LWo6C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: git@vger.kernel.org
Subject: Please add support for "git merge --continue -S"
Date: Mon, 28 Feb 2022 10:48:14 +0100
Message-ID: <3769291.LUJhsIL6D6@mobilepool36.emlix.com>

Hi,

I usually sign my commits and merges. But when a merge has collisions I can=
't=20
continue and sign in one step, because --continue and -S seem to be mutuall=
y=20
exclusive. My way out is:

git merge --continue
git commit --amend --no-edit -S

=2E.. but this could be a bit simpler. Or maybe --continue could remember i=
f I=20
have passed "-S" to the original "git merge" command.

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, https://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source
--nextPart1966856.TFcz1LWo6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYhyaXgAKCRCr5FH7Xu2t
/EZ/BADDjhdVLUyEzN+gCLpGgWg2XXBCTsdq5WlXHc1Kd93PlXHw3uUDmZFMkKXq
49z8XNqmHawKJ4E1VC1Gm8gLmL6a212y4jgw7/ZCbuyFyOkBjKOAhcuhp0agBKtR
w3FlLtg9HLssT3BrOp71ThE7s3DOIsqXqPk4TkFqDRj7J4fWtg==
=uPiF
-----END PGP SIGNATURE-----

--nextPart1966856.TFcz1LWo6C--



