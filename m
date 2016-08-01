Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F3641F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 08:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbcHAI7J (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 04:59:09 -0400
Received: from mout.gmx.net ([212.227.17.21]:50580 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752113AbcHAI7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 04:59:05 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Lfppu-1awmBx1B6Y-00pJsv; Mon, 01 Aug 2016 10:58:55
 +0200
Date:	Mon, 1 Aug 2016 10:58:54 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
In-Reply-To: <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011055180.149069@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <20160729161920.3792-5-kcwillford@gmail.com> <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9THepTrV1eNxT8ucp1Ta9/500sNVeIGql8bMPE+FIQpVSnfss1Y
 sb7hqpKbapcZctyDzn3lqLUtulFODWPKMmRL1cUBDqJtJbRQyK2+x/gbtiQZn4OekAAc+oB
 KuNzjXdU6JoIuJQPfAxa9D5UKYtK3dU+ohUr9kZP08JBMVZTkNm+HYLOsH9oF+ApKVjY0ZY
 mr3mx/0mZKK/ho2tjUYGw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:V5WWaJKbFtw=:g39I75aQEXqqR3rfU/vsHb
 uAPy7fN4k6YblOZ0x1+iUrUJoHW3Wpl1CVr5HvGGOvCw7MNyUgmS1ZC/EvItXpzYbLir/Pxy3
 RpONwlHbwx3zrwJ7LEIBwhsxc60gzWsYt7VJgGgluVp7/2mvjkuhTP4wWRpWCuJzpuRUCnWlE
 MfUujk6Ewva8eTQ+n3N5wEQPcUd9fK+xXH/1jwmt4Vj++q0sbgQRaeQxbIkWuERgMygwpBMmf
 20EVj7sBzVMssnbSGY+MfZtqlSpTUNo6ibSKGUfLk8ZQ+Za3Byg5NNVeI3nVXSu9W/WsRbatw
 SDrXZWpch1EoQehm2RDlhvLE4TuH+ofgQJUCsOyP3at+LH9X8xV7mnX1ROULjoABxNlbhscbz
 yM+UQwerl26Xd+XtcPhs0O2ZhiKqCHmMgvXqaVhhz/V+RVQttrigt/R/Sxw8F1Kz5/h4pHWpx
 GvcNl6i7y8O37rv66XAb7JhNqBQZ/M4MRGwczZ2XZ/o7FsigxQA+XSfgBgJEjm4eWdfUHsLen
 scPjy4U5S5ldPL7pNT/7JshSFMSccqa9QI+7pQl2kVhRmLDgEcnkY/Ke1iGjCGMP9CQoBilpN
 JAP/O9cdZb+zb/T/Xj4OiJ8TIMQKDyK1RulJRTaqjsyihxNHrpPrCadDJEzgEgSOHHvoiiiSK
 I/xH955YIKX6l7iY/e9ESS/WkrzqMnc4QoKccc8h3/xO2ZvDtEc2RzYkglYdzLCTAOvzGMjtW
 I4P5nJqWIR4C+h3vq4qpf/mydsxgFGmPNu7T9BSapEvIXUOadO+rxWdS+MUQNn4tRFdpxb400
 Uhm55jZ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 29 Jul 2016, Junio C Hamano wrote:

> Kevin Willford <kcwillford@gmail.com> writes:
> 
> >  static int patch_id_cmp(struct patch_id *a,
> >  			struct patch_id *b,
> > -			void *keydata)
> > +			struct diff_options *opt)
> >  {
> > +	if (is_null_sha1(a->patch_id) &&
> > +	    commit_patch_id(a->commit, opt, a->patch_id, 0))
> > +		return error("Could not get patch ID for %s",
> > +			oid_to_hex(&a->commit->object.oid));
> > +	if (is_null_sha1(b->patch_id) &&
> > +	    commit_patch_id(b->commit, opt, b->patch_id, 0))
> > +		return error("Could not get patch ID for %s",
> > +			oid_to_hex(&b->commit->object.oid));
> >  	return hashcmp(a->patch_id, b->patch_id);
> >  }
> 
> These error returns initially looks slightly iffy in that in general
> the caller of any_cmp_fn() wants to know how a/b compares, but by
> returning error(), it always says "a is smaller than b".

I am to blame, as this is my design.

And yes, it is kind of funny that we require a cmpfn that returns <0, ==0
and >0 for comparisons, when hashmaps try to avoid any order.

Do you want a note in the commit message about this "abuse" of a negative
return value, or a code comment?

> The idea of using the two level hash, computing the more expensive
> one only when the hashmap hashes of the result of the cheaper hash
> function collide, is excellent.

Thanks :-)

Ciao,
Dscho
