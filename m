Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3A721F858
	for <e@80x24.org>; Tue,  2 Aug 2016 10:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbcHBKpm (ORCPT <rfc822;e@80x24.org>);
	Tue, 2 Aug 2016 06:45:42 -0400
Received: from mout.gmx.net ([212.227.15.19]:50444 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbcHBKpa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2016 06:45:30 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MBWTO-1bNMBU1Ij0-00AVNS; Tue, 02 Aug 2016 12:45:18
 +0200
Date:	Tue, 2 Aug 2016 12:45:17 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Kevin Willford <kcwillford@gmail.com>, git@vger.kernel.org,
	Kevin Willford <kewillf@microsoft.com>
Subject: Re: [[PATCH v2] 4/4] rebase: avoid computing unnecessary patch IDs
In-Reply-To: <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608021244450.79248@virtualbox>
References: <20160729161920.3792-1-kcwillford@gmail.com> <20160729161920.3792-5-kcwillford@gmail.com> <xmqqa8h0m82f.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608011055180.149069@virtualbox> <xmqqtwf4i71l.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:AN7ey3nLDy3E55xuyW1o4xgKjXe6GnacZFnVtlxKc+6OUPz/fNC
 6csfRuWNtdSuNMj1P3g7+zzV5Q6kVBYoS6pGkfmtRUIHzOEWWvxssJUAjKuKGh9h9r2t0Sq
 xcApX6YKTzVnlwNT0XOg6IJ01eMyfv6+u2uzugA3NjWNuu+a0dFfVwl3xjI4fEqzbixVQWt
 BoPR6g5clMYLWW2OI1wDA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:s360eZ/00YI=:tOtKJ0M59G3E0nATxK1JoW
 phGq4SrSD3kPqaJNcREgBUj8TcWr+gdIQdvGvGGFUSHYQ+/QPeQRmWVHTOX0XsGMe9Yps2I9o
 puDJKUdokjkKYiD0hZEYp1kuWbxUs1BVgUMWZY/NXLi0iH5Fuz4C63jVyelbNhIcxSMO3TI6X
 yjOohSWHDo/RviWHdE8upCOiXJ1vVDk4Eaf6gmA8/du8a6IVIROU2mRhMyjk/RPZOI0aC0Vc8
 9cdF+a4mnST10ugKWVqzg+HJlihRJT4uFQSR84YG2Wv/Vw606DOpBwPsFd/F00CtkdT8TSLsS
 gCvmfbSIhhpSFMoqlrV0UtwgOLgjZZxhDQ2rIgaUv9y58mMXxLks8fB46P/+W4NYGdEkEHt9N
 WLE0xIhBQVOo4lLNr0+z+IcTd2PneK3bq+CPxpTwozfPOxDJsmFKnWMd1M32E7cLyRV+7JR/w
 fR3W254q6i9I7KjLPACxumciQXH8RCOunlTA5KDaSQMk2ENa1hheO4wS7sIE4Xs5iT5aaCYp6
 eX69jsGBazK6q/VRIDsPhZL/7D0cWnrxzyh593az1EedzSmSD3AUbCnyZK5tSl9Cc0FMV4IsS
 zSGcXcmTNDpXn250ryztMvdSeZaHSA4x7WDKeq6Zx2A4s+PDY2kJlnYaWrNXdgmsYgreEIwki
 JXyimOrDVO9ip77HI6uKLNKirR1OEJRX8zAFGRRErZajHRJH7DJJfYlsDV/NG3J2Zgw1iJwuT
 7cnitsIo2LOc/bdcWIS+cb05/Vi1GC0kDWvSIi/Xnimji/1X5Hf9eERigt0urfcdRRCtNkKup
 ytUGtR7
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Mon, 1 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Fri, 29 Jul 2016, Junio C Hamano wrote:
> >
> >> Kevin Willford <kcwillford@gmail.com> writes:
> >> 
> >> >  static int patch_id_cmp(struct patch_id *a,
> >> >  			struct patch_id *b,
> >> > -			void *keydata)
> >> > +			struct diff_options *opt)
> >> >  {
> >> > +	if (is_null_sha1(a->patch_id) &&
> >> > +	    commit_patch_id(a->commit, opt, a->patch_id, 0))
> >> > +		return error("Could not get patch ID for %s",
> >> > +			oid_to_hex(&a->commit->object.oid));
> >> > +	if (is_null_sha1(b->patch_id) &&
> >> > +	    commit_patch_id(b->commit, opt, b->patch_id, 0))
> >> > +		return error("Could not get patch ID for %s",
> >> > +			oid_to_hex(&b->commit->object.oid));
> >> >  	return hashcmp(a->patch_id, b->patch_id);
> >> >  }
> >> 
> >> These error returns initially looks slightly iffy in that in general
> >> the caller of any_cmp_fn() wants to know how a/b compares, but by
> >> returning error(), it always says "a is smaller than b".
> >
> > I am to blame, as this is my design.
> >
> > And yes, it is kind of funny that we require a cmpfn that returns <0, ==0
> > and >0 for comparisons, when hashmaps try to avoid any order.
> 
> Perhaps hashmap API needs fixing in the longer term not to call this
> type hashmap_cmp_fn; instead it should lose cmp and say something
> like hashmap_eq_fn or something.

Maybe.

But to make sure: you do not expect Kevin to do that in the context of
this here patch series, right?

Ciao,
Dscho
