Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DC41F453
	for <e@80x24.org>; Fri,  8 Feb 2019 09:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbfBHJ2X (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 04:28:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:41713 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfBHJ2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 04:28:23 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MFz0E-1gvwSo49Ti-00Euq1; Fri, 08
 Feb 2019 10:28:13 +0100
Date:   Fri, 8 Feb 2019 10:28:12 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Clemens Buchacher <drizzd@gmx.net>
Subject: Re: t5570-git-daemon fails with SIGPIPE on OSX
In-Reply-To: <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1902081024550.41@tvgsbejvaqbjf.bet>
References: <CAM0VKj=MCS+cmOgzf_XyPeb+qZrFmuMH52-PV_NDMZA9X+rRoA@mail.gmail.com> <20180814223246.GA2379@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1902080958190.41@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-604727233-1549618094=:41"
X-Provags-ID: V03:K1:+C8eEiSKU25snwDQpb1TzP6DE1tw7Hny5/0wpVnSmwasq/ekxLM
 xir2/ctizmhzSQ+OuGRCR4L8bf/ps2aPk+3zt3Hmpsj02eV7MdwuXDBT+E9mN7LVmRKX4JH
 ytE3FZFr0/RSI43sGeACUKmMW4/N6f2e1SQZnJJUbXZiWFA++22wdg6YGZs2u0yrqrWjhJp
 tcDs7FZVSIi+FYw0yeZIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:47BULXNffvk=:CMN/5/tL8LHb4hyXhDpxGc
 k2s2HAZi4YEeyf0v8BRDUjc/gXR2mUijW2jiWz1C+kewL7ubaLJgsFILIdtgl/o3par01UGFv
 j+eKw+htFqKQCSL5WFRHbx3I8tF2r6d/V9sE30RR9LiAVkhxVHB6HriXtglP6j3cRbIXPvuPv
 Vcc8m67dhWpEfEdxEXXOZoy0wH+TrV86g7fkQozVSU1S5OaDT0+mH0TA46gySOViupD68nHAT
 /B+ClGzoEB+/LnIg4UgQ1KzcYOetRlsVA6HjnSYSVLqz+SOKItkofB7g7niOq33IuJuXFlhz6
 cvTpSM7ZU4NmCb1OGutdEflqtRmOBo15M9cqS+39H2wTDxAF/arquCkLpGk2mUxaI4VU5Ydno
 hvjTxmfcrzTb1+7VBX7/1cxXLvArZLHi2AsdHdBxm9tX9swXzsY3VV00nsc+0naw/6LWLRC9G
 cFUzQL1fkNfgp6kikRO9lNNbnNTH01LhmmqkpRDCWZTOllJtnjjUu1x78VbgA1yegF1mymTCX
 hQK2mdaFMeCNDtb6jZJSjHZ8sOV0KLLmyfsoO8we4rqoCQ5mLkO9r7ShcL6wuI9tYqaMQEz7q
 deRdyXn+hQWe/6WH1E6TBV4Ig3ttADhoLU6bvESySxdHSM5VqgkKDzYY0efzxrZAmoKuWuKnn
 LkcTvODyc5WMvVFs6JWUfRNvi0iCF2IS86Jk9rrSJxrp/icx33J5DnhNmxeDLvZmy7hEKxNIv
 z0Fjg+eo/AALOUfs1X7eEPUDxia9B3Mw1VOheir60ez7lSZ7l5zMIyPYbk49KF8IUn4BQAozN
 YAhzxkgYIdM6lOjozbsM+XoBQ1rR/S+4y5LB9a+0mpDMWcmo4KLjLnSV5HAbzQlrnE39c3nDt
 E5fBoZpsTidZ6Qh1FR8RGFpFcn5H77DCRgj/RGf7+vV/X7JLmnmqeuC48sFfJddPDr8zRdJMQ
 lFtJ1kF3ekleW05w66QZO5m/XDVzri+RO7Zi01fgO7ZegVZoXfmykUTDvSpzo3wTUvA2HaBVy
 S9BO/cvil9lutLlHUoK9l0TRq6rg7Q5ck8hpHjgYlObKKgSltneL0rn15TUAnmrLwVJ/yNiVL
 DfyGIBjQq8afQQlGjSj0hmF2T+5M3N0X1ZY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-604727233-1549618094=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Fri, 8 Feb 2019, Johannes Schindelin wrote:

> I just had a look at the patch you provided below (for some reason, my
> previous search on public-inbox only turned up Gábor's mail to which you
> responded).
> 
> Admittedly, I do not really understand all aspects of it, but it applies,
> still, and I kicked off a stress test here:
> 
> 	https://dev.azure.com/git/git/_build/results?buildId=338
> 
> It seems that your patch fixes that t5570 flakiness on macOS, and more
> importantly, addresses an important issue on macOS.
> 
> Will play a bit more with it and keep you posted.

Alas, I was fooled. *Fooled*, I say. Apparently the --stress option makes
the script *succeed* when it fails?

I say that because I wanted to make sure that your patch fixes things and
reverted your change and started another build, which succeeded. So I
started another build, then another build, and they all succeeded. Only
then it dawned on me that I had not looked at the *logs*. And they all
still report the same issue, even with your patch:

https://dev.azure.com/git/git/_build/results?buildId=338&view=logs&jobId=51041795-01c5-57f3-5561-107b6b9e51a6&taskId=fadc714a-a906-5cf2-cc7a-335e443ad2f8&lineStart=1402&lineEnd=1505&colStart=1&colEnd=32

(You will have to scroll all the way down, or press Ctrl+End, to see that
"fetch notices corrupt pack" is failing.)

So I am afraid that your patch does not fix the issue nor does it work
around it.

Ciao,
Dscho

> On Tue, 14 Aug 2018, Jeff King wrote:
> 
> > On Mon, Aug 06, 2018 at 05:11:13PM +0200, SZEDER Gábor wrote:
> > 
> > >   - 'git upload-pack' receives the request, parses the want line,
> > >     notices the corrupt pack, responds with an 'ERR upload-pack: not
> > >     our ref' pkt-line, and die()s right away.
> > > 
> > >   - 'git fetch' finally approaches the end of the function, where it
> > >     attempts to send a done pkt-line via another send_request() call
> > >     through the now closing TCP socket.
> > > 
> > >   - What happens now seems to depend on the platform:
> > > 
> > >     - On Linux, both on my machine and on Travis CI, it shows textbook
> > >       example behaviour: write() returns with error and sets errno to
> > >       ECONNRESET.  Since it happens in write_or_die(), 'git fetch'
> > >       die()s with 'fatal: write error: Connection reset by peer', and
> > >       doesn't show the error send by 'git upload-pack'; how could it,
> > >       it doesn't even get as far to receive upload-pack's ERR
> > >       pkt-line.
> > > 
> > >       The test only checks that 'git fetch' fails, but it doesn't
> > >       check whether it failed with the right error message, so the
> > >       test still succeeds.  Had it checked the error message as well,
> > >       we most likely had noticed this issue already, it doesn't happen
> > >       all that rarely.
> > 
> > Hmm. Traditionally we did not send ERR as part of upload-pack at all. It
> > was the message you got from git-daemon if it couldn't start the
> > requested sub-process. It was only later in bdb31eada7 (upload-pack:
> > report "not our ref" to client, 2017-02-23) that we started sending
> > them. So I think that is why it does not check the error message: it is
> > not expecting that case at all (and it is not actually interesting here,
> > as the real problem is that the remote side is corrupt, but it sadly
> > does not say anything so useful).
> > 
> > I think that's somewhat tangential, though. The root of the issue is
> > this:
> > 
> > >     - On the new OSX images with XCode 9.4 on Travis CI the write()
> > >       triggers SIGPIPE right away, and 'test_must_fail' notices it and
> > >       fails the test.  I couldn't see any sign of an ECONNRESET or any
> > >       other error that we could act upon to avoid the SIGPIPE.
> > 
> > Right, as soon as we get SIGPIPE we can't offer any useful message,
> > because we're dead. I would argue that fetch should simply turn off
> > SIGPIPE entirely, and rely on getting EPIPE from write(). But since
> > we're in write_or_die(), it actually turns EPIPE back into a SIGPIPE
> > death!
> > 
> > So we'd probably also want to teach it to use a real write_in_full(),
> > and then output a more useful message in this case. write_or_die()
> > really does produce bad messages regardless, because it doesn't know
> > what it's writing to.
> > 
> > That would give us a baby step in the right direction, because at least
> > we'd always be doing a controlled die() then. And then the next step
> > would be to show the remote error message (even though it's not actually
> > useful in this case, in theory upload-pack could generate something
> > better). And that would mean turning the die() on write into an attempt
> > to drain any ERR messages before either dying or returning an error up
> > the stack.
> > 
> > I suspect the (largely untested) patch below would make your test
> > problems go away. Or instead, we could simply add sigpipe=ok to the
> > test_must_fail invocation, but I agree with you that the current
> > behavior on OS X is not ideal (the user sees no error message).
> > 
> > -Peff
> > 
> > diff --git a/fetch-pack.c b/fetch-pack.c
> > index 5714bcbddd..3e80604562 100644
> > --- a/fetch-pack.c
> > +++ b/fetch-pack.c
> > @@ -188,8 +188,10 @@ static void send_request(struct fetch_pack_args *args,
> >  	if (args->stateless_rpc) {
> >  		send_sideband(fd, -1, buf->buf, buf->len, LARGE_PACKET_MAX);
> >  		packet_flush(fd);
> > -	} else
> > -		write_or_die(fd, buf->buf, buf->len);
> > +	} else {
> > +		if (write_in_full(fd, buf->buf, buf->len) < 0)
> > +			die_errno("unable to write to remote");
> > +	}
> >  }
> >  
> >  static void insert_one_alternate_object(struct fetch_negotiator *negotiator,
> > @@ -1167,7 +1169,8 @@ static int send_fetch_request(struct fetch_negotiator *negotiator, int fd_out,
> >  
> >  	/* Send request */
> >  	packet_buf_flush(&req_buf);
> > -	write_or_die(fd_out, req_buf.buf, req_buf.len);
> > +	if (write_in_full(fd_out, req_buf.buf, req_buf.len) < 0)
> > +		die_errno("unable to write request to remote");
> >  
> >  	strbuf_release(&req_buf);
> >  	return ret;
> > diff --git a/pkt-line.c b/pkt-line.c
> > index a593c08aad..450d0801b1 100644
> > --- a/pkt-line.c
> > +++ b/pkt-line.c
> > @@ -88,13 +88,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
> >  void packet_flush(int fd)
> >  {
> >  	packet_trace("0000", 4, 1);
> > -	write_or_die(fd, "0000", 4);
> > +	if (write_in_full(fd, "0000", 4) < 0)
> > +		die_errno("unable to write flush packet");
> >  }
> >  
> >  void packet_delim(int fd)
> >  {
> >  	packet_trace("0001", 4, 1);
> > -	write_or_die(fd, "0001", 4);
> > +	if (write_in_full(fd, "0000", 4) < 0)
> > +		die_errno("unable to write delim packet");
> >  }
> >  
> >  int packet_flush_gently(int fd)
> > 
> > 
--8323328-604727233-1549618094=:41--
