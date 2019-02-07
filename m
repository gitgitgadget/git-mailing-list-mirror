Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E30171F453
	for <e@80x24.org>; Thu,  7 Feb 2019 22:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfBGWlm (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 17:41:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:46219 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfBGWlm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 17:41:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LvVUR-1hJ04C2o4p-010dVK; Thu, 07
 Feb 2019 23:41:35 +0100
Date:   Thu, 7 Feb 2019 23:41:35 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/1] Fix incorrectly reported CPU in 32-bit Windows
In-Reply-To: <xmqq36oznvxs.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1902072340430.41@tvgsbejvaqbjf.bet>
References: <pull.121.git.gitgitgadget@gmail.com> <xmqq36oznvxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:dkELtyk2RwNGAQbYUnC4ebg3mnmVx+Fi/8i6adyZPIAS1BtNcRF
 vo+K9g8E5MGHZgp8ouI+LKRYo/O3bQUtrdibmmOYdlgaQavWdNFhslCLnYQFFlpRWTtwV5i
 E0xwuAYMC6HUfMJgI53r8+G/Z5IjQs524t9RqC1cER/vj0JYtWqZEMCxsJzoXqq1eEtQZHN
 XSo2FtOHZDmsswKkzATow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/k5eh3RCFoI=:lzrzODcyNfk+1vclb36FtN
 L/4K/4On966yUS+18OVj0PaKORi2zfJI5q0j36bumRnIX9957ta1GAc711J7xZ5/yrG0VXokK
 va1cM2vqw3GykNEDjmrJ/jxOR8z1bX/m+rors0+eugOprwSkX42tTg8eBe4QlkVG+yg4M14f+
 YvhgLIwSIZwkKBp51FmDkh51oP1pJWmwkICyjuU8M6bbmHLoDrBE538104UhHnkKPrq+o2NRX
 TrgHXKx6Z3vXKnZGSUluqugcCEyFXEsIYYJEFE/xrxc7eyXcM+VXWdFgNBe8K0arAw3LGf8dX
 UOJC1f9sbATwQid7SzqCAFpWszoaJ1YXQCfm/6uyP3ByeGv0vVp63OX2UOUV4YL/UIhWutDNG
 WUHHhS0+JbwX620Nc/d+a1Le/KMfARAH3oHWQZlJ3+eGDwB24b/SwxXXiNXY3AvOj7fo24mt7
 PQkKFr19aInixQA0WXBN5/vKXv9arfUfGZRKI1Z7/90TkFk+piUj+bIt+ADW2mvHdxpqqpRD4
 Y8JZecswzZwzVKjbfDl0zmiBVvXBSAXrpr9CmQXJfkhePDSGQplKnQDqr2+8stxBjR3ePK3j0
 TbRLklttW3v8+DD0j0KWoxCWNU9d75AKyckgGrTo3Hg5vL/foCSaZxIDVY1Ce/mKaYHe+mkv5
 9HiZy52aaeg2/TN22VkOtVF4YvzthW9R+Mg+H5JaKfiKpsQjTpBRRNkbGPgj9pS2WW4Eod0hZ
 1Irz30rBhNDfBZ0lZ4inaPktlOHvifNZXpVxOYOcEGtKPXAHA0FUDq5cHn7nKnzsc3IRSPO9Y
 qbRSfZXaFrgAASvUkRq1EJJFd8zhhGNIMaNKP2mTLlS/TjT8irDAYp8PeWlQiaR10wIGhvdN+
 D461rYcWQZ47TkVJKUs7lQcCJZkCAnFA9mubU+rpm76vFZFIFrmJEdLamkG+2X3uGKE754H3T
 StBf0mvtUGQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 7 Feb 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > This is yet another patch I forgot to upstream, and I hope that it
> > will make it into v2.21.0-rc1.
> 
> I guess this affects nobody other than you and perhaps J6t, the
> point not being "there are only just two" but being "all of them
> know how to deal with possible breakages if any in this change".

Correct. This patch is already in Git for Windows, so contributors
building from that fork will have had the problem already.

> I am tempted to bypass the usual "from pu down to next down to
> master" dance on this one, because of that.
> 
> ;-)

I would be very grateful for that :-)

Ciao,
Dscho
