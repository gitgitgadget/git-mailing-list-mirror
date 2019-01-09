Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79B181F803
	for <e@80x24.org>; Wed,  9 Jan 2019 02:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfAICrG (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 21:47:06 -0500
Received: from resqmta-po-03v.sys.comcast.net ([96.114.154.162]:36156 "EHLO
        resqmta-po-03v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728835AbfAICrG (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 8 Jan 2019 21:47:06 -0500
Received: from resomta-po-15v.sys.comcast.net ([96.114.154.239])
        by resqmta-po-03v.sys.comcast.net with ESMTP
        id h3m5gMFYzrBE6h3tZg0Siq; Wed, 09 Jan 2019 02:47:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20161114; t=1547002025;
        bh=8elFPMbq5fdEFTQOhgBzkv5crcLT1RpscPqLVp97wXw=;
        h=Received:Received:Date:From:Reply-To:To:Message-ID:Subject:
         MIME-Version:Content-Type;
        b=PB4uBgq2j588SfxfAEbvhZPetx1fUpAfR/NVf+L8GEDeUuL5bAhnmxUGKNZTGEXon
         dPbvB/UbAb+WyRHxcc7AYMaMd1+g/8bXre+hIr3avb2k9877H+1u1zutgSBwTsMyFr
         RWwl9EemYXiGOYg44X0ZeXK6VA6PEjs1AjQOhJfkfxO+ue8cGtdTrm2gQwg3qJWajG
         +5krmOyRbFaX6x8KQ+mluzTcNsM9dmkgZ1uHR+uDPiBH7I8xFmuFjX/Jkb9zEkG54s
         YGfBKT95lvIFg6WOf2JjDp6rFa5qw6CgMWSHC9NMcMM3k+hqXKdUybGhDH6YzN31M0
         G/0y13cy0POng==
Received: from oxapp-hoc-65o.email.comcast.net ([96.118.241.229])
        by resomta-po-15v.sys.comcast.net with ESMTPS
        id h3tYgUiWAGe2Jh3tYgTsrL; Wed, 09 Jan 2019 02:47:05 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedtledrfedtgdehvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfenuceurghilhhouhhtmecufedttdenucgotffhvedqqdeurggukfhmphhorhhtrghntggvucdlvddtmdenucfjughrpeffhfhrvffkjghfufggtgfgrfgkofhisehtjegstdertdejnecuhfhrohhmpefotefvvffjgfghucffgfggqfftgfcuoehmrghtvhhorhgvsegtohhmtggrshhtrdhnvghtqeenucfkphepleeirdduudekrddvgedurddvvdelpddviedtudemieegjeemgegstddtmeehfedusgemkeehleehmegrjeelugemfhekleehmeejgedvvdenucfrrghrrghmpehhvghlohepohigrghpphdqhhhotgdqieehohdrvghmrghilhdrtghomhgtrghsthdrnhgvthdpihhnvghtpeeliedruddukedrvdeguddrvddvledpmhgrihhlfhhrohhmpehmrghtvhhorhgvsegtohhmtggrshhtrdhnvghtpdhrtghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgrthhvohhrvgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehssggvlhhlvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehjvghffhhhohhsthgvthhlvghrrdgtohhmpdhrtghpthhtohepjhgvfhhfhhhoshhtsehmihgtrhhoshhofhhtrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhd
X-Xfinity-VMeta: sc=??;st=legit
Date:   Tue, 8 Jan 2019 18:47:04 -0800 (PST)
From:   MATTHEW DEVORE <matvore@comcast.net>
Reply-To: MATTHEW DEVORE <matvore@comcast.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, pclouds@gmail.com
Message-ID: <1446107549.183303.1547002024564@connect.xfinity.com>
In-Reply-To: <20190108232251.37748-1-jonathantanmy@google.com>
References: <20190108020034.23648-1-jonathantanmy@google.com>
 <20190108232251.37748-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 2/2] tree:<depth>: skip some trees even when
 collecting omits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev38
X-Originating-IP: 2601:647:4b00:531b:8595:a79d:f895:7422
X-Originating-Client: open-xchange-appsuite
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On January 8, 2019 at 3:22 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> 
> 
> > > -static void filter_trees_update_omits(
> > > +static int filter_trees_update_omits(
> > >  	struct object *obj,
> > >  	struct filter_trees_depth_data *filter_data,
> > >  	int include_it)
> > >  {
> > >  	if (!filter_data->omits)
> > > -		return;
> > > +		return 1;
> > >  
> > >  	if (include_it)
> > > -		oidset_remove(filter_data->omits, &obj->oid);
> > > +		return oidset_remove(filter_data->omits, &obj->oid);
> > >  	else
> > > -		oidset_insert(filter_data->omits, &obj->oid);
> > > +		return oidset_insert(filter_data->omits, &obj->oid);
> > >  }
> > 
> > I think this function is getting too magical - if filter_data->omits is
> > not set, we pretend that we have omitted the tree, because we want the
> > same behavior when not needing omits and when the tree is omitted. Could
> > this be done another way?
> 
> Giving some more thought to this, since this is a static function, maybe
> documenting it as "Returns 1 if the objects that this object references need to
> be traversed for "omits" updates, and 0 otherwise" (with the appropriate code
> updates) would suffice.

That's not bad. But I sent a correction which is more like "/* Returns 1 if the oid was in the omits set before it was invoked. */" and returns 0 if omits was NULL. I thought it clearer when the function returns a value in terms of its own arguments and logic, rather than what the caller needs to do. The code I save going with your suggestion (vs. the one I just sent) is offset by the necessity of more detailed comments.
