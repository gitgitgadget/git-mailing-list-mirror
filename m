Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281931F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfBHJDB (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:03:01 -0500
Received: from mout.gmx.net ([212.227.15.15]:39659 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfBHJDA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:03:00 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LlESk-1hQoZx1P8w-00b22d; Fri, 08
 Feb 2019 10:02:51 +0100
Date:   Fri, 8 Feb 2019 10:02:49 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <20180814223246.GA2379@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <20180814223246.GA2379@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-19373660-1549616572=:41"
X-Provags-ID: V03:K1:dZ3P2k68f0bpzvWSc8nLDwTYRRsr16oC20uubTYPpviYPQbWvTi
 n9gEj8ngdtgJp2C7ZCU+fY81FC7kBHn19nnL1hhH6hu5CqQL5bE6bRlwfooDE3hbsPWcexa
 BzvISeR+riprukE8rEXy0s2A5fOf9Wj6L8g9M8E3iYlUIb5y+2PwrmRo2I9NUBm7G0eJotV
 7XYMN/OmVCIzOB9pIfP8Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R1MUrUG3okg=:gre05+Jm0mDeveW9vxkGya
 LlCDt3yVwQ5vZX9IJ6Yyw7icxfL8xUy99NP0dtRg0ZK0pN5syv+qUpqCfRie/UNl4f8h8EhWT
 mLXfjHFh/ci0Nde8dOVobv5tqGzBqneumG6AYOknFqSCScdpV1sghn5NUI3SKWCdCOHUNcnX0
 xXZIXtGIH/JhBTYpE/2etS1xGhoxo9yVVCTCAmFWdPz+6aKt8FnsD4GhGE4Srpp3WKwSeFvO5
 KuvA37oXeHOPvke7225KtH8Edo7I8Fkj7H0XeQxMifC3uAXj4+vwBwso8KwILze80Z92g6rnA
 EZoJ+FeUH0T+WYV9Rx43/S3zCAKssTv1fXXs8CFXbJQZ+SfRniacEq1x0+E307l5UMdkSXfpG
 xKW1lUh12y18OWYdFPpQji7zF5YQ4Zd+A0Yyz4qMMMa59CgQguBMtbakN3UspBb8GkYrZsIKa
 Y6vrGSNMHak/DTX7KEovoFIocf+AYPcug25FBcH1UqjYbDltjmGvLXqaDJr7VIoeCe0Wel/z1
 IJzfqYLcYNa/i/NmzSwxPJobP/8y/X8LnYZGjSoNVQ39wCMjAvTNrwoHLZNd+gTQ+EBx4u6SI
 BjLiKSVeG+hYQ4+ZXtNCXOKjmoZ//BUXtYjNOQfEDLv9aT/Gxpl5wsVw2bcVbwZVE7q2JdKGo
 5wgeQxF3CsNaBbgKWQfMQQH1E6aq9e1L6eMSjDkrVYwerjB1TKVrBev1zJxisEevi7uDGvh40
 7s3vx2C5fIa0esQN02BO3wgUycZmzYyxf5qU193tN1+LFVEIzfYHkVsOvBYenFHA/IZ21VonF
 1xPDEr8C0Rte1t0b+2FFbnH9nD2xEcZQat0h1HG21ImwHO+izIzdDKA69AcEh6L97CXCGJXKA
 qvbCcL0zI6G8bY0iqo6ISWejJYV1YwJFypMOwrBhZqNLLUcpGpMmRXl2gtgP0N8JWWCjnX06w
 o4I8/pI29hw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-19373660-1549616572=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

I just had a look at the patch you provided below (for some reason, my
previous search on public-inbox only turned up Gábor's mail to which you
responded).

Admittedly, I do not really understand all aspects of it, but it applies,
still, and I kicked off a stress test here:

	https://dev.azure.com/git/git/_build/results?buildId=338

It seems that your patch fixes that t5570 flakiness on macOS, and more
importantly, addresses an important issue on macOS.

Will play a bit more with it and keep you posted.

Ciao,
Dscho

On Tue, 14 Aug 2018, Jeff King wrote:

> On Mon, Aug 06, 2018 at 05:11:13PM +0200, SZEDER Gábor wrote:
> 
> >   - 'git upload-pack' receives the request, parses the want line,
> >     notices the corrupt pack, responds with an 'ERR upload-pack: not
> >     our ref' pkt-line, and die()s right away.
> > 
> >   - 'git fetch' finally approaches the end of the function, where it
> >     attempts to send a done pkt-line via another send_request() call
> >     through the now closing TCP socket.
> > 
> >   - What happens now seems to depend on the platform:
> > 
> >     - On Linux, both on my machine and on Travis CI, it shows textbook
> >       example behaviour: write() returns with error and sets errno to
> >       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
> >       die()s with 'fatal: write error: Connection reset by peer', and
> >       doesn't show the error send by 'git upload-pack'; how could it,
> >       it doesn't even get as far to receive upload-pack's ERR
> >       pkt-line.
> > 
> >       The test only checks that 'git fetch' fails, but it doesn't
> >       check whether it failed with the right error message, so the
> >       test still succeeds.  Had it checked the error message as well,
> >       we most likely had noticed this issue already, it doesn't happen
> >       all that rarely.
> 
> Hmm. Traditionally we did not send ERR as part of upload-pack at all. It
> was the message you got from git-daemon if it couldn't start the
> requested sub-process. It was only later in bdb31eada7 (upload-pack:
> report "not our ref" to client, 2017-02-23) that we started sending
> them. So I think that is why it does not check the error message: it is
> not expecting that case at all (and it is not actually interesting here,
> as the real problem is that the remote side is corrupt, but it sadly
> does not say anything so useful).
> 
> I think that's somewhat tangential, though. The root of the issue is
> this:
> 
> >     - On the new OSX images with XCode 9.4 on Travis CI the write()
> >       triggers SIGPIPE right away, and 'test_must_fail' notices it and
> >       fails the test.  I couldn't see any sign of an ECONNRESET or any
> >       other error that we could act upon to avoid the SIGPIPE.
> 
> Right, as soon as we get SIGPIPE we can't offer any useful message,
> because we're dead. I would argue that fetch should simply turn off
> SIGPIPE entirely, and rely on getting EPIPE from write(). But since
> we're in write_or_die(), it actually turns EPIPE back into a SIGPIPE
> death!
> 
> So we'd probably also want to teach it to use a real write_in_full(),
> and then output a more useful message in this case. write_or_die()
> really does produce bad messages regardless, because it doesn't know
> what it's writing to.
> 
> That would give us a baby step in the right direction, because at least
> we'd always be doing a controlled die() then. And then the next step
> would be to show the remote error message (even though it's not actually
> useful in this case, in theory upload-pack could generate something
> better). And that would mean turning the die() on write into an attempt
> to drain any ERR messages before either dying or returning an error up
> the stack.
> 
> I suspect the (largely untested) patch below would make your test
> problems go away. Or instead, we could simply add sigpipe=ok to the
> test_must_fail invocation, but I agree with you that the current
> behavior on OS X is not ideal (the user sees no error message).
> 
> -Peff
> 
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 5714bcbddd..3e80604562 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -188,8 +188,10 @@ static void send_request(struct fetch_pack_args *args,
>  	if (args->stateless_rpc) {
>  		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
>  		packet_flush(fd);
> -	} else
> -		write_or_die(fd, buf->buf, buf->len);
> +	} else {
> +		if (write_in_full(fd, buf->buf, buf->len) < 0)
> +			die_errno("unable to write to remote");
> +	}
>  }
>  
>  static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
> @@ -1167,7 +1169,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
>  
>  	/* Send request */
>  	packet_buf_flush(&req_buf);
> -	write_or_die(fd_out, req_buf.buf, req_buf.len);
> +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> +		die_errno("unable to write request to remote");
>  
>  	strbuf_release(&req_buf);
>  	return ret;
> diff --git a/pkt-line.c b/pkt-line.c
> index a593c08aad..450d0801b1 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -88,13 +88,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>  void packet_flush(int fd)
>  {
>  	packet_trace("0000", 4, 1);
> -	write_or_die(fd, "0000", 4);
> +	if (write_in_full(fd, "0000", 4) < 0)
> +		die_errno("unable to write flush packet");
>  }
>  
>  void packet_delim(int fd)
>  {
>  	packet_trace("0001", 4, 1);
> -	write_or_die(fd, "0001", 4);
> +	if (write_in_full(fd, "0000", 4) < 0)
> +		die_errno("unable to write delim packet");
>  }
>  
>  int packet_flush_gently(int fd)
> 
> 
--8323328-19373660-1549616572=:41--
