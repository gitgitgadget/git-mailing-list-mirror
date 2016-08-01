Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BAAE1F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbcHAJgX (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:36:23 -0400
Received: from mout.gmx.net ([212.227.15.19]:52412 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752123AbcHAJgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:36:16 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MAgvb-1bZy7S0Uyh-00Bw9n; Mon, 01 Aug 2016 11:35:57
 +0200
Date:	Mon, 1 Aug 2016 11:35:55 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 14/16] merge-recursive: offer an option to retain the
 output in 'obuf'
In-Reply-To: <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011135010.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <0ba371955b9a4aeb752ce08fc22bbd8171f413c4.1469547160.git.johannes.schindelin@gmx.de> <xmqqd1lyvim4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KUWDZSyklW5NeiFLctlhG1IG529EY3+2gSy21ZE4GC8HA6EJ3UJ
 SflD3K01MfTHqgEAuWpfWiagAifNgwVHlyZibl6SZO2d6gggajqTcppToIv0MRbu7Sh7EVH
 RjV/p+b0B+jnXBmERPkBQhpeJvpRsqZrnDsVbahvLtGGZiQA9k5QCOu2BIUpNpttIK7lr06
 tPkLXoUlIU0EiJ29vVUGA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ZcjL1uGvuY8=:YZiPSs1N0X4CPmZOLXHcJ5
 t7UuBXdXyUeV9tElyd5A6lcfLHSlpr09l6FO3EYTK+THBTYMnaFP6y9uvLRUl1d44X3K0ajC8
 3adVJXAHj28QTuys+CsoQCfBqqdSNIwoIgLsrL5rYAe2tbXfP85qVJn0X6h6qNSyKudK30fmf
 vFeyz1jEIK2VoCJjwiu2eQKsEWdUngfe1sH5ZN9Q9AUSX5gIcH+voRzx22+Hmnvn+mGvjokSA
 0URcNrLsBqjBe0FKkpTvw913qAHUndTldpMVC58DIqF/eoLrpI7QmRy7tK+q+0a9ipL2GpYAA
 GSHm9wNQfuQp/YvVdDtmkRgyuOSpLq8xvYQcyeKxQuZdYJ+CGFCMmYl1tmEF3rYRluyJhbl6K
 6xuC+K+MdxJ+kymHlFX8tJBardo0sbfOkUZ404kyUfnNpuRBtb3QO9oIvTTmTo5w+gCmwDxKS
 0m7baken63e91MmJ7tPqKa8qu4sA5RRjSbHYamPX/9MfkmrwtuyANAwp08Q/agP035CLhDrd2
 0J6OlsiC/1RlXaXDpm6pa8T0WjTupF16FSwp5DLJtSts/9twe9L7tCpT1SaPxjlbqvPJlG1nK
 TLEzdB10UWC2G7VoT2KK5VmcgvIc2Mn2OVImwT/ILtgShobP1KoSDROh65fi2Xih6EuRrGpDQ
 CLlB243c3ItsI/Ps5EYtuYszFywbMnuw4PpkpygDwxTMBRrcHHvLwPU2Lh6dgc4cBzgQ2IlqZ
 GdHQ29HoW/8ioMgNbQ5enWZTtSSiXycu0z2ZeZs+/dZ609Euaa0zaoxpIWZx8m6cJuurA0WkS
 /EuMNSs
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index d415724..340704c 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -13,7 +13,7 @@ struct merge_options {
> >  		MERGE_RECURSIVE_THEIRS
> >  	} recursive_variant;
> >  	const char *subtree_shift;
> > -	unsigned buffer_output : 1;
> > +	unsigned buffer_output : 2; /* 1: output at end, 2: keep buffered */
> >  	unsigned renormalize : 1;
> 
> Once a field ceases to be a boolean, it is OK not to squish it into
> a bitfield like this for a struct that we will have only a very
> small number of instances of.  Treating it just like "verbosity",
> which occupies a whole int even though it can only get up to 5 or
> so, would be more appropriate.

I changed it to an int.

Thanks,
Dscho
