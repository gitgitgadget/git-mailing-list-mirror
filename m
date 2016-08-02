Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F6281F858
	for <e@80x24.org>; Tue,  2 Aug 2016 08:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbcHBIJR (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 04:09:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:61040 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751175AbcHBIIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 04:08:43 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lug8u-1b4CLp1CRk-00zlv3; Tue, 02 Aug 2016 10:01:45
 +0200
Date:	Tue, 2 Aug 2016 10:01:42 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <xmqqbn1cjogd.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608020948220.79248@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de> <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
 <xmqqmvl2ty31.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608011124440.149069@virtualbox> <xmqqbn1cjogd.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:sU8+8ZmRibLgFI/9n4eVrcQi01QP4ajHg13OEDZMDiJiJd899gh
 TBUNu66yfRet1PzJ7rxWhWdCxdDaX5uflbeyHB2j1ic3YUHIF+1urOySmHDujjG7Fp2U72g
 LmZObqQQVRcIRqxHnKEYESwJK4AraZqRTzjTbZamtMsvoFKYTXc5u2pMHwru4IaHMG7BoFW
 0MKYOYFsC8QzCs86mINXA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:E2wMxW13ghQ=:g0FzZ6MOG+whYiQChV7ImY
 8QYv/PnkZJrG0KaPksRylneS6HimT3Qq+EKk1otTeVAtzB9ReY8Hqvs7w21aflTMakQDGR+xG
 rNvta7KHgUWkHH7AgsXFE8CAKzu0jkim/zLKvxojrc/J1RMEMdJ+P08Ixx9bPJAuGpXXxi9CG
 uAC/hpSAavGq7zhKbSaAkeW3GdZy+Y1HipefaWs2VLxiQUt04A9eUogo81Gw9fpvt5zF2QEf5
 3Ev13tsb30bneoY9lWpHm74HhSJQT4rVcVshacDanc6QrmCtOZW1Qv81V7TOdSj0aIy837Z7X
 UyWB+itR6O3M9dHuLdVOYFArDf7145xfYD2dyByukwEisnMwkihFvo2AzmAl1khuuPWnV2q87
 Sjk/b8wXFLx/ZVwufkHAAhKLg4AZgGCFEpw8MbPpVGXWAWxs4lXtCuGmRRIn0yjH0bSPRWWcA
 n97OVrvquVXrbRY1CJFRXVUK32NU9V9zCnGhM+lv1bo5oW3c8S9Pxv/mJGom9S8/B8Hs4MQo9
 MtqxKm475FNbki7R5Ml2pFGT/XfnSEP56+jZORv3HI3ay06NQ8gwWh463lBJKb32yc7jPHHqv
 wayROB0iptPtnRl3ifCEWfjDlk9QnLHZ/O4V9pD0EdqMWr74sUR9VsahlKlmloHYt5PmbN0JL
 NEtPNTof9IubRQPG6gwMfKBEA40t2Fb8tKp9ja2/PgI4DuurEPc0Be/5YytveyqHJo2n5bsWh
 ANNjm7f8ypoVZnJpKh+jJyNo3gxPYuVf04/lyvn9y/RAoVuOtddCy11ws0r0a5jVbEFAF+W5b
 hW8Dvd7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> I actually now see how this would work well for "reason 2)".  If a
> >> caller wants to run the function and wants to pretend as if it did
> >> not run anything when it failed, for example, using this to spool all
> >> output and error to a strbuf and discard it when the function returns
> >> an error, and emit the spooled output to standard output and standard
> >> error in the order the lines were collected when the function returns
> >> a success, would be a good way to do so.
> >
> > That is actually the exact opposite of the intended usage: when any
> > `pick` in an interactive rebase succeeds, its output is discarded so
> > as not to bother the user. We show the complete output only when it
> > fails.
> 
> Oh, it makes sense, too, to show the output only when there is an error.

Thanks ;-)

> But in that case, there would be both messages meant for the
> standard output and also meant for the standard error, and we need
> some way to make sure they go to the right channel.

Not necessarily. Let's have a look at our existing code in
git-rebase.sh:

	output () {
		case "$verbose" in
		'')
			output=$("$@" 2>&1 )
			status=$?
			test $status != 0 && printf "%s\n" "$output"
			return $status
			;;
		*)
			"$@"
			;;
		esac
	}

This incredibly well-named function (</sarcasm>, my fault: dfa49f3 (Shut "git
rebase -i" up when no --verbose was given, 2007-07-23)) accumulates all
output, both stdout and stderr, and shows it only in case of an error.

Crucially, *all* output goes to stdout. No distinction is being made
between stdout and stderr.

This is the existing behavior of rebase -i.

> I however do not think an array of <bool, const char *> is the only
> way to achieve that.  We can get away by a single strbuf that
> accumulates all output() that we have seen so far, i.e. "we only
> accumulate output() and ignore flush() as long as what we see are
> only from output()" mode.
> 
> Then the err() routine operating under this new mode can show what
> has been accumulated to the standard output (because with this tweak
> I am outlining here, by definition, the strbuf will only keep the
> output() material and not err() things), show the err() message, and
> switch back to the normal "we accumulate output() and honor flush()"
> mode.  Of course, when we are doing multiple rounds, the mode must
> be reset to "accumulate output and ignore flush" mode at the
> beginning of each rouhd.
> 
> That would give us "silence if there is no error, but if we are
> showing error, show them to the standard error, while giving
> non-error message to the standard output".

It all makes sense what you say. In case you want to preserve the channel
in some future modification.

However, I am right now most concerned about keeping existing behavior as
faithfully as possible (with the exception of execution speed, which I
want to improve dramatically).

As such, it would be a serious mistake to implement that mode and use it
in the rebase--helper: it would very likely cause regressions in existing
scripts, probably even my own.

So I do understand your concern, and I agree that it would make for a fine
design, in a different context than this patch series.

Ciao,
Dscho
