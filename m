Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30CA71F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbcHAJfS (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:35:18 -0400
Received: from mout.gmx.net ([212.227.17.20]:52649 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555AbcHAJfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:35:11 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0M2nfO-1bB6ZG1hsE-00sfkY; Mon, 01 Aug 2016 11:34:52
 +0200
Date:	Mon, 1 Aug 2016 11:34:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <xmqqmvl2ty31.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011124440.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de> <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
 <xmqqmvl2ty31.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:3FyoC5UgBqQ3hTdGTNiQclZcJFBHjxDQlkoV+zQKE390FNbejHA
 7B9Jy0yv1uapnAdz0AX8BpERSoH+HsvDHmO+KLNhiuXShMGFF8CR33/MAFmvlx2Blhp8n7n
 3J7kLaz0Sbsgdfi0920JeneB4rGUATdDtGctCE1oKueEtEFQNvi5eNJc5KDkne93t8JL8Is
 xqqF/EX1kyycPoyvl8Ijw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:W+ESIzP0ayQ=:6K26wFeH4GDSCG5JUKb79N
 MkLYijY40OwjXPQ544HagcaBDScq6DqxU9LIlwzNSgEOy3JEXvswef2lljK8GMOco62oROgK/
 0vddtjtl6CaNnB7n+c9xRTyMAk8YHFNIUW6OpeUEhftYS0b9FSqt2vJMmft65y3Ul0ecPoqku
 VnQ7BPfTJ2nOxYsba3ALbrBcJDcLVZ/nRkXU5ScpqGDxw8zUBmlWUqRaAvgCmZiryuZKKrM2f
 fDTGhVbS9hgG/py0P8ifW8Z+ufJC/qQuQXmcJ756iDVzJv6Oh2hjF0xT9ArAU6Okq37D8/8rl
 TgOfTOHskMXDXG5pt2MXm4tsbGY4bkhOwtzZAody7SIQjsHFtcRUOwiNaaM/dlP73ezsS0wJg
 D7BbDwzkApV+xEhiHw2gQchfz9eBvJuH+14weyE076Z/pq/idHVHDPuao5lCkk09e7bhUccu3
 0Gq5oTZzxAe9BG9e8vHhzjvEkA4aGWO/s4DBW4W+fNij2MUE8+gClN8pHph5jIirjO62qdotq
 wcCdXeiJh34AT/VJ+uCSQ2MFayUXrvdj9ltE4L1FwIyz7+JIbPzZjaB5lE5QT73tVasmQtLRm
 DXVkvM4upF5fi9jVVPfKqj4E7wgIA34qabjJ3j0UbnONFbaRaNdyAsLKoVTv3qn6ck0ihAz9G
 j7DeuFrI/2FWZ0JPiCIOvpTlstMbKg/ney9FzPiCsHkCqkWEmkuHsEqdQwQYsEyf4+T6iXvnp
 s2Boh8r08O/G28AZ07AcgLgMUhAFVPawbg2pHUSHFh/SNPkrifd0yKEYkFefLqbxZuyatLplE
 y2tZEHQ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am not yet sure if it makes sense to mix both the regular output
> > and an error into the same buffer for the callers to process (your
> > "reason 1)" above), and this looks like a wrong way to allow a
> > caller that wants no output (your "reason 2)" above).  A caller that
> > wants to massage the output would want to know which ones are errors
> > and which ones are not, I would imagine, and setting a knob to make
> > both output() and err() a no-op would be a more suitable way to give
> > a caller a total silence.
> 
> I actually now see how this would work well for "reason 2)".  If a
> caller wants to run the function and wants to pretend as if it did
> not run anything when it failed, for example, using this to spool
> all output and error to a strbuf and discard it when the function
> returns an error, and emit the spooled output to standard output and
> standard error in the order the lines were collected when the
> function returns a success, would be a good way to do so.

That is actually the exact opposite of the intended usage: when any `pick`
in an interactive rebase succeeds, its output is discarded so as not to
bother the user. We show the complete output only when it fails.

> That however brings me back to the "reason 1" thing.  Shouldn't the
> spooling be done not just with a single strbuf, but with an array of
> <bool, const char *> tuples, where the bool says if it is for the
> standard output, and the string holds the message?  output() would
> mark its element in the array with true, while err() would do so
> with false.

I would like to *not* deviate further from my original focus. My
willingness to address comments that have little to nothing to do with
accelerating the interactive rebase has cost me already over a month, with
this patch series alone.

Do not get me wrong: I think you are right in your assessment that a
future caller of the recursive merge might need to be able to tell apart
which lines of the output are error messages from the rest, and still
retain the order.

But then, maybe no future caller will require this.

What is certain: right now, no caller requires it, and neither do my
queued-up patches to speed up the interactive rebase.

And another thing is also certain: *iff* a future caller really will
require that fine-grained information of the output, then it will be
dramatically easier to implement this on top of the patches we are
discussing right now.

In short: I hope you agree with me that it is safe to defer the <bool,
const char*> tuple implementation to the time when we will *actually* need
it.

Ciao,
Dscho
