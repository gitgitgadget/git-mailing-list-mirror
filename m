Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21921C433F5
	for <git@archiver.kernel.org>; Sat,  1 Oct 2022 10:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJAK0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Oct 2022 06:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJAK0m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Oct 2022 06:26:42 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4C746D97
        for <git@vger.kernel.org>; Sat,  1 Oct 2022 03:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1664619995; bh=0UeMPlsRMgZXFHKg8fiRoMQIxyEZy8T0IwsqKK7oS8E=;
        h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
        b=Jx4QNDdTwbnWnQnVm+/t2RGnvR/GlrghZNPVHowVX/cKx6nK10mMOmQbhE7W3bIpX
         lkfu25hx6Yn7UZSj+zpoHvM5kDgtgWbkzyFAPf/UMAmikjsNA7D3dyi8ZvGUiETquY
         x8Fd6SvQSEes4Ph7eVrN4y6S8PLKPhg3UGBzYMj2xCR8tbLXuq3Gv9K0k4/odbU2il
         Ol6I1dfz5cIsdaqEjJhun3IqgJC5q7Xw0aPVmkotGve9lujmZe4IDW0nteP8LbvSaG
         dBJwaZs4h7nLHP+Wr0Imloq9QE3ZWPRn8lylgW0TU0AejS3PdZeY/g8Ww9m0vPDYUY
         ugkRt/A6gE6RA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.26.45]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Melax-1pFHMl4BpV-00aRYa; Sat, 01
 Oct 2022 12:26:35 +0200
Message-ID: <970fd3b1-8792-cc59-c3ee-00656a0615d0@web.de>
Date:   Sat, 1 Oct 2022 12:26:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.1
Subject: [PATCH v3 2/3] revisions.txt: unspecify order of resolved parts of ^!
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tim Jaacks <tim.jaacks@garz-fricke.com>,
        Chris Torek <chris.torek@gmail.com>
References: <ba6eea28-fb3a-b376-2529-351727c02f1a@web.de>
 <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
In-Reply-To: <16c49d20-cafc-4b48-3c6b-e11c74c29abb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bE7e+9Uonk2IEyJLJeQKMOI+PElpIE7gYPYKgIiXuUGGRCtZhIK
 Qu5LiOvK2SplWpUBNd/w+5KhkVnCbb6Gu9PWoCHHc/nFLpiVeZtJrRDyUE8as7lJJiUblGc
 i64al/hHfpDYYSZOuf0EGLkyXhHO64tVcA6zuXiHxJZqVpJmkGGN+MfUSDT8n9IUE49itQV
 B78x9XFasbAbyabbGBLFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ReolqDOKvcw=:meTP8UqfFAMdWAsnhl9YiV
 49kiQv5z8eQMhOu37il6cBk4iO5VeunLaLejDceSi9eo/0wrc+2zvgYiFhc8khrsiI1W3aKp/
 Ardid7lISr5UHcsv7k23b4NhwUOo8Ti3x7WwrlB3Y4O171sPW/TZaTT+YOWurbjNWcOSErduj
 Qrx6hAwvB2jujK/nSphQrLbkUYFVu8sNGQ3ZqQiWskEpi2PVmGsMyxXQPGaz8BJ9440JE1ifb
 rU1aKv7q1Lq8wlmiGMv2EiiEPKAZb8bUAtJsPCnMPj1AatGeVXUsAqd69OssGXeFa8HKM+CC8
 o/i7lebJ2IS3gJ3tCcQDc1S+a/2a1BT44tU7kW+p6/DseyhVi5vNiHZhKh9EH5TLJZpn9g6Ll
 ayz/BhOPQhAPhIvptwW3BcDgZ+DNjRuSkxWK61BwYb1YJopC3AvXVQcRDCzN4m3wlHRy3jEdH
 V0sZWlf4jC71PPptVPSAXtlcxCCjKqUO71iLUanUg/p21XLG0/yGc8umSnswq0axOg4dgQOmM
 p42B2A0INsaM2bQBTIULxefEu7wCsipUJfQLc8xxO93dQ2xYx/VPthH19FtH0yPtEJ7D1EcHr
 zsnDMIKK8FKVEgq1lCpfmQmN0JA/N+Xn3F2EG0t73i6gYgROouugewue4ms05O/FHCF7/FIaC
 CTMgS48TZCy0yOVGFOJQZvgohW7NOVKCDikk5DHFOSv+H76PpRFqb1kxOI9BdsiW6nWuXHe/p
 /uiENJiF2lgwH83A472Varrl7Lqoysmpw4cHEq6zI4RmplT0eU2Tkp1rdZKQkfChpYg2Yzq/t
 kyjePX7LMtCawgsxy8O9HXmXXVXN7Ud4Ym22YlQSQeiFYMYPdKaRyUok86ubTensytf0r5cDb
 7Kco2KOB2Gg165KDvnDPIJwJ6RQLwpu2TtXv00jb6zMr+ycdml8mZVP/AvYM72VUdbc6/IWcc
 W4c9emxdVshMVfLEkhE9wzPuseeg2B3rCxGJ0i7RyEHJ8HVrymFR+NzrIsZww6mKaL16fNw5o
 x1ln9raI2EQxfr2FYzORkeMmwg2GVS9O8gBE5AUMfNHzrtzE4mkav7+kpSvl5WpDFb+4XoY5Z
 P35vVUTKEJoK/XysFInrAF6/kuA/uTt5fqxr40n/jnin4WHvPK3/SBe/8pCmEwhs0227E9Tjo
 p776c=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitrevisions(7) says that <rev>^! resolves to <rev> and then all the
parents of <rev>.  revision.c::handle_revision_arg_1() actually adds
all parents first, then <rev>.  Change the documentation to leave the
order unspecified, to avoid misleading readers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 Documentation/revisions.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index e3e350126d..0d2e55d781 100644
=2D-- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -363,7 +363,7 @@ Revision Range Summary

 '<rev>{caret}!', e.g. 'HEAD{caret}!'::
   A suffix '{caret}' followed by an exclamation mark is the same
-  as giving commit '<rev>' and then all its parents prefixed with
+  as giving commit '<rev>' and all its parents prefixed with
   '{caret}' to exclude them (and their ancestors).

 '<rev>{caret}-<n>', e.g. 'HEAD{caret}-, HEAD{caret}-2'::
=2D-
2.37.3
