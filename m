Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 362A020248
	for <e@80x24.org>; Mon,  4 Mar 2019 14:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfCDOJy (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 09:09:54 -0500
Received: from [193.29.56.124] ([193.29.56.124]:55312 "EHLO iodev.co.uk"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfCDOJx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 09:09:53 -0500
Date:   Mon, 4 Mar 2019 15:09:47 +0100
From:   Ismael Luceno <ismael@iodev.co.uk>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH v2] git-gui: Handle Ctrl + BS/Del in the commit msg
Message-ID: <20190304140947.GA2449@kiki>
References: <20190216031051.8859-1-ismael@iodev.co.uk>
 <xmqqbm36w7hl.fsf@gitster-ct.c.googlers.com>
 <20190221093059.GA6594@kiki>
 <xmqqa7iouavw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa7iouavw.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/Feb/2019 12:47, Junio C Hamano wrote:
> Ismael Luceno <ismael@iodev.co.uk> writes:
> 
> >> ....  I am not sure if going
> >> back by one character from where the current insertion cursor is and
> >> further go back to the wordstart would give the beginning of the
> >> word to the left of the cursor, though.
> >
> > ...
> > Current implementation doesn't behave correctly when there's multiple
> > spaces:
> 
> In short, I wondered if it is correct, and you say it is not correct.

It's better than nothing, and the behavior isn't harmful.

> I would be surprised if git-gui were the only program that
> implemented an editor-like feature using tcl/tk, and none of the
> other editor implementations using tcl/tk had such an industry
> standard "delete previous word".  Perhaps you can see if there
> is already a correct implementation of the feature this patch can
> borrow from?

I couldn't find such implementation yet. I'll come up with an improved
version if there's nothing else, but in the meanwhile it's worth to have
this one merged.
