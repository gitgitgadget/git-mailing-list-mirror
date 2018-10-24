Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 222F61F454
	for <e@80x24.org>; Thu, 25 Oct 2018 01:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbeJYJdq (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 05:33:46 -0400
Received: from pdx1-sub0-mail-fallback-a1.dreamhost.com ([64.90.62.138]:35118
        "EHLO pdx1-sub0-mail-fallback-a1.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbeJYJdq (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 25 Oct 2018 05:33:46 -0400
X-Greylist: delayed 21798 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Oct 2018 05:33:46 EDT
Received: from pdx1-sub0-mail-a66.g.dreamhost.com (unknown [10.35.43.27])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pdx1-sub0-mail-fallback-a1.dreamhost.com (Postfix) with ESMTPS id 28E052941F3
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 12:01:45 -0700 (PDT)
Received: from pdx1-sub0-mail-a66.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a66.g.dreamhost.com (Postfix) with ESMTP id 5A6DA8024A
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 12:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=1ec5.org; h=from:subject
        :to:message-id:date:mime-version:content-type
        :content-transfer-encoding; s=1ec5.org; bh=m4/lLV7k+s07wJaZXXjKM
        JysJNk=; b=0T4TsjL2xoW38Z3J5iaiKLQ440ckfl4Lh0tGWEscmERLaDYCmqapX
        HZgcW/6hFZQVM5ysPdciA98NkLKRXSsp6tnnCMuKSppoEPq8RT0qxf2l/nc22gLq
        gVuOxFcIM7uxsNPhzyIGqpm+s4pBw0idnwXkzcHxyuQ9h3ZgwIvFQY=
Received: from parsec.local (c-24-130-195-9.hsd1.ca.comcast.net [24.130.195.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mxn@1ec5.org)
        by pdx1-sub0-mail-a66.g.dreamhost.com (Postfix) with ESMTPSA id 2490F8024C
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 12:01:13 -0700 (PDT)
X-Mozilla-News-Host: news://news.gmane.org:119
X-DH-BACKEND: pdx1-sub0-mail-a66
From:   Minh Nguyen <mxn@1ec5.org>
Subject: [PATCH] l10n: vi.po: fix typo in pack-objects
To:     git@vger.kernel.org
Face:   iVBORw0KGgoAAAANSUhEUgAAADAAAAAwAQMAAABtzGvEAAAABGdBTUEAALGPC/xhBQAAAAZQ
 TFRFAAAA////pdmf3QAAAK5JREFUKM9Vzj0OgkAQBeCHGLAwricQEy/gCVgr72BHPIElBWG2svSM
 dFpSWhDH+TEkVl923+zswwQgZ7yFzMHM6AzYO21j0PQHG8z2gDiREBmEYRE+muWlTr5Q+hbfuSyK
 TEkGChhn7TIc74Uw0v2kzejRKHGD0rgp9Y7CTKrRC4iprwRcJlK6Tkphu9ZuWMkHetkcjPZpIBip
 MsZoXMkzdn4nH5EOhi/T0IhO4C851Xcmi8VTCwAAAABJRU5ErkJggg==
Message-ID: <874dee7c-af9f-a609-c325-748160df89cc@1ec5.org>
Date:   Wed, 24 Oct 2018 12:01:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:63.0)
 Gecko/20100101 Thunderbird/63.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: vi-x-KieuCu.[Chuan]
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: 0
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedtkedrgeejgddufeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucenucfjughrpefhuffvkffffgggtgfgsehtkeertddtfeejnecuhfhrohhmpefoihhnhhcupfhguhihvghnuceomhignhesudgvtgehrdhorhhgqeenucfkphepvdegrddufedtrdduleehrdelnecurfgrrhgrmhepmhhouggvpehsmhhtphdphhgvlhhopehprghrshgvtgdrlhhotggrlhdpihhnvghtpedvgedrudeftddrudelhedrledprhgvthhurhhnqdhprghthhepofhinhhhucfpghhuhigvnhcuoehmgihnseduvggthedrohhrgheqpdhmrghilhhfrhhomhepmhignhesudgvtgehrdhorhhgpdhnrhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
  po/vi.po | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/po/vi.po b/po/vi.po
index bc79319b6..e646825ed 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -13663,7 +13663,7 @@ msgstr "=C4=90=C3=A1nh s=E1=BB=91 c=C3=A1c =C4=91=
=E1=BB=91i t=C6=B0=E1=BB=A3ng"
  #: builtin/pack-objects.c:3382
  #, c-format
  msgid "Total %<PRIu32> (delta %<PRIu32>), reused %<PRIu32> (delta=20
%<PRIu32>)"
-msgstr "T=E1=BB=8Fng %<PRIu32> (delta %<PRIu32>), d=C3=B9ng l=E1=BA=A1i =
%<PRIu32> (delta=20
%<PRIu32>)"
+msgstr "T=E1=BB=95ng %<PRIu32> (delta %<PRIu32>), d=C3=B9ng l=E1=BA=A1i =
%<PRIu32> (delta=20
%<PRIu32>)"

  #: builtin/pack-refs.c:7
  msgid "git pack-refs [<options>]"
--=20
2.18.0
