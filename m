Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FBCD20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbdASQ4C (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:56:02 -0500
Received: from mout.gmx.net ([212.227.17.21]:65280 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753697AbdASQz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:55:59 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHrk1-1cXolE1Fmv-003duy; Thu, 19
 Jan 2017 17:55:25 +0100
Date:   Thu, 19 Jan 2017 17:55:22 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philip Oakley <philipoakley@iee.org>,
        Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 1/5] doc: add documentation for OPT_STRING_LIST
In-Reply-To: <xmqqr3403x1r.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1701191749340.3469@virtualbox>
References: <20170118000930.5431-1-jacob.e.keller@intel.com> <20170118000930.5431-2-jacob.e.keller@intel.com> <xmqq37gg9moc.fsf@gitster.mtv.corp.google.com> <254445096AD0412287CBB994E8BCA043@PhilipOakley> <xmqqr3403x1r.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4MgCOCRpj5528NiFFd+1vRpSjxbm7o1FhaF7ahXpxrC+l8gLuQy
 GiQB+G4iZg61kI4dOzB6+oyzmfLZeM9teqUX1NM9i22IZj/Ff80WglLCaFT2k7nPSTteElN
 XF9HNEiM+y4v6w+ydcaaYcAnVfwUv8x5qAp5S9Tu1i0Ef38PfKJdWwdQQI6V84whVuooz74
 AwGPocOZHB6b34hGvY9Vw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cmUxkclwDsc=:GDbJ6tAzz7P4bKd5SEtd3i
 3VlyjhCV1cvhtK+15wuEBFs+ihMOsYF3/OkujSVujJFthXaRYZ65v5ETC3ZnYuPL0eF3Drsn+
 XEyNr5QRc8yCR68kWAtu+WTXlZoY0vgZCvlIE0t9hGPMcVUdeIxN6PhZMSjL//fciMxjZfpIL
 ifzk/FqOdUO4BPkXbSamxwkGYpuoziODJOyAjwwCmgoXSk0oMs06z2nsYh8bM+qmzCAGf8ZU0
 EQlLKWy6Di8BttFOg+r6BGTV9OV1FmvPdpjkOQakXmpxWIfuBpnuYBPTrOheQ6/Z3vU4R8EBB
 +sVbysLERlDt+hzWt3QRea2ow+VqpqGt5oQSV9kitnp1YsjxriKcbd5R056lfz0eYSiph4Iy4
 Jm9vohxie2oW54IPUv/38jRUgpu42v7YoY3JPsPppL9MdiGS/bOpRau3EhWJd+McNHAv4tyU9
 32T5vQi4Fxbe+215ItWWfPt8gzxnbwpaog4x99OR+I997+jUw2u9Evp/mlkkpTu0BXiUf1d49
 4spMAEvwN+8Quh53zCUDqNS3L4TXK5MVJDXj8Yk9K1vOZi94qTgh+PVx5UFMipA3DGIgyHfJ3
 5KN+SZEPZ8TQaIAuJn7m36jglnYGrbT1VEmX5ije8bvEY5dqoFS6pMG59OKCcCq6LfyuUr3+R
 nLNJEMc/CzUAgcPFeFFJkZd15LkbmqcjTPjuc3eqX+t17qPFQaMfETjPiibY/xdBxuspRmY48
 C9wZTZqSXVlqc29eNT6rM7Te0N3G8lOLhLcZQ1lL3JyV3YUZKFW3/J6VA9Hb12jAEOd4EAtYM
 IogIqf3ZaB3gIzfFcyhb7G8niSGEo4j+qnD7jzCu+My4k0/DxKTG9/9Fnsjxm/xdKmvDK7Gci
 rvhspvivZEE2rjMaUnABa9z4UP/icwLztQu4tDoj3g2xdeLsiKR9FCdeumV92k+ZuJ658TaPT
 JdzBCdekAdtqThSQlnhG905+txbhtr8zTqCkiYCEOCFuZYyw+RC5ZBqWqDxo3xtz0pMBaD+8P
 8ABwz2Yo9Jh8GHBVD7s5AYk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 18 Jan 2017, Junio C Hamano wrote:

> "Philip Oakley" <philipoakley@iee.org> writes:
> 
> >>> +`OPT_STRING_LIST(short, long, &list, arg_str, description)`::
> >>> + Introduce an option with string argument.
> >>> + The string argument is stored as an element in `&list` which must be a
> >>> + struct string_list. Reset the list using `--no-option`.
> >>> +
> >>
> >> I do not know if it is clear enough that 'option' in the last
> >> sentence is a placeholder.  I then wondered if spelling it as
> >> `--no-<long>` would make it a bit clearer, but that is ugly.
> >
> > Bikeshedding:: `--no-<option>` maybe, i.e. just surround the option
> > word with the angle brackets to indicate it is to be replaced by the
> > real option's name.
> 
> Yeah, I bikeshedded that myself, and rejected it because there is no
> <option> mentioned anywhere in the enumeration header.

As I pointed out in a previous review round: the surrounding test uses
--no-option (I agree that it is tedious to go back to the original code
for review, rather than a mere patch review that lacks context, but I
suspected that Jake did not come up with that `--no-option` himself), so
by our own recommendation (imitate the surrounding, existing code/text)
Jake did exactly the right thing:

$ git grep -e --no-option upstream/master -- Documentation/technical/api-parse-options.txt
upstream/master:Documentation/technical/api-parse-options.txt:	`--option` and set to zero with `--no-option`.
upstream/master:Documentation/technical/api-parse-options.txt:	(even if initially negative), and `--no-option` resets it to
upstream/master:Documentation/technical/api-parse-options.txt:	zero. To determine if `--option` or `--no-option` was encountered at
upstream/master:Documentation/technical/api-parse-options.txt:	`--no-option` was seen.
upstream/master:Documentation/technical/api-parse-options.txt:	reset to zero with `--no-option`.

Ciao,
Johannes

