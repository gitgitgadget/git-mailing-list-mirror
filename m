Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C20892018E
	for <e@80x24.org>; Fri,  5 Aug 2016 15:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161573AbcHEPe6 (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 11:34:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:54151 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161463AbcHEPe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 11:34:57 -0400
Received: from virtualbox ([37.24.141.218]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MMjgF-1bc0vs0J3P-008XKf; Fri, 05 Aug 2016 17:34:51
 +0200
Date:	Fri, 5 Aug 2016 17:34:49 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] nedmalloc: work around overzealous GCC 6 warning
In-Reply-To: <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608051728380.5786@virtualbox>
References: <cover.1470326812.git.johannes.schindelin@gmx.de> <57360f4885bdd5c36e190bea288f1e1f7f706071.1470326812.git.johannes.schindelin@gmx.de> <57A3BA26.5080601@web.de> <xmqqk2fwyx8h.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1061244755-1470411291=:5786"
X-Provags-ID: V03:K0:QwaKs0e6pMmewpxDcEwfJvYqA8+z9nI73TPtL7O6m7B5Ug8gr94
 QAbsuoJvxkwlx21ZN9ac2pam5lMw1u3Svm3h9GsJjLA6hlVESblRuDPDeWGe5P19QHwiwsb
 6xfbO9qyRxD01/P+pkKruvJW2aqvzz1jxoaQ1k4hDqzsxWB0w+qwWfXiDJXOO6jQiWw0fF/
 PaOMeBEZCvu6/bBHnDcTQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:m3zda3wpkmg=:I0A5rlt1YZ3ZTBfoJ9X4CN
 G0OqLyCF8G63nqwpsZKxi0SMnbivuMLQdLDLX/iroAQD994i+QDoJhGiShGE5+ny2lMgVWO+4
 ScCOYzDJCnVqjd11Zqx0vpeWIz3Y1qEI6Q6vjnGd8XMXnjoEqJ7wZm4kBHr6ca4gt0+w34CTT
 MPMNlz9zduSTYtYHfIFK8Dvfa2Ca5grombb/dn8oxbD7kzjsFlrP18PAiadY9m94ANms9jAXP
 NbhqITZ5VyVA8TvhLkBjyp8CH6DK6hVOl4BBY+CK9/e2/4K4xYJWUFSoLxht3Ph1lSDknFB6o
 yqkeBtT5x5PhNX2WeZmoj0hxOk6Jf2WQDfhGov/+CfSAK5o3rw5scVkxvJEM2Udh7vZpqWLAK
 SJ2YD34pDj66fJtWvN9D3ZjumAeSsNOJUiKtCusA3iUEJ0G2AYInKa3FzK/YC+XHhTG6PDks9
 /+qOaTfcORw9OVlvvJqMPaQL6dAdpDh5Mur9N8nEtNslEPuwgfRuFGIOLzJhLuqvyNz08d2HO
 g8GgkX7Y7ysX+ZApM5F/aThJ3rcOYlJlvyIKLvqDZ45HSIcU4kGPITo6Desdh+/YXWbJmojVO
 yuQoXd/hYBuJZIqHKI6smjGmkP5hjkR21XZD8ziyDY3SpvU6njt7N6X1wiefqZ0SeFgQI8ikT
 qjPjLozw36pT9rI0esKP2XQWEJ94AqWm2O5dUG8R0NlxZnl4z2b5BJwgyQFxHEv+q98SBLsNu
 0qj71D4IcELG4l68t04ztaxSRMUn/RRwFSBueHVJ9Etmt1If01fVOo/aGJHtm3pzCUj0NANSW
 YvaIfgf
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1061244755-1470411291=:5786
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio & Ren=C3=A9,

On Thu, 4 Aug 2016, Junio C Hamano wrote:

> Let's try it this way.  How about this as a replacement?

I like it (with the if (s2) test intead of if (s1), of course). But please
record Ren=C3=A9 as author, maybe mentioning myself with a "Diagnosed-by:"
line.

FWIW today's `pu` does pass the test suite without problems in my CI
setup.

This setup will from now on test next & pu in the Git for Windows SDK, and
rebase Git for Windows' current master to git.git's maint, master, next &
pu, every morning after a weekday (unless I forget to turn on my laptop,
that is).

Once it stabilizes, I will figure out a way how to publish the logs,
because playing Lt Tawney Madison gets old real quick.

Thanks,
Dscho
--8323329-1061244755-1470411291=:5786--
