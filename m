Return-Path: <SRS0=+MKA=Z6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C3C43603
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 19:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59FD205F4
	for <git@archiver.kernel.org>; Sun,  8 Dec 2019 19:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfLHTkx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Dec 2019 14:40:53 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:37051 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfLHTkx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Dec 2019 14:40:53 -0500
X-Originating-IP: 157.36.244.240
Received: from localhost (unknown [157.36.244.240])
        (Authenticated sender: me@yadavpratyush.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 0E7EAFF806;
        Sun,  8 Dec 2019 19:40:49 +0000 (UTC)
Date:   Mon, 9 Dec 2019 01:10:46 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-gui: allow closing console window with Escape
Message-ID: <20191208194046.csf35b7rgycst2vc@yadavpratyush.com>
References: <20191206222040.toj4enbbbbamnrww@yadavpratyush.com>
 <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1912071723010.31080@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/12/19 05:24PM, Johannes Schindelin wrote:
> Hi,
> 
> On Sat, 7 Dec 2019, Pratyush Yadav wrote:
> 
> > It is often expected that popup windows like the console window be
> > close-able with Esc.
> 
> Seeing as the console windows is not your regular popup window with an
> "OK" button, I could see how it would be all too easy to close the window
> via the Esc button all too easily, annoying users.

I'm not sure why it is "too easy" to hit Escape. If you're hitting Esc 
(which for most people is pretty far from other more frequently used 
keys) you expect _something_ to happen. People don't just spam Esc for 
no reason, do they?
 
> For windows like the console one, I would expect Ctrl+W a much more
> natural keyboard shortcut to close it.

But, that "something" the user expects to happen could also be "stop the 
command". AFAIK, Esc is often expected to stop commands. But closing the 
console window won't actually stop the command. It will keep running in 
the background, and when the command is done, the window will open again 
showing the final output.

So all in all, I do think Ctrl-W would be a better idea. Will re-roll.
 
> Ciao,
> Dscho

-- 
Regards,
Pratyush Yadav
