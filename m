Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E0AC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29BB32077B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="hmSYnVkN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="hmSYnVkN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfLJUAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:00:16 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:53226 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbfLJUAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:00:16 -0500
X-Greylist: delayed 1727 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Dec 2019 15:00:14 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:CC:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Date; bh=KJoUrSkfle4KfXxTnhbkfKsoZX7/nY5sE2thlhm+2UM=;
        b=hmSYnVkN1MJr5PV8gn1XycuveU1r1j2G4z9GZ6uiiJ8KJ7vREMFTI7Y84OFzaXctuyhykO5Jd7V6k2mCQ4CyW/4+NmtElC9OItbem3LnBkmjcf0ZdEe6mVVM6GJYtm+YRu4ihKwYkBv3p6OfipDLHonIgNqCcrnEcgOwcURPtiw=;
Received: from [10.161.64.60] (port=45166 helo=smtp52.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <kolan_n@mail.ru>)
        id 1ielEC-0001lj-6C; Tue, 10 Dec 2019 22:31:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:CC:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Date; bh=KJoUrSkfle4KfXxTnhbkfKsoZX7/nY5sE2thlhm+2UM=;
        b=hmSYnVkN1MJr5PV8gn1XycuveU1r1j2G4z9GZ6uiiJ8KJ7vREMFTI7Y84OFzaXctuyhykO5Jd7V6k2mCQ4CyW/4+NmtElC9OItbem3LnBkmjcf0ZdEe6mVVM6GJYtm+YRu4ihKwYkBv3p6OfipDLHonIgNqCcrnEcgOwcURPtiw=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <kolan_n@mail.ru>)
        id 1ielE8-0002S5-LK; Tue, 10 Dec 2019 22:31:21 +0300
Date:   Tue, 10 Dec 2019 22:31:18 +0300
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license? 
To:     git@vger.kernel.org
CC:     Junio Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
From:   KOLANICH <kolan_n@mail.ru>
Message-ID: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2E17AE4FBB8DCD5A2BDB63C4D6F01EEAAF688BCB05C26794D735BAB88EB1AB2551F213C05A9D353F2FEB6B90DDB8CC8365D5B87E27152DB6DFB9BA65748D3C19F
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7C2F32350C7BD909CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063741EED9F073F2E1CB8638F802B75D45FF5571747095F342E8C7A0BC55FA0FE5FCC408185D4022E28B9F313CF568C21F46FD69F55C375BC07F389733CBF5DBD5E913377AFFFEAFD269176DF2183F8FC7C07E7E81EEA8A9722B8941B15DA834481FCF19DD082D7633A0E7DDDDC251EA7DABA471835C12D1D977725E5C173C3A84C317B107DEF921CE79117882F4460429728AD0CFFFB425014E40A5AABA2AD371193AA81AA40904B5D9A18204E546F3947CBC84CEAF2DB33E17BA3038C0950A5D36C8A9BA7A39EFB766D187B4DA314F1B55BA3038C0950A5D36D5E8D9A59859A8B61CEB7BADD2D18F263AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C3E86F62FB921CF7195D8F21C83CFEF31F6A58BF81F659395FC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2AF38021CC9F462D574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A36CCA5E968A4DC96657DB7F7E6A9ED062DF5A6EE8E9C9332542D40BC2E4DC11639832BD0F36BD71813099610F3EF9D23DDE9B364B0DF2895C73AB06C8DF2F26327D77830F209D78AE208404248635DF
X-Mras: OK
X-77F55803: 6AF0DA0BABFA9FDB7F9F52485CB584D7271FD7DF62800FDCF6B86575CA39FAB105A796158226D3FD9270F2FD717823AD61600B2EB136E07E
X-7FA49CB5: 0D63561A33F958A5B25866CFD8E5B639B8ACCA9A6200C5FF5F77DBBB9E98C51E8941B15DA834481FA18204E546F3947C2FFDA4F57982C5F4F6B57BC7E64490618DEB871D839B7333395957E7521B51C2545D4CF71C94A83E9FA2833FD35BB23D27C277FBC8AE2E8BF1175FABE1C0F9B6A471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C224971977549DBF7C39576E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8BB69B70E1A2D1043B3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90051B732BAF0E936B425F197C52DA24038405A796158226D3FDAAC282D28BAD6852813099610F3EF9D23DDE9B364B0DF2895C73AB06C8DF2F26327D77830F209D78AE208404248635DF
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello=2E https://github=2Ecom/git/git/blob/master/Documentation/technical/c=
ommit-graph=2Etxt documents a file format for exporting commit graphs for c=
onsumption by third-party tools=2E But the license of this file is not perm=
issive, and the license of git itself is GPL, so I am not allowed to use th=
ese 2 files to create an own permissive-licensed tool reading this file=2E =
This probably defeats the purpose of exporting these info and then reading =
it with another applications=2E

Could the doc file be relicensed under a permissive license?
