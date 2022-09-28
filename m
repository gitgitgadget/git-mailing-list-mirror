Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0481DC32771
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 09:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiI1JCu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 05:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiI1JCs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 05:02:48 -0400
Received: from mx2.garz-fricke.com (mx2.garz-fricke.com [213.23.127.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DADF6B5
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 02:02:45 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=garz-fricke.com; s=dkim-key-2022e; 
 t=1664355762; bh=EiV2dcoeapObEB91ZS/ruZGkg8gTLwtz0pJdZuBy9iQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 ES9oBLzqWZAjjzfCD4JusbH5VVmtUe/RO+sJomzFTE8akUxldwDKCQYWPDUAdZygKCgCJ/B/e/qX2/bByGatBQ==
DKIM-Signature: v=1; c=relaxed/relaxed; d=garz-fricke.com; s=dkim-key-2022r; 
 t=1664355762; bh=EiV2dcoeapObEB91ZS/ruZGkg8gTLwtz0pJdZuBy9iQ=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 Jy691nKEkDr9xS1OJmlwRSq10xD1qojpUtFf0a1MekwD5hG3iYLM5UxSnRJ/OmeBhyBlSwaR0EYDH7rxA2nkbAAptKmggY31E8GA7JmcZMWcpMObbR5xsPqs1yUL4m/562Cn39eB8D5WkyUt4G/zD5+gQutWbdoXgeC9hgU8UbJl0h7f+8Q9yGdzcnFSHta5WipIqUPFPLElmX0UJCtUehyjPOR4Xgn8nu0tKn9Ca1bQGqYN4pGsy6a8lxqK2jZrzKAOEtKjpG2mjXgcb34/yKXhoIslpMS53Bia3+PqyvngIyzHRi59oeFSIVNRoktOOrzHCi+7bdNL0fsOONm7tA==
From:   Tim Jaacks <tim.jaacks@garz-fricke.com>
To:     =?iso-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>,
        Chris Torek <chris.torek@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: AW: git diff ^! syntax stopped working for stashes in Git 2.28
Thread-Topic: git diff ^! syntax stopped working for stashes in Git 2.28
Thread-Index: AdjGjge3NTS/nWtpQ9qUvItMO6utFf//9JsAgACEEYCAAu8pgIAVqj+7
Date:   Wed, 28 Sep 2022 09:02:42 +0000
Message-ID: <15f30d59650b4de2b14d89f6e8cb21ce@garz-fricke.com>
References: <6f729c8c43c4409faf6a11a69791f45a@garz-fricke.com>
 <9e0c1a2c-542b-156f-4c70-371d3a9b452d@web.de>
 <CAPx1Gve=BZ3J7KH0FA_BbAnYMEFXyDyiD=tX1vBiKCfHS0JfFg@mail.gmail.com>,<70e87095-d8be-f859-f5b4-a5e15904149c@web.de>
In-Reply-To: <70e87095-d8be-f859-f5b4-a5e15904149c@web.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Chris, hey Ren=E9,

thanks a lot for your replys.

> So, Tim, does `git stash show -p stash@{0}` work for you?

Yes, that works indeed. However, in my certain use-case I would prefer usin=
g `git diff`.
=20
> Letting `git diff X^!` mean the same as `git diff X ^X^` for a non-merge
> makes sense to me given the definition from gitrevisions(7) cited above.
> That in turn is the same as `git diff X^..X` and `git diff X^ X`.

Yes, that is exactly how it worked before. And all the other syntaxes still=
 work correctly.

Ren=E9, I saw you submitted some patches already, but these weren't approve=
d obviously. So how does this continue now?

Kind regards,
Tim

--=20
Tim Jaacks
SOFTWARE DEVELOPER
SECO Northern Europe GmbH

Schlachthofstrasse 20
21079 Hamburg
Germany
T: +49  40 791899-183
E: tim.jaacks@seco.com

Registergericht:  Amtsgericht Hamburg, HRB 148893
Gesch=E4ftsf=FChrer: Stefan Heczko, Marc-Michael Braun, Massimo Mauri    =20

