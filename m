Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB3F02018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:19:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946500AbcHEVT4 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:19:56 -0400
Received: from mout.web.de ([212.227.17.11]:53833 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1948624AbcHEVTv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:19:51 -0400
Received: from macce.local ([217.89.153.218]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MJl1M-1bUgas3oM0-0016hd; Fri, 05 Aug 2016 23:19:15
 +0200
Subject: Re: [PATCH v4 07/12] run-command: add clean_on_exit_handler
To:	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>
References: <20160729233801.82844-1-larsxschneider@gmail.com>
 <20160803164225.46355-1-larsxschneider@gmail.com>
 <20160803164225.46355-8-larsxschneider@gmail.com>
 <20160803212433.zzdino3ivyem5a2v@sigill.intra.peff.net>
 <826967FE-BFF8-4387-83F7-AE7036D97FEC@gmail.com>
 <20160803225313.pk3tfe5ovz4y3i7l@sigill.intra.peff.net>
 <74C2CEA6-EAAB-406F-8B37-969654955413@gmail.com>
 <20160803231506.h5mo5lah2pgwdvip@sigill.intra.peff.net>
 <6C522B0F-F8F7-4B51-8BF0-67D9EDC97B3B@gmail.com>
Cc:	git@vger.kernel.org, gitster@pobox.com, jnareb@gmail.com,
	mlbright@gmail.com, e@80x24.org
From:	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <b14c6063-cef8-56b4-eb57-7ab8577ecf0a@web.de>
Date:	Fri, 5 Aug 2016 23:19:07 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <6C522B0F-F8F7-4B51-8BF0-67D9EDC97B3B@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ENF02ObEv5ideE26Hj/yDXoVTyCTFZTGJ+5DAU7ti+HaYpZ2M0h
 7gF3YsXQvVacU4qVLcY5W2lKezKzx4zauxeSHZ25CDf96SIbsQyEnCLrpthNknT23Wrw7xh
 4vrTB81tuIA7Ues1bcRFJtUFqAod0aTVTGsx90JuticN2MnExeCee9WUE/id0SPraDj8CZe
 m9jMSyOyBHDvotPdRRweA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:q4GntR3Cx6U=:1mmeKZxticSLxhc6ufqa7b
 iLYYm20XVm5NPhVYOeIOvb6hP6lQHCZ17B27Nf4D8cb/BnFAw2uWtwno5fQZVxfBBfUDBCiqV
 B7uZLjrbU2gl4Jp/1J8PahgnFfn2i2xEe1sGjjfL94DnBA9ZpRGvBcZFt8p+VZmE0MgyLrzm7
 Hq8XYZohRxyh/fhS7WlNL7U921Lqt/XqbWMOnevL+nU7jZ1macAUGkZQ0bd/Dce7vzgN7jKps
 5d9KQ/eUEhleHNxLiprxfyvfQuHT9K0RaWdFQuli4NJjTx0pwP/V4OuyN1WqDOQycM9TIf+Rj
 7lg1HEf5eeJQHG3A5qVfUoYcq6BpfJvgphFNM+NHALx4x+C2dlF+4MAzyI9mkD+gCdghEWS9j
 s4SKsxQ9+vaDKpBeW8SVjWXc2twEquPsp/3dXSLXBRuK4nhPqx9PLZx/g8U27z4FOHuybL+FQ
 vU9F0f+wRZcCfZ+uGABhPZdLnFLYo3hQ1BBFY6x8jnceODGRx70z7wo1727I4rf5AaRV2u/2h
 fTarl4T2YejRa4jsb6a6E8remz9ZEWKJH4nxLaNE8ZsjoP3aUNGgSFUmAtchiN76gjMPtPejf
 CYCz2YvLczrH4WlVBjGeQt9XZbhhAQD6Fz3EhIYIDI2TzzQ8KJb1xgjW6/rFvdfb/RcET7gzf
 3rGkKUm0mtPNokjFTfXroSzcEuOYZvFUh6aFpcg/CJh+fykcGo6u9zygZCkz+wHSvi0DfDqup
 VaDpXdWO0zjLpBwnviwH90My1j8rBoQICJ20FAviKuqZoWRMZnWcWWVZQpSTyHWXRlsHdpzgA
 JjG/7XC
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On 2016-08-05 15.08, Lars Schneider wrote:

[]
> Yeah it could do that. But then the filter cannot do things like
> modifying the index after the fact... however, that might be considered
> nasty by the Git community anyways... I am thinking about dropping
> this patch in the next roll as it is not strictly necessary for my
> current use case.
(Thanks Peff for helping me out with the EOF explanation)

I would say that a filter is a filter, and should do nothing else than filtering
one file,
(or a stream).
When you want to modify the index, a hook may be your friend.


