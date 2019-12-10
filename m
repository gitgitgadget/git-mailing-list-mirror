Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB87C43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 21:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A95207FF
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 21:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="gHV+M9qI";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="gHV+M9qI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfLJV05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:26:57 -0500
Received: from fallback24.m.smailru.net ([94.100.187.223]:56572 "EHLO
        fallback24.mail.ru" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727257AbfLJV0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 16:26:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Date; bh=u+aClZnCGmq4OQDWDhSEGeDTKkHkTnryrC7p4wWe5fo=;
        b=gHV+M9qII741qphCBv/owYyjQn4Kd5eNBWBe9Ejg6omUJZD2V9nIBHXFE2HqQjTAAozK8SbR9JA6IiLaJOnxCAT4yOcXppGsx8ntz9ZlDM23VmYW0fH5MNFTmSaFu1tZMkM5Wagd3pIY6ptAXn5LfFI1Cqf4LdvC/mBmb5Ez+oI=;
Received: from [10.161.117.32] (port=42988 helo=smtp3.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <kolan_n@mail.ru>)
        id 1ien1v-0007rG-TG
        for git@vger.kernel.org; Wed, 11 Dec 2019 00:26:52 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=Message-ID:From:To:Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Date; bh=u+aClZnCGmq4OQDWDhSEGeDTKkHkTnryrC7p4wWe5fo=;
        b=gHV+M9qII741qphCBv/owYyjQn4Kd5eNBWBe9Ejg6omUJZD2V9nIBHXFE2HqQjTAAozK8SbR9JA6IiLaJOnxCAT4yOcXppGsx8ntz9ZlDM23VmYW0fH5MNFTmSaFu1tZMkM5Wagd3pIY6ptAXn5LfFI1Cqf4LdvC/mBmb5Ez+oI=;
Received: by smtp3.mail.ru with esmtpa (envelope-from <kolan_n@mail.ru>)
        id 1ien1t-0000yV-S0
        for git@vger.kernel.org; Wed, 11 Dec 2019 00:26:50 +0300
Date:   Wed, 11 Dec 2019 00:26:49 +0300
In-Reply-To: <2449B38F-C98D-40D5-8D58-CA1C6670304D@mail.ru>
References: <2449B38F-C98D-40D5-8D58-CA1C6670304D@mail.ru>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Fwd: Re: Could /Documentation/technical/commit-graph.txt be relicensed under a permissive license?
To:     git@vger.kernel.org
From:   KOLANICH <kolan_n@mail.ru>
Message-ID: <4B11ADEA-8E8F-444F-B4CA-C4A3E9536F8C@mail.ru>
X-77F55803: 0A44E481635329DB0E1AA8A03B392317179C3E6C7981FFF2E17AE4FBB8DCD5A28772D6DA4F2629E3F688BCB05C26794D735BAB88EB1AB2557AC21E34E8694B6A96E04B26D7E4325AFC192BE989E59C08400F39C12E319FF0
X-7FA49CB5: 0D63561A33F958A585AC902A3A72A94900010146F8F06181BD8CCD36651123498941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249E59597DEBEB5B1EB76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B656A1030537AB80E3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D725E5C173C3A84C30E7A8B1B1FD51AB9D1C1EC45DA0E581728A6D463EDFD0DBBC4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F2AF38021CC9F462D574AF45C6390F7469DAA53EE0834AAEE
X-Mailru-Sender: A36CCA5E968A4DC96657DB7F7E6A9ED01FBA42CB9A9A770B73058EED3714A107677B2005CA2493AC813099610F3EF9D23DDE9B364B0DF2895C73AB06C8DF2F26327D77830F209D78AE208404248635DF
X-Mras: OK
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDCE58ED9ADD6D73AD6A4BABA29134BE9D6A1BB7003DE1FF1EC3CE2A69A2FC041D0
X-7FA49CB5: 0D63561A33F958A5419E86990C7DDE1B530211408A7BBF4BD060C4B0A8E896F68941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C2249A13777524775EC3C76E601842F6C81A12EF20D2F80756B5F5C318D1F9ECD513A76E601842F6C81A127C277FBC8AE2E8B477F8D5E6EF1715F3AA81AA40904B5D99449624AB7ADAF37F910319684D6E05D462275124DF8B9C99B0B8D173C204012BD9CCCA9EDD067B1EDA766A37F9254B7
X-Mailru-MI: 800
X-Mailru-Sender: A5480F10D64C90053DB5E8752E58C64B92A76CE2DBA12641FD2C8CF3E031E56E661C3FE1EFDA3D63CA84F4FE1D4775B6C77752E0C033A69EE390A927BED62499DB5599FF92D1811A3453F38A29522196
X-Mras: OK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>What _could_ be problematic is repeating the documentation directly
>in another permissive-licensed repository=2E

> One can interact with binary files as you want=2E

Certainly=2E The problem is not with interacting to binary=2E The problem =
is the source of knowlege for a third-party impl=2E If I took Git source co=
de and directly reused it, my code surely would have been infected=2E If I =
took git source code and rewrite it function by function (by reading functi=
on, understanding what it does, then recreating the function from scratch t=
rying to keep the behavior exactly the same) =2E=2E=2E the resulting code w=
ill still be based on git source code and so infected=2E The same if I rewr=
ite it function-by function to another language=2E And we consider docs and=
 code to be  languages (and in fact I wanna rewrite the docs in a formal la=
nguage and then transpile it to the source code)=2E So, if I based my impl =
on any source (including docs) under GPL, I cannot be sure it is not infect=
ed=2E

So probably only clean-room or black-box RE can give any sensible guarante=
e in the case the content is under a viral/proprietary license=2E But I hav=
e no time to waste on CR/BB REing open source software, though it may compl=
etely make sense=2E

>In fact, there are likely privately licensed products that interact with =
Git's pack-files even though their format documentation is under GPL=2E

Businesses have lawers working for them full time and some money to spend =
on lawsuits=2E It is incorrect to compare most of private persons like me t=
o businesses=2E
