Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF6EC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 05:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239590AbiCJFcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 00:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiCJFcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 00:32:11 -0500
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA8B82D3B
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 21:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1646890261;
        bh=Qi0+qX5gYHcsSDX+ta414DtyNv/V7Mh+5lDfT5lPY04=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=pY6y02uyzsFTOOKtTKt7W4y6R+N8QNr91m1rIyqxExIudIvZaLwK/TJNz2WMukZhw
         cKb7cmc/rVrHdb7OJOsnUBBtcAoi3EyQ5nL5R9uf5DzQo6pOvhvHhZWblOoaDG1Tb0
         WhpZ4HKyoG6BOxhhuPxKJ/vziilXmIrtZ+ojnhdM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MtyA2-1oHnZZ2Q60-00uIyB; Thu, 10
 Mar 2022 06:31:01 +0100
Date:   Thu, 10 Mar 2022 06:31:00 +0100
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        ??var Arnfj??r?? Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/27] Builtin FSMonitor Part 3
Message-ID: <20220310053100.bkz5z243b3kwndos@tb-raspi4>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:FgS6lRUocBnQCmGcGwhGJQBjNLTIvuWYQxmeTDWI3rRbA3OJdaS
 te+w7ZV14ASOzRxRuOCHZty4vpAPd4UA5qPMzxHriqv78tjCBA0yHTOcduC2aAC+M8rxWb/
 RCGtLrBQe694HQmsiUnIDeYwwNAhdA+Z/hJtR7zL4ts6NO4OYNK2f8U+QGOZKFI8R2fgjEl
 IvucF7IB89Uo/W3mcIKGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0OMwODdH+OI=:lIJHrpYkx8Y/vFNK0BFfyC
 BumMGM7Fhkhl/rTajCJ8eJ6/8xNRQE9tEZp4jvAOO7vtXsAHVnRkmkchSTUrkKQLngrnIdvch
 oVORHmwsqpceMrdX/CzV21E9+WupRG/IfzoXGE+M2z6CWxBLyIBhSkk+NLCLEkfWwmiVTUndS
 7zsPKWoyLLXeHRtSNrmVQCnuDfHJryr5+4Y5pBq73oExaxlesHCGSR4B73AULnZjI2jqQo0MX
 ZlNH/m+WPq+irURFj3qc/+y5t9PHZZJOdPPw32y0ate8dnxrTUsqVD1AbfeUVYoXNJINFkTaz
 yaQNRblnZktRtuHVwnHVSqpJ4S6EB2HrM5lhZCIl4jScvpHTnEGw65A0351sgN8VszbVlgdoV
 ER8PqPgLsvIInT6uvt3P/ZThTGb0MTv+lhYxYk+WQ/I7+1kKUNq79x07SmxXEG0YFvfhtUPMa
 5WEm5kdp9/UQVbzPfcepIyDqkbkvIQc8x7nPGZHPAwof2bTNDDYFpYAhSC87ALJK7vohSUx2k
 CtQsC/SBp6ED2Wm+DMGmy7ro1X2Y3LvX0sMtrmXyzjhtVDjan/NXWQ2sby6EgAbyVsGSxDMBb
 Esd5/KbBxoTOQ4hGUud1z5h3IIXRrMuZdLjvWBPEyo4S28P1d5sYW8ez8YvHXrwzoGcawLS9C
 bsEtBLsQTHEA/1KWp3qJ4U8LQZSVNtkFhu7b99EPxMvUwKqE9yEszD/Hsu2AUT66DhQou9e8Y
 9UXTcALk8kaV+xl23Yf7VTZHB0wJLGeVApLueSY3cYVldBtk42Vvy7LAph+xTfUKxDs/TqRVP
 mtHFmoHw4oLxl2xI4p8RMxlKFwuHSCCamLRLqgL1V8ztMJxumJpG/LQ6f26Dzwz5XXs/jmyAl
 n6+tsjaGdZqCVjkUoaMXufH6OiCR5BeUE6xz4LBtiApNFf1UQ33ttr04ljTxCOoiKuKn5aEDS
 YC0lp7WXH55T/vAHMm+NoC3YACSrLjgE0lSu5xOx7tppZG/GoQWYeCYJZXP9+NSIhVIYoKzie
 aklEuK8qf+LSXwR1g2Q8nASAySBZFZQscSqgyYjM2ThjIpjOXmIGZ4vEPX9AnBQdtn9aOXOvX
 I3vBDDkP1PeC3I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 08, 2022 at 10:15:00PM +0000, Jeff Hostetler via GitGitGadget wrote:
> Here is V2 of part 3 of my builtin FSMonitor series.


Hej Jeff,

First of all, the new test case passes here on one machine.
I will do another round on another machine the next days.

Having said that, there are some small questions here and there,
I'll send them as soon as I find the time for a more proper review.
