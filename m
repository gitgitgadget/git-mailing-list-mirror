Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C1EC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 15:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238321AbiEIPb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 11:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238213AbiEIPb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 11:31:27 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C004614FCA6
        for <git@vger.kernel.org>; Mon,  9 May 2022 08:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1652110048;
        bh=5zsWU7e5hkEHCFzmoqjG6mIZTX5IVg9QlRCkefM4/MU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=UrX/fIpeINtv5GGzV3mvMjjiOzgSYqrK+MhrqF663aGarp/pKrgWBXB6cXJlhqqgS
         1U9Y7aHe2bBS+4vYc7VjznxpMVrp40hiDZckcJ6WrvaBWTKe9kRF6ccnNmmAtAgte4
         YhyQp0PDw9zZUu1Zjme3NOjTeNzvCBzAY61K78e8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MlbHE-1oF8J0376g-00ijQm; Mon, 09
 May 2022 17:27:28 +0200
Date:   Mon, 9 May 2022 17:27:28 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Hebrock, Christoph" <ch@generationdesign.de>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Confusing note in "gitattributes text=auto" discription
Message-ID: <20220509152728.32kgmus6dht7uofn@tb-raspi4>
References: <AM6PR03MB5444D37306312CE538C9BD1BCAC69@AM6PR03MB5444.eurprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM6PR03MB5444D37306312CE538C9BD1BCAC69@AM6PR03MB5444.eurprd03.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:oDO4SIfjqlbCir5uoFlGwd82+/yYnWQzqhKOkPNyaVDJXO4Q2aI
 6LIDMBWWooG9nCKlwYbZGZwjlNpwG8hxwk4W89sN5ZjJR2EV5kcqneTzps7E/VdDP+0Vr/8
 ZMduFXcFPqJVpGxujRp358gnp6Xdtyig2xNZUrfSj+rf+DmYDdUZcpu/Y2ghLaRtP+Pivbi
 bLtB1in9TQo4qFPcEAJZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bxg3Eg//dTU=:Dq7pifMYTiaH1DrNxG33vX
 a7FmTcHs9nHoBremhyteK3shk4Nc1y8rdGIAncPUU89LdA0u0CkDGDbwbkoZ1FZkzNxxMQuvs
 aQbhsqiDfhVeJ78sXD59Yj8/mR2IqQNC4bMQk+eEdZfuazGKlXyGKZMPBdCXTh13Y5+9NFm+2
 RkcZklwXJcROVq5Nz0n1szgJo/0PUlwIrhHzdveSlkWmVMPUbAvWAxgsziXLCZtYT9k/wcm38
 6vMuiGaGftoKIaIjS5QP/qziI54zJ/8buvnKuU57ELjixYIdyHgZIEwhNUCPNBSznAHGMW++c
 oakozDq14fJI8q9q3CFg0t9F1x/IQMxZdIPtf4MSPfDOojZtM2e3E6ndNyS+VFIwhP3P9fG42
 Guw8UoHfF1Xr65cRtqQXDSayraCjTz+A8d//tWRO/H3BIRsUTlSfQeiKcYZnrHP4Cn/afHk0r
 bz2AlzK8xHr1s1xzeoXn3uXwwnuSdY++k6sWRuFRYvu5R0Cn6ueSS99qE6z+xTXhstr6IEwlb
 IQ43KtHVPMlLz7AKjzdFy72VHgr/ZDANPtvbdTRXYNc5dg9dTd2cqECOpOfj/gSCcmPEViC5E
 w4ixigqzE7o7XzQIlVzmqDQ+LnKfDX60h6aw6cHd+ktpODFeMtMOaih7FA24fWLX7IO3xMqfD
 /tEmNzWGTmFaqgZ3dFBbII3blM45wePFmxlwD/lUK4hal3+liTDNl66ofV4vphQjS3bo+pCDa
 jqZ4V2wHkp0pWrRaKzm0vmo6igNRLEVDYwA4d9MLKD9OARNDswVDWHr+BlE7N3OmAjGWt8S+t
 ZGnUVVWXiuuS6zX32Q1c850HQIXNe13xTGRQHiqt7QuIKCaD82n6G8kbBHP+jyACKqx+0Q5X3
 dZGMbS38YHKcpTuPGB4ki9PeuoTtB7z7mb1vaFanOylhdtOdyhDdGNSagCdi029dDAo/eQNdz
 oAE/mJuMTOzgDrv66+/W8yt6LxNB6/6ggKwtbU9zEZXY9uz2yrfvfk0Lp1Zayq/0N5tZfpnIS
 JKJADWsOFPf+24qoK1qmYjrpi9gDaYi4/KDCqdNiK0otKmj49HJzhSALjXtyL4V2G6Fhg5jCu
 SMRr3EgNkoD3P0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 09, 2022 at 10:59:08AM +0000, Hebrock, Christoph wrote:
> Dear Sir or Madam,
> I have a question about "gitattributes text".
>
> I find the sentence "When the file has been committed with CRLF, no conv=
ersion is done" somewhat confusing in the context descibed above.
> How is this possible when "text=3Dauto" is active to commit/checkin CRLF=
?
>
> Set to string value "auto"
> When=A0text=A0is set to "auto", the path is marked for automatic end-of-=
line conversion. If Git decides that the content is text, its line endings=
 are converted to LF on checkin.
> "When the file has been committed with CRLF, no conversion is done."

This is what happens in real live, and what we try to describe:
#On a Windows box:
mkdir test_repo
cd test_repo
git init
git config core.autocrlf false
printf 'REM my first BAT file\r\n' >test.bat
printf 'REM exit' >>test.bat
git add test.bat
git commit -m "Add test.bat"

git ls-files --eol
# Something in this style:
i/crlf w/crlf attr/            test.bat

Now the file has been commited with CRLF.

Does this answer the question ?



