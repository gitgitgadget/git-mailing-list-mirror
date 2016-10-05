Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9340F207EC
	for <e@80x24.org>; Wed,  5 Oct 2016 11:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754864AbcJELSR (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Oct 2016 07:18:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:57073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754559AbcJELSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Oct 2016 07:18:16 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M1BMy-1b2wy7377I-00tA2r; Wed, 05 Oct 2016 13:17:51
 +0200
Date:   Wed, 5 Oct 2016 13:17:49 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Rich Felker <dalias@libc.org>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        musl@lists.openwall.com
Subject: Re: [musl] Re: Regression: git no longer works with musl libc's
 regex impl
In-Reply-To: <20161004173926.GA19318@brightrain.aerifal.cx>
Message-ID: <alpine.DEB.2.20.1610051250080.35196@virtualbox>
References: <20161004150848.GA7949@brightrain.aerifal.cx> <20161004152722.ex2nox43oj5ak4yi@sigill.intra.peff.net> <20161004154045.GT19318@brightrain.aerifal.cx> <alpine.DEB.2.20.1610041802310.35196@virtualbox> <20161004173926.GA19318@brightrain.aerifal.cx>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zowJfZGxWarcAjldcwv9WK6xqrzHXd+Lwy7HkLA/kFJ3m3VmmnP
 BnDAGsh005YtRXFlCy2oflNV7YbwMJ01ZpZ9Ct/uHmc6DnstMRO/ooInHbI0ueQBY85mx0Q
 5WGj7Bm1kogCZdRj7ViQFSRWoCngsiUbi2O0T03a5GAlSwojSJt5eketgKNhV8ioMopRh46
 6JG4jTieDj2QoRiDFgjsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tdQLrdwCwKE=:8Bi+d/AQpFRlBDi68+dmll
 aoTdC4cCPtP3wv99NJ870hk4DiGhjHcrq33FXOC3sIx+d7o0Q8qTDsCzqqNaP9r1+UvVOG8Lu
 HqMyTQwICCQx2Vhdq0Qjv5D18TfpwgUJsenM/Jw/k+JieKw99mPalQvKGyJmIpFZ6NYGBwko/
 qRWOM4GSO7v09BTYpFoFHdsRrJcpfOaYDWOcwIO0nWWFmbVSoJbZCPt6IPRnxqoX7qwMRpBlk
 rKtguiqBh3wtWXmx7XTTRgL3d+AvyUiAQ13frIjc49b2zKNXNWIZXSjP2zcYCMx/jFrZrB4Nx
 awXSeqnnZKzFLAjXR5QbjnD0do8ZMd4vpAZQXFlUZhl7n7CbnXrMt/GphBhcZEcKl/V1WwAin
 za7qIZ2E9mrTTq3ktAXBrFTQdfI6mCZqkh9XiinKGjLeTo+g1gCXmBmPH2KwNC5/KWOfaG99i
 tcHgwizzEZdK3DJkLiMog1yAvXyrFBuayCXHFACgFxL9A+r0sJBi69O84THJEAK2kn8q1CN1x
 LcNYhdIEtGEzrB94Cny9BFqWlgtdyvm/phBpmeCAwf7ikG38JZfgxeF+8pOIiw/BWewNIFJXx
 1veziSO1zdFNsO+EPum+Mx2snl4d8cSQyYf5WoO8a8larsI/ApEz+uJ6Eb6oRl4zJecs4uihW
 Q5CQMDuSxvPPp6X9AfCQ1vtcwTJrVaji2wiVU8hKt3ZB4AhxTf3hE3rc8CFwlQtcv3edA/jyw
 dDzCVkLwukvXjLdTFz5j5fnqIFcOZDp/uygJcd63NjVJBeitUD/Th4UzEDw9Tsm+hso4JqZxf
 scuB2HB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rich,

On Tue, 4 Oct 2016, Rich Felker wrote:

> On Tue, Oct 04, 2016 at 06:08:33PM +0200, Johannes Schindelin wrote:
>
> > And lastly, the best alternative would be to teach musl about
> > REG_STARTEND, as it is rather useful a feature.
> 
> Maybe, but it seems fundamentally costly to support -- it's extra
> state in the inner loops that imposes costly spill/reload on archs
> with too few registers (x86).

It is true that it could cause that.

I had a brief look at the source code (you use backtracking... hopefully
nobody uses musl to parse regular expressions from untrusted, or
inexperienced, sources [*1*]), and it seems that the regex code might
spill unnecessarily already (I see, for example, that the reg_notbol,
reg_noteol and reg_newline flags all use up complete int registers, not
merely bits of a single one).

It seems, specifically, that the *match_end_ofs parameter of the two
regexec backends is always set to point to eo, which is so far not
initialized. You could initialize it to -1 and set it to pmatch[0].rm_eo
if the REG_STARTEND flag is set. The GET_NEXT_WCHAR() macro would then
need to test something like

	if (str_byte >= string + *match_end_ofs) {
		ret = REG_NOMATCH; goto error_exit;
	}

This does not handle non-zero pmatch[0].rm_so, though. I would probably
try to pass another input parameter for that, but I have not verified yet
that a "^" would be handled properly (if pmatch[0].rm_so > 0 and
REG_STARTEND is set, "^" should *not* match).

> I'll look at doing this when we overhaul/replace the regex
> implementation, and I'm happy to do some performance-regression tests
> for adding it now if someone has a simple patch (as was mentioned on the
> musl list).

I'd be interested to be kept in the loop, if you do not mind Cc:ing me.

Ciao,
Johannes

Footnote *1*:
http://stackstatus.net/post/147710624694/outage-postmortem-july-20-2016
