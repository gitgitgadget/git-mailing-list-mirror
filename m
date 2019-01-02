Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59FB11F770
	for <e@80x24.org>; Wed,  2 Jan 2019 22:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfABWOG (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 17:14:06 -0500
Received: from goldenrod.birch.relay.mailchannels.net ([23.83.209.74]:59086
        "EHLO goldenrod.birch.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727140AbfABWOF (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Jan 2019 17:14:05 -0500
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 069C85E3AE6
        for <git@vger.kernel.org>; Wed,  2 Jan 2019 22:14:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a22.g.dreamhost.com (unknown [100.96.26.166])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id C7AE75E3B62
        for <git@vger.kernel.org>; Wed,  2 Jan 2019 22:14:03 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|novalis@novalis.org
Received: from pdx1-sub0-mail-a22.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.16.2);
        Wed, 02 Jan 2019 22:14:03 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|novalis@novalis.org
X-MailChannels-Auth-Id: dreamhost
X-Arch-Wiry: 525c7ddc780cc5ea_1546467243889_2404351436
X-MC-Loop-Signature: 1546467243889:3656961939
X-MC-Ingress-Time: 1546467243888
Received: from pdx1-sub0-mail-a22.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a22.g.dreamhost.com (Postfix) with ESMTP id 5AB267FE78
        for <git@vger.kernel.org>; Wed,  2 Jan 2019 14:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:content-type:mime-version; s=novalis.org;
         bh=p62dbXlZqzTdz21FHHqb0GZOic8=; b=YQcJzeflFOGcLqv/xcckm691nEhc
        kOhKK4WzhBC0LeCcUPGkprCk1J+NMoIHf8xoS5D8P6a750M56Pjsc5P5v7mIOs34
        O5xTuWeqsgEizc0ZFZCCOisMCx4BC1oiLbD/gHfKlGsLsepQCLlO9Y9kAReTsY91
        pLHvb3xXjJ/li3I=
Received: from corey (unknown [8.2.105.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by pdx1-sub0-mail-a22.g.dreamhost.com (Postfix) with ESMTPSA id E8B657FE42
        for <git@vger.kernel.org>; Wed,  2 Jan 2019 14:14:02 -0800 (PST)
Message-ID: <df37313acafdb4bb74c71e476e5acab10248b1a2.camel@novalis.org>
Subject: Submodule log bug
X-DH-BACKEND: pdx1-sub0-mail-a22
From:   David Turner <novalis@novalis.org>
To:     Git Mailing List <git@vger.kernel.org>
Date:   Wed, 02 Jan 2019 17:14:01 -0500
Content-Type: multipart/mixed; boundary="=-7kHzMtNYq0WEqruLUy+t"
User-Agent: Evolution 3.30.1-1 
Mime-Version: 1.0
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtledrudeigdduheefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefkuffhvffftggfggesmhdtreertderjeenucfhrhhomhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqnecukfhppeekrddvrddutdehrddujeenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheptghorhgvhidpihhnvghtpeekrddvrddutdehrddujedprhgvthhurhhnqdhprghthhepffgrvhhiugcuvfhurhhnvghruceonhhovhgrlhhishesnhhovhgrlhhishdrohhrgheqpdhmrghilhhfrhhomhepnhhovhgrlhhishesnhhovhgrlhhishdrohhrghdpnhhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-7kHzMtNYq0WEqruLUy+t
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When a submodule is renamed, git log gives incorrect output:

commit 350ebece9bce8d9c495f9a51e6f5529749c5c3cc (HEAD -> master)
Author:
David Turner <novalis@novalis.org>
Date:   Wed Jan 2 17:09:56 2019 -0500

    move

diff --git a/.gitmodules b/.gitmodules
index da1a767..f4baf2a 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -1,3 +1,3 @@
-[submodule "mymod"]
-	path = mymod
+[submodule "morx"]
+	path = morx
 	url = ../sub
Submodule mymod 86da4a4...86da4a4 (commits not present)

^-- I expect this last line to tell me that the submodule has been
renamed, rather than that it has changed SHA to the same SHA.

See the attached shell script for a demo of this.  I tested with
b21ebb671bb as well as 2.18 and 2.19.  Thanks to Adam Bliss
<abliss@twosigma.com> for helping to figure out the reproduction steps.

--=-7kHzMtNYq0WEqruLUy+t
Content-Type: application/x-shellscript; name="demo2.sh"
Content-Disposition: attachment; filename="demo2.sh"
Content-Transfer-Encoding: base64

IyEvYmluL2Jhc2gKCnNldCAtZXVvIHBpcGVmYWlsCgpybSAtcmYgZGVtbwoKbWtkaXIgZGVtbwpj
ZCBkZW1vCgpHSVQ9Z2l0CgokR0lUIGluaXQgc3ViICYmCigKICAgIGNkIHN1YiAmJgogICAgICAg
IDo+IGZvbyAmJgogICAgICAgICRHSVQgYWRkIGZvbyAmJgogICAgICAgICRHSVQgY29tbWl0IC1h
bSAnaW5pdGlhbCBjb21taXQnCikgJiYKCiRHSVQgaW5pdCBtYWluICYmCigKICAgIGNkIG1haW4g
JiYKCiAgICAgICAgJEdJVCBteW1vZHVsZSBhZGQgLi4vc3ViIG15bW9kICYmCiAgICAgICAgJEdJ
VCBjb21taXQgLWFtICdhZGQgc3VibW9kdWxlJyAmJgogICAgICAgICRHSVQgc3VibW9kdWxlIGRl
aW5pdCBteW1vZCAmJgoKICAgICAgICAjIHRyeSByZW5hbWluZwogICAgICAgICRHSVQgbXYgbXlt
b2QgbW9yeCAmJgogICAgICAgIHNlZCAtaSBzLG15bW9kLG1vcngsIC5naXRtb2R1bGVzICYmCiAg
ICAgICAgJEdJVCBjb21taXQgLWFtICdtb3ZlJyAmJgoKICAgICAgICBybSAtcmYgLiRHSVQvbW9k
dWxlcyAmJgogICAgICAgIFBBR0VSPWNhdCAkR0lUIGxvZyAtLXN1Ym1vZHVsZT1sb2cgIC1wIC1u
MQopCgo=


--=-7kHzMtNYq0WEqruLUy+t--

