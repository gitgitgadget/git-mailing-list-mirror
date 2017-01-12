Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1BE3120756
	for <e@80x24.org>; Thu, 12 Jan 2017 10:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdALKIL (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 05:08:11 -0500
Received: from mout.gmx.net ([212.227.17.20]:49900 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbdALKH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 05:07:28 -0500
Received: from virtualbox ([213.133.108.164]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MCL6r-1cIZj72LSL-00980I; Thu, 12
 Jan 2017 11:06:00 +0100
Date:   Thu, 12 Jan 2017 11:05:59 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jacob Keller <jacob.e.keller@intel.com>
cc:     git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 0/5] extend git-describe pattern matching
In-Reply-To: <20170112001721.2534-1-jacob.e.keller@intel.com>
Message-ID: <alpine.DEB.2.20.1701121105070.3469@virtualbox>
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:uIH8EoWemB5n8FbCvBnxe4pKJaGx9Rirevoh15AIqPscEm+KYZh
 yCU+1LuRDXH1tNwLn2Qx8ACGnK1CaOWZpoXdqoG2J+W9pyB/3xK+fJfLAnCzfdkTVkPh+47
 IoUO/PMYiE4WOVRwh8/eVA/PgguAJyXTZDSoyKJJGpDBAcdJNywV91uCEu1nuiix62idsN9
 st4NnKta5AiYdqXeQZ3GQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1xZVSo1vE3w=:frbNIOZVhQHmnCcvENeHFU
 H/qHcGXp3C92NBkPHoIhk9knX+kQiqnYJLoiuzCXfP2tDwiQK8Ji1DLVrJQQkl7VekvetXEgo
 as/sZch+eKJAQGKd3AKe0w4WRmC2EryW1+3vav3z94jWeJ9v6rdkTsJDF+D9wAASIuR5p81A6
 Cw52UQ1lJ77plf2jAPG70+Y3I13vR0dWvV8V4/PG8CNB8VCIYFwMdYVACs9LgjN9y5YikRUQx
 SIqbsRcS7+CZWCjmlkRPqL84C1SWGOhOND6HVd6nyqxq6h2KG4BMtPwSVuC9Rpdtps+VqD72r
 1dwUeEvxd1+/M97hqsEdXH8Rvwn6sdPSeuhsQCacJilwBOwztGb57WTXjN/auLNw/lJaHuULP
 KrVCWd2BJrpTDy6JmY7RhX7ikUukGUriEyl7TDYfs5oP4MtYXhwFTwbxQNYCXYDc4Vxl3fAUs
 CqKFcdvJvQJ4JEkcz0P4sNQpczDmMt+wcg2eBiCc4W16LNYGSVw9ET3ZRJysTcbTHUH/CjrFm
 dfcVL5/S3W0lRSitj5QmDehIFIw4w/s7o9WqiHtcXYsZl1BfXxSH/ALDxDSBkdBRYLus/JMUn
 5LA4OaG+eRhTY73U55vU5IPOqhVzcwVQVIp0M1HZwojWLRvkzCJJeCUnyW3gU/aIynIy9n4qj
 i78HY0dw9xOfMd7NH4aPMyzsGQ+mZpPYVNQbv3jwNqO24Od3nxPbc5dgdnVWcIBuD/u550ih3
 Y+Z6ublBbEEZMLzGC6qgjZMm4oodyBlHHMsfXsc/CETMdISFjEPY4u5cFLv3UTzhzygrf4lt7
 MB8SrwTG+0QWTrgf9+uweQgC3+InQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake,

On Wed, 11 Jan 2017, Jacob Keller wrote:

> From: Jacob Keller <jacob.keller@gmail.com>
> 
> Teach git describe and git name-rev the ability to match multiple
> patterns inclusively. Additionally, teach these commands to also accept
> negative patterns to discard any refs which match.

I like the idea, and I think this patch series is already in a pretty good
shape, offering a couple of comments as individual replies to the
respective patches.

Ciao,
Dscho
