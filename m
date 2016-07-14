Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418EB20196
	for <e@80x24.org>; Thu, 14 Jul 2016 12:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbcGNM7k (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 08:59:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:50824 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751073AbcGNM7j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 08:59:39 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MfBsk-1blPO31wZ0-00OphJ; Thu, 14 Jul 2016 14:59:34
 +0200
Date:	Thu, 14 Jul 2016 14:59:30 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2016, #05; Wed, 13)
In-Reply-To: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607141454500.6426@virtualbox>
References: <xmqqy4551nph.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ns/0rSEK2ek9uxQHdjlK+9IrhyRhDObjPTommymmEpgXRGNH4ji
 VnCMiSNELylpxAK790Z95BAVL3tJts39ap++sctW7o7Kd/AQVdeUZv7hmQ6bpRXO2TMUlah
 n1VvP2rOz1x6oY0FGJRIWqlPTE9RC1UHpPPdTT+FRIsZpgsPU8zRduxE7yY/yj+9KvJpRI5
 fQWxNVf1migDU5DpeEwFA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:LsiDC+FXqYg=:0F30GDsrHj+gJ4obKh1uTG
 gXlzgw0jsL6MpaH+go0cn4L+GmkqZANnSwVvx1QKDl4YLzNJ7T3D9g65KYuXxio/PWCrl5Jhx
 9QK3+Pv4o/cYQkSh0kTBF3huJNUYT7WT7q3SL5SUqW2DErQGaEijXz8GFhWoGXVCl8iyoewRl
 Iq5EwLbAHqfDGvjNkgHhft0hfbW4JuaCquwUc94a2Qw4dGResnrUEvjnnwrvERPZ335qmu1pQ
 BtF9s8pI5qrnlKRgDElJytjwjvb6BNw0YOW00F/ABCKT2LEDf6Z02deA3Fq8bhCrqqbMQjpXl
 EcNDmhJWPWjMyOKfSQTPXauXuziXsDFqLmgry5zgaTS8NsOj0HYdzJYdhD9tYjqK9S54LQ4Kv
 WZwwE98lYPZ4jr0opa2An930O5LqeF6TzcgV8g57qdqHKiq1r8lzrqTTqp/1bn4EakFBC+OGu
 /oO75S2vibbHEu+nRLTsrSlDFS+S+oo/OcqzeGBZjKuUVmAD11fgfrYrsy0DQfJ0K/oH3FZLt
 13U+bAD3zfax5qVS/B6IpK68wjsD8xhwUwJ4tvn+vX87HOlb1KsQd205HI2/zBkBsAnDGwmxZ
 uuGoWsoCSiopo+D4obdOOprFetrGFA4EOizFjIiLzZpEd+vVRbJQvG9LTQqs6ll9JuTFHQ7Q8
 eRUavrBtPVoog92e4prmG40WE0yTwA168Cj1mGdEyr2ZW/sSHZYT82GCeWwn9L4pLpdB7dF9R
 ByyT80VV7VPyA9gRWxXVVVGZblBtWZNvNqyA0iRnUfQrGnJa68KIOXKz5+DjSp5EYnXcitmNi
 80MRYW9
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 13 Jul 2016, Junio C Hamano wrote:

> * js/t0006-for-v2.9.2 (2016-07-12) 1 commit
>  - t0006: skip "far in the future" test when unsigned long is not long enough
> 
>  A test merged to v2.9.1 forgot that the feature it was testing
>  would not work on a platform with 32-bit time_t/unsigned long and
>  reported breakage.  Skip the tests that cannot run correctly on
>  such platforms.
> 
>  Waiting for an Ack; will fast-track down to 'maint' to cut v2.9.2.

If you are waiting for my okay, then go ahead and wait no more.

I still do not like the current form of the patch, even if it was
essentially my work, but I have bigger fish to fry: I am chasing down two
other regressions on `master`, I have to move that `git status -vvp` topic
along, and I have to get the index-helper to run on Windows. Before even
coming back to the "unsigned long -> time_t" patch series.

So in this case, "it works" has to be good enough for me, I guess.

Ciao,
Dscho
