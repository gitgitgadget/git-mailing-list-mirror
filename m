Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F209B1F597
	for <e@80x24.org>; Thu, 26 Jul 2018 12:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeGZN4O (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 09:56:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:52939 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbeGZN4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 09:56:14 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M3eDF-1fzmrQ0WgL-00rEnM; Thu, 26
 Jul 2018 14:39:21 +0200
Date:   Thu, 26 Jul 2018 14:39:18 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Junio C Hamano <gitster@pobox.com>,
        Akinori MUSHA <knu@iDaemons.org>, git@vger.kernel.org
Subject: Re: [PATCH] sequencer.c: terminate the last line of author-script
 properly
In-Reply-To: <9ecdf160-bc8b-b91d-a70e-ca6fb9d2a756@talktalk.net>
Message-ID: <nycvar.QRO.7.76.6.1807261434550.71@tvgsbejvaqbjf.bet>
References: <86a7qwpt9g.knu@iDaemons.org> <xmqqwou0xtar.fsf@gitster-ct.c.googlers.com> <eb66f8fb-1535-37a8-526d-ed31f06c045c@talktalk.net> <xmqq7elslayl.fsf@gitster-ct.c.googlers.com> <9ecdf160-bc8b-b91d-a70e-ca6fb9d2a756@talktalk.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4roVqwmOk9kIm0ZA6SUS79Fr0p7vZK1CppAkNHkhldW3NG/cEap
 f3fVJKSFBDeqRw/gn2iS/0930dgAAlToBOwDzaVmK/FyDAq+oet43zuyU4SRPSPHTcM5SSS
 DjB/VbU/Z+K+MlKGg7DdUKU58Oe4NbLSYFTNpAX37r+KUNO4ZrvguWXfWDrTrfezQL/p3fc
 obs/y58LAlfvHg7xXsSiA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cRsYoH3P0Mg=:OMyAUIsvSeH0V9JSVyZDt4
 n/iuTz5uEkgqZlESZRzZkACguMgj98yAUA0KIvrxOrKKwcWC2hWdcCGQR3ZOsB9gEubLIzisy
 GhlfkhBLFZAIx49tAi4dvVXRJHjYsJOvrY7pnF43xLgAkLhS8K8XAOGvvgWTv6EnhmFIOo2Tz
 Vrr/JgNGWTPuf498hzau6X8+ehnSCgY5TkCxr9wTCKBiLUhu0jwsBj4n0Gap7uFNhSKCYyRBQ
 iPtOA4LDtE7RzEar/E33IWVJwhYNZjcZsmxNI5I8lB8uFiRT0QA1DT8dOdEm/g6KCIstONH4W
 7xhWZa9jyTFWfqUGMyzSbSluSNJgmEvdgrIVubsCCGFcvj6l8ZvHZVDkjcYELJM2lUbXCvXB+
 DuvoIZXgnP7XZBEcCkgi5jz07CSdLTJOZ96lNfTnzKJQZVQOWdzM8/ZGABa7Kk0PK6esowGZB
 4rfovU/V7BuDGc66kWPWIxIQ5dtbTkPvaAywYzu3lJcIewXZY1VXugS62ficu3VoZCBqn+SuO
 o6vBmWPmx+j+oESOmfHRodMoLrs7UR1y+CIyTsEEOk9C398cFlt6akS15uxrK9kVKckGb/BpG
 Vwers+X9QoRgio2CQ+0dL8X8IENA+vmfFQOxjYDyDlVNcc2htkhcF77xVxC99Iz1p5Jr6edyZ
 LKkrCZXJM8o6dxmtfQpqHb/eqshpmNw1F4S7Ew5AlVJe0hnOOLdUaw87qUqdQtGt/qUx91KXS
 PHfAMutMcTdPDrQRiC4v2EfOXxFCLFoN67rCEXJSR/ABZnlInygxr7geVrYLXVPv0Lacr1Xk1
 a42w3Hm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Thu, 19 Jul 2018, Phillip Wood wrote:

> On 18/07/18 18:17, Junio C Hamano wrote:
> > Phillip Wood <phillip.wood@talktalk.net> writes:
> > 
> >>> (I think we had code to do so in "git am"
> >>> that was rewritten in C first).
> >>
> >> The code in builtin/am.c doesn't try to write valid posix shell (if
> >> one assumes it is the only consumer of the author script then it
> >> doesn't need to) which results in simpler code, but external scripts
> >> cannot safely eval it anymore.
> > 
> > Are you sure about that? If so we probably should see if we can fix> the writer, and better yet, if we can share code with the writer
> > discussed here, as presumably we are fixing it in this thread.
> > 
> > But I do not see how builtin/am.c::write_author_script() would
> > produce something that would not eval correctly.  sq_quote_buf() was
> > introduced specifically to write correct string for shell's
> > consumption.
> 
> You're right, I'm not sure how I missed the calls to sq_quote_buf()
> yesterday, sharing the am code with the sequencer would clean things up
> nicely.

No, actually Phillip was right. The `author-script` file written by
`git-am` was always an implementation detail, and as there was no
(intended) way to call shell scripts while running `git-am`, the only
shell script to intentionally use `author-script` was `git-am` itself.

Ever since `git-am` is a builtin, the `author-script` file format could be
changed, because it is an implementation detail, no more nor less, and I
think it *should* be changed, too. We're spending useless cycles on
quoting and dequoting, when writing a NUL-separated list of var=value
pairs would be totally sufficient to our ends.

Ciao,
Dscho
