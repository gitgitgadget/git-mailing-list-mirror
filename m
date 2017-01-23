Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C61720A17
	for <e@80x24.org>; Mon, 23 Jan 2017 15:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750705AbdAWPN5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 10:13:57 -0500
Received: from mout.gmx.net ([212.227.15.18]:49577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751130AbdAWPN5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 10:13:57 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MNqfr-1cbyuJ4199-007YEO; Mon, 23
 Jan 2017 16:13:53 +0100
Date:   Mon, 23 Jan 2017 16:13:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Tushar Kapila <tushar.kapila@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: sparse checkout : ignore paths
In-Reply-To: <CALNyQkyy_prP60kp_DpMzG9+affqPW0-z6F81R4OSgHg0QFc+g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1701231613210.3469@virtualbox>
References: <CALNyQkyy_prP60kp_DpMzG9+affqPW0-z6F81R4OSgHg0QFc+g@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jNUYoaFCsW+/NofT3pl8dP6X6ob0j2s6NXVItdBds9lLZz3iuJb
 nC4M2cB92GzNEm3G4veQQkzFcHMRMiIo1SNuvCQ5QW4HQk2oHZ4XqrNnwMdVjFCCw+xHKey
 Wci9eSvEUrU/Sjw1t0GXFmnl0VPuH7+743yaLop9gzxBQ1I9DUpUsH0BIo1Bqdm6sBC9kCl
 wXvkRhoaUvICbFGnKnQmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:z2jil3bWIhM=:xb4Hcv61l6VxelHly/kkx3
 MCjY1FYI4xLnFqeHKxPAjlokLUTnqBKaCFKNUziuvHMQHgyNuNOIQnUvle4dUptywKG4Vyo7G
 cMD5DqvXnG2q4Zbi3SOqiL/55zdQ0m6tgrkCiNIiyO/d/izx0eb30aFBwU3QgxefY+5sGa0xj
 COG6x1QFdve/2H4iLbW9EjTKOIFJtJYUWI84BwOluXgH6njaEkLI6ZmlHFGZG1QptlcSoVV6d
 qhTY8n+ESTaR8Fm5ZLKxLiq/mcGwE0MK0CO8jTFVxkWbeEZP7bHbctycQJX47zR6tZ4jkV3EP
 woPj0fsojMEKYq1QuQNkyxfW6EheBIrL9U06Fd/ZPpq47DCBHLTr1j+AS6+Oa6C0UrEdYABTc
 BD5REz37yatR6+Gvh2RVU3c5IUxO3iYZy4KL13wtTw6ibuZ54vDKmwf0bDAHFxBmR33PQhe4U
 0X0UXnvRf+V259znBsq46H0ew2ExAABrLG10nu9W9QrRzieG9ztGkY8CQ3FjNAgoLY+2uJq7o
 CVb1anYd7KC2EzGtKT0UJ8es9bwfv+vbejFG/9Mey6M67BytX1e3LoSBlZUNobzBtT+NG2SAb
 k2NbG3+Q/569SLyDszPh6bVFsvWIgKW+OY0x8SfzuR6nOkbXCypoimI+hwzxsem8Hb4VZpMBq
 PhwVbgROP3n+9ydUNqhjzQEdUqRd6CYx2CA7WHQ8TGKVa6uRI4BWnZIME70G2zNp6qhcpSmzc
 TH1bQeR5/iPh7Mq4ZmOFoP2DlE7x+yEQgGF6LIkUlRxyIYe1QqIobBbSi8Px9q1DFlV6q9LWp
 LQTk7LA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 23 Jan 2017, Tushar Kapila wrote:

> When we clone/ pull with : config core.sparsecheckout true
> 
> We can specify paths to include. Would be good to explicitly specify
> paths to exclude too.

That is already possible by using "negative patterns", i.e. patterns
preceded by an exclamation point.

Ciao,
Johannes
