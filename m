Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66AFE1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 11:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeBTLpB (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 06:45:01 -0500
Received: from mout.gmx.net ([212.227.17.20]:38365 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751416AbeBTLpA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 06:45:00 -0500
Received: from MININT-TB4PCE7.southpacific.corp.microsoft.com
 ([37.201.195.115]) by mail.gmx.com (mrgmx102 [212.227.17.168]) with ESMTPSA
 (Nemesis) id 0Lxdfb-1eiZkV3JiV-017Dlk; Tue, 20 Feb 2018 12:44:52 +0100
Date:   Tue, 20 Feb 2018 12:44:51 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Hilco Wijbenga <hilco.wijbenga@gmail.com>
cc:     Git Users <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Is there any way to "interrupt" a rebase?
In-Reply-To: <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Message-ID: <nycvar.QRO.7.76.6.1802201240010.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAE1pOi1XtrWqG7mOdrNt10YoZG0LOAB7i9cc1Gi8oWhULxE57A@mail.gmail.com> <20180219223653.GE6619@genre.crustytoothpaste.net> <CAE1pOi070p9VNPnLS3jSXp7TrbR2fhOc7sx+58exAp92k4D0dw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802201147300.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DhN7WWg71Lk1R6a3cOD9gAyeE31jVsB8NiORR1G+piiXv+AcCR2
 /cTBNXPUVYWwigUgJsYIf/t0lbE4YYE0CTcyFxcnnEW4i3aiJR9i7kQTmppdbkS2CQtf95t
 HaE49+Y76qmV8fLdVJXOBTyIRCBSmZMddKKsPtlXGZ6AzOQO+CtsXOEE7M3aGB9cuNFfsQG
 XKqp5zZ7t8/qSYktCyilg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pkiE2j8Q4Dc=:38WPWiDxOExUhG5hfoH36P
 Ob/mLwsywf6rx2u3CxY6DE0tiMx8a2SGlqLj/7s3zCw+2phM9xSwDtVrqqQatHIB7TCaq5G97
 2jUU+FDC42gViGvQAu9ySvTpew15ADKVdNs71mlLTljYvn6vtycT6+3i9f0rh33S4L42DcUsw
 K2zrLJY1Mgv80R1WUtPzJOcibtIGs3HSEBLO0Qk70kEhDUS2GIOeLZMgTePBvwNrWp4lFPD9m
 rQQ6oVKAdcMtnmkKc+SW1OQ2fYJpfkN5bEvPlhKeGegexqooEPGegblKCkv/yRgwA1ruYZnCd
 zqy0k9EDRHcn5fewaA8+UD0KSzWF52StwnmS7gL1N4C82ShG2xEYRAjFJjcrCSauv+njxB2T8
 LPk22ORO1yxnzb+fHrveFDGQ+8TMUVgza558KephRExnvubOpgGTGNN9aFPNr9kJJWW0GvSUY
 eVs3Xooso8zP2DoEuwvzQ+38JWceGShMgahd86T8ZEDXm2BdpAFdw2DsULbTqKHKVOyCt1fOb
 zD9pMoAAuGvcO57k+IwS7MOyrRq7nr2VlrPh+v89pPr2qFD2LqaFaCUKMd/vlkJLdYVFwab2D
 KMZwJZkWyPvfst0jXEKcQ+qV3lN2djnlgPRTJ0+eNO8ppCOs7lasdx07j6NU3YOLt+kTTrjUQ
 U5f5yWiMUMpb2vapIUsZAnRMxnmBje6tkz7P3Gz5ME9J4wTOgP97H9hEJ9tigPYxaSlKuZrOE
 RKV4SD7uk1feXSCmCcRrrfRyNqezKmLoZwhCk+kLbcTe2Z9YNq1St9pIuyYClwEer8n7M2OYn
 koHuMv5xMOyAkQlbCJczN+Rfl64VadVns4L+mOU4szDiPi7ips=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hilco,

On Tue, 20 Feb 2018, Johannes Schindelin wrote:

> When I am particularly tired and overworked (and therefore know that my
> working memory is less useful than usual), I therefore resort to my
> second-favorite strategy: U use the `done` file.
> 
> I literally copy parts of $GIT_DIR/rebase-merge/done to the beginning of
> $GIT_DIR/rebase-merge/git-rebase-todo (the most convenient way to open the
> latter is `git rebase --edit-todo`). In your case, those would be the
> `pick` lines cherry-picking D and E. Then, as before, `git reset --hard
> <commit>` (where I look up the `<commit>` using an aliased version of `git
> log --graph --oneline --left-right --boundary`), amend the commit, and
> then `git rebase --continue`.
> 
> It might be even possible to design a new subcommand for the interactive
> rebase to facilitate a variation of this strategy (possibly even making
> use of the fact that the interactive rebase accumulates mappings between
> the original commits and the rewritten ones in
> $GIT_DIR/rebase-merge/rewritten-list, intended for use in the post-rewrite
> hook).

This feature might look somewhat like this:

	git rebase --replay-latest-commits 3

and it would not even have to look at the `rewritten-list`. All it would
do is to put back the latest `pick` from the `done` file (in case of merge
conflicts) into the `git-rebase-todo` file, then insert `pick lines for
HEAD~3.. at the beginning of that todo file, and then `git reset --hard
HEAD~3`.

By not using the original lines from the `done` file (i.e. *different*
from what I described as my second-favorite strategy), you would also get
the resolved merge conflicts rather than having to re-resolve them.

(This all would of course only work properly without --preserve-merges and
without the upcoming --recreate-merges.)

Ciao,
Johannes
