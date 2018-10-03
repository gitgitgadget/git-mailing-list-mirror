Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 380D91F453
	for <e@80x24.org>; Wed,  3 Oct 2018 03:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbeJCK0x (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 06:26:53 -0400
Received: from lavabit.com ([38.107.241.66]:19462 "EHLO lavabit.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726405AbeJCK0x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 06:26:53 -0400
X-Greylist: delayed 326 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Oct 2018 06:26:53 EDT
Received: from alan.alan (ip70-190-37-126.ph.ph.cox.net [70.190.37.126])
        by lavabit.com with ESMTP id JXAMSVV7Q71Z
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 22:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lavabit.com; s=bazinga;
        t=1538537697; bh=g1boMpkCb9+cg4gFYbIYi+Uj84xVM7uwcGkTGDiUItk=;
        h=From:Subject:To:Message-ID:Date:MIME-Version:Content-Type;
        b=ZJ4LtelOTOMo4cYLv1kjvwLrh+qrLvArtFiskhONXt8UK30eHcPYxv5IT/8WHGpEb
         JUQLn2MPYcyXbX3JeuKTQPfQT0NFO3o5KULeIF3g40sRA5pjLrv40hxTgC2rgH8LDd
         nLYRD6uQw3g8koQ2wW+fE2tt4ZM60LoCb7dt8wYIcH8Z7spWuzgmykhp/uQAifuzH+
         PIZCBetCP/2vlxgTNSzCWcGHBTsPRPXd6FH3jcdhYfSAhs+7axVz6qXsCXpISovs/4
         Gzyjwat7V7Q1eXej7YYuvI8Ote3zYsHeuLgE7qB147MslkxrjEYQJFWIRmHYBaSvKH
         ExYO4q67+ZRRw==
From:   Alan Aversa <alan_aversa@lavabit.com>
Subject: gitk doesn't quit
To:     git@vger.kernel.org
Message-ID: <ecf0c968-c8d6-7487-6bb8-db6de7afde8e@lavabit.com>
Date:   Tue, 2 Oct 2018 20:35:00 -0700
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="W5mp2BzKFTJb6XuzPEMYEiWvBhfAzhRer"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W5mp2BzKFTJb6XuzPEMYEiWvBhfAzhRer
Content-Type: multipart/mixed; boundary="FFKr7IKhjMB8UfIXSEDBzKYpCfK5fKao0";
 protected-headers="v1"
From: Alan Aversa <alan_aversa@lavabit.com>
To: git@vger.kernel.org
Message-ID: <5d735e51-0f6c-df95-05e7-df7a9a1bef8b@lavabit.com>
Subject: gitk doesn't quit

--FFKr7IKhjMB8UfIXSEDBzKYpCfK5fKao0
Content-Type: multipart/mixed;
 boundary="------------6CAFAF56972472F885833949"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------6CAFAF56972472F885833949
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

To quit gitk, I have to invoke ctrl-c from the command line. I get this
error when trying to quit gitk with ctrl-q or from the GUI menu:

--=20
=E2=98=A7



--------------6CAFAF56972472F885833949
Content-Type: text/x-log;
 name="gitk_quitting.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="gitk_quitting.log"

error writing "stdout": I/O error
error writing "stdout": I/O error
    while executing
"puts "Error saving config: $err""
    (procedure "savestuff" line 90)
    invoked from within
"savestuff ."
    (procedure "doquit" line 6)
    invoked from within
"doquit"
    invoked from within
".#bar.#bar#file invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .#bar.#bar#file 1"
    (command bound to event)

--------------6CAFAF56972472F885833949--

--FFKr7IKhjMB8UfIXSEDBzKYpCfK5fKao0--

--W5mp2BzKFTJb6XuzPEMYEiWvBhfAzhRer
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEAREIAB0WIQR+abDEDwxCnQKUVBTRybKyrql+EQUCW7PQ1wAKCRDRybKyrql+
EZAmAP48beLn3MxJ25AWuMWFHtAVGfz/3AHvORgz3GujOP85VwEA1TXn/E952+T7
DGZ++Rz9ecNbllN8lR/+kxpDpmDDyAM=
=owlA
-----END PGP SIGNATURE-----

--W5mp2BzKFTJb6XuzPEMYEiWvBhfAzhRer--

