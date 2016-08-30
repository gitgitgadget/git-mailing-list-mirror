Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998391F859
	for <e@80x24.org>; Tue, 30 Aug 2016 11:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758230AbcH3LAq (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 07:00:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:54999 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757792AbcH3LAk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 07:00:40 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LjN0F-1b70Nt1bGZ-00dYi5; Tue, 30 Aug 2016 13:00:30
 +0200
Date:   Tue, 30 Aug 2016 13:00:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 4/6] require_clean_work_tree: ensure that the index was
 read
In-Reply-To: <xmqq60qj6kmf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608301300010.129229@virtualbox>
References: <cover.1472137582.git.johannes.schindelin@gmx.de>        <4122fc996a0076c2426d5e1325f2ce2810ef4f9b.1472137582.git.johannes.schindelin@gmx.de>        <xmqqmvjv6uxn.fsf@gitster.mtv.corp.google.com> <xmqq60qj6kmf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:c1KjYn9aE3LZi2OwOaZBgwsPsrptNbBfevlNqrfgcdSIAANsaJ3
 49qpnVw16OvLzSWCY29wlKftEt+NuhG5k833tvsKLSHEEslb6toZ1fv6f5t1nSQIH/u5W7g
 RhxWVhDJOE8dqdwqK+Dc+pg/8hcYiRRg299VxncxyIE+ESVFjQ2o1jisGRvvK7jMd0zf61g
 biZtPP3yd7TT+QJXah4HA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3um0sztva68=:HD0VQBU3ZUTdginw8hmNlj
 5OPp/0JjZrWvjIP37tbjPHQKONI1n0efAY6+dvckfqXjm6RA+Yri+ToK/KOgFGmp3U2DA8Lkv
 t6waUsUvtS0FLxPx0nk29ztG7zHDAk4nbZYFYE2uiv9TfStFh5wj5gpDViz3AxrWF6BVepY9v
 kEbzwHLtIYKLdgubZMV8Dth+0VoPuMSZgRsgKCnm2+Wl/HiT9trhpHk1Xg00r64+eO8dtQ7n1
 a2pTPOEB5RhyzuUz/POOeYKeJS+h21KJrCglxVTsrELqvn2A3ZfripYvBGSyQZ4FagYxbCRx9
 fJ41gWb0ck/zAwfIZuVNd6EBtL5QxbrYPKTR2OlSgllKp5fgv4vakVhkndh5DFLyMgsVtWn1S
 EaHvvMPlUerCQAWk0xeTpXMoHszujaRuzRtQR50bRW0TkCA36vPmDSh6Ix97GTSeQve6E518X
 znCbGUeoLmSNhvWnfgKygp/guPBP33MUzhYqjFVOurO7Ro+52CP8tPWQMmW3h5sYEqDOO6VlV
 RWgPXCDVEyyvMILWLuLuaPzqXBdjr4FGv1pe72stYqHFs/eZARt99pyfvmDZ9RQcCJuB1k64F
 9e73vmwHLEPXmbPwNuv2zoEuIcfwhW0sW05XefJppvgvzZOU/cnbHt2oR7A5v7TUy6ycS6bvK
 puDx6u5eJS2XhROcXCivM7k4wo1cVac+z062wFWzAXZ6gj8hgFliTHPtyeZxsJYvjcV+HKooX
 Eg23yUqnEjBVBvKI7k38p08TOGHBf23kk16MJWWzCxpPcCdEi2zsP2diuYV/P6gzyDog63Fkd
 wgfLaeK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am not sure if it should be left as the responsibility of the
> > caller (i.e. check the_index.initialized to bark at a caller that
> > forgets to read from an index) ...
> 
> Scatch that.  That would not work in a freshly created repository
> before doing any "git add".  An empty index is a normal state, so it
> would not just be annoying to warn "You called me without reading
> the index" but is simply wrong.

Fine. I changed it to assert that the_index.initialized was set.

Ciao,
Dscho
