Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 987C71F404
	for <e@80x24.org>; Thu,  4 Jan 2018 20:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeADUeB (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 15:34:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:49737 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751829AbeADUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 15:34:00 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1FAK-1emW8g3JdY-00tF9L; Thu, 04
 Jan 2018 21:33:54 +0100
Date:   Thu, 4 Jan 2018 21:33:55 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com, git-for-windows@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.16.0-rc0
In-Reply-To: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1801042132540.32@MININT-6BKU6QN.europe.corp.microsoft.com>
References: <xmqqfu7ui2af.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5rUBUIPrTLyZNb2d7MN9NEJhW6cmLe573pL94o40jQUVIKyXb7X
 bu+E+xzLCooh6FsgfVl9xpv0PWofRW81RzGdlcQ7dVUJlorvKfaBeUSPivg0C520ZG8Jg8e
 Bqait6AYK4N1ikPmmTVDHfUNlKOlw00U0vmQI6oCHGZrHDOIj/yNIueRjUmGm156Vi08NGM
 KMmbvLwtn+0BUQf3HoUFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Xr9m7qV6PUQ=:IcBb0QehIwCuLOdQ6re+Iq
 U04idjOIvDpkqvK5ZiKOohNca8FedM5fZ/LVLyK3pbOFmJI/4GN0n1cqy/M2mET9fYxWWNph8
 8nXooOCjJNwa8/RIsAkimIs/vQT8BILsOzrYEOb65DJtyG6hnAzrWVYYMreYXZPb21Whli72Q
 nwx17CRAhrX7ATTUwY0NBbxi8QNkuyz/vAoPeBYzx4mMLTSXwf9K/Qm9Gc4HGmdVD9ixEpsCo
 isBjCrLThq9JuByti3cpzyC3/sMoZ1cBaqbpdrfx629vbLit0miUPc8d5x8Udg1St0hJYpVF/
 NfPKTKqEbCb3pvgETnnXkdqZrGyqQ9ATthqDnpt2U5irlVUi1F7n3gYjQwxgSDx8ypxyiDh3R
 q1pMYj3DBVVStgZHSg2njr1Pg6ZXuXksXYHbxxP88VPKa70gcaq3j+fnCbylEciY9yBXCjYkF
 YGDKo/rku0902Z3oQovMG9GeH5o2OPAFWiv7FWjc7ensfLhCJv3l//orzqUQo3cdZIWHL2/hz
 BDCV8aEufJ97BRu+cPOx5/GymiHUPmn+KY2/KRBV521geWgPfnMFuxxKyQlegDw6EI3xqhFtG
 sMDWdJC9dyomJ9A1loaQKz+/oiQSqTqHEXFiiSjZSk5iAm8OGV5WmQRLnrXRGKOK12Arxp+Bp
 fJHamioiQ/B+ZaxxkJN/pXuvbcwDygezpPA5xjj7iSB/oKfKV+D5+/8SRkhHGJrTdUqqv5Pa6
 3ZI55DFWOJoKQxtOmSE66W2UxQf++82jzPSIPR1iVgLdeOlDsxDq5SVxVAjL7LJAHc5nJRn+Z
 kjHg88NcyfZjYuhk+Q90qP6ckZflePitjClegL6KNMusg4U+q0CO8Q7LQldhEiOvFJlrJNH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Dec 2017, Junio C Hamano wrote:

> An early preview release Git v2.16.0-rc0 is now available for
> testing at the usual places.

And a corresponding Git for Windows prerelease is also available:

https://github.com/git-for-windows/git/releases/tag/v2.16.0-rc0.windows.1

Ciao,
Johannes
