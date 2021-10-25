Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF453C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB68660EBD
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234594AbhJYU70 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:59:26 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:18463 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234704AbhJYU7U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 16:59:20 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mf71c-000A9m-Dh; Mon, 25 Oct 2021 21:56:56 +0100
Message-ID: <b485b282-2b26-b9ab-da5d-ea59f5fcf463@iee.email>
Date:   Mon, 25 Oct 2021 21:56:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Summit topic] Let's have chalk talks (part 1/?)
Content-Language: en-GB
To:     git@vger.kernel.org
References: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Emily Shaffer <emilyshaffer@google.com>
In-Reply-To: <nycvar.QRO.7.76.6.2110220950020.62@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/10/2021 08:51, Johannes Schindelin wrote:
> Apparently I have to send this in chunks, to fool the Bayes filter of our
> beloved mailing list into doing The Right Thing.
>
> This session was led by Emily Shaffer. Supporting cast: Ævar Arnfjörð
> Bjarmason, brian m. carlson, CB Bailey, and Junio Hamano.
>
> Notes:
>
>  1.  What’s a public chalk talk?
>
>      1.  At Google, once a week, the team meets up with no particular topic in
>          mind, or a couple topics, very informal
>
>      2.  One person’s turn each week to give an informal talk with a white
>          board (not using chalk)
>
>      3.  Topic should be technical and of interest to the presenter
[...]

A 'listener' perspective..

At the summit, the packfile's packing algorithm was mentioned as a
historic 'chalk talk' that's now in the technical documentation.

In the meantime, while chatting to a colleague about the birthday
paradox and its relation to Bloom filters, I realised I didn't
understand what our Bloom filters were trying to do and what they recorded.

I had a look at the code and documentation, but there isn't much there
about our Bloom filter implementation. A chalk talk could later be used
in the same manner as the packfile discussion to show what the filters do?

If there is someone who'd like to talk through what the Bloom filters
are doing in Git then I'd be all ears.

--
Philip
