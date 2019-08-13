Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146771F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 15:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730062AbfHMPkp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 11:40:45 -0400
Received: from mout.web.de ([212.227.17.12]:48637 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727621AbfHMPko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 11:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565710835;
        bh=wMxYz3SiItndM8z4F+TO8/x9SrGuK8vI/j+IWjKU1cA=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=glXoXyXawzGpx/zG3h3xacQ/xcp57zmG2GHOOO4AO3QltdjH2OE8vVbecqAR1AOqe
         JJSdWra3GRGA5N299gwZ5zllJuQ+N/Km6aIoUGgd2I2xRuZO/qXExb+MWh5hSR8xJf
         4uLiW3IK0+WPlEdSa53dqOUHcPMn6FYiSlTCaOm8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0McFPX-1hgiyz3vUt-00JXzd; Tue, 13
 Aug 2019 17:40:35 +0200
Date:   Tue, 13 Aug 2019 17:40:33 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     "Yagnatinsky, Mark" <mark.yagnatinsky@bofa.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Re: suggestion for improved docs on autocrlf
Message-ID: <20190813154033.uhi7w5jgwcj4xan7@tb-raspi4>
References: <577a66e0c26545aaa4795de3c5189c9d@bofa.com>
 <20190809033406.5t5ag3qmh36ideec@tb-raspi4>
 <0c1b48c9fad641689ead69fdd9f72d63@bofa.com>
 <20190811121004.guygurnopwwggvsp@tb-raspi4>
 <64c0a35825af4ff3956c6c9a5fb748bb@bofa.com>
 <20190812171049.ydec3nsmkt2xplhd@tb-raspi4>
 <aae529ce1b084b7bbcca3977e6909417@bofa.com>
 <xmqqo90u9ric.fsf@gitster-ct.c.googlers.com>
 <20190813032452.qg2ufgljm4bjeznr@tb-raspi4>
 <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5b84e2b8184414bb416f3aa83361a1c@bofa.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:i9xMG/OoQ69kv3Mctvbk4vL9laUpa2wRU24KecksnCY0f1cFZz/
 /zu3frIbKkVm+J4pQ48hlayb4BaziwhDxrNtG+v25w8LiHlFCs0Hqvv2lWOiegLTTdFvvyP
 vxrGHBaEHp6cYjzhV1kEn3K853FgO+uSanUTen6ZOqo3T7k0Epn3ahdB2dOorl6n3c1gvC2
 j9MOeN1JAh9AYv+gGMsWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jHZYOqqJiX0=:zI9rkdVKkftOr7bwBSADZ1
 m9RUlZ3GgN58J2GvPByDOSM3Ib3H0QJ6sbFBu29zW+2j4wrTBEj6qkQ0XkQcEFbQl9KmeC4r3
 eJM4Q/Zj0xIid4VnZ4wYxejP6XTbet3PhuENnwB6M60hO1B9X9OpxUkTBrpM8iJ+0PAUPHJOJ
 3CVCU7zAQKutjCG+IxYRf+Fh6sp3nbl4efZKzl9gCeVBROI2Ubvf2SvZzoUphW6PavGv1wzfn
 kBw0I65QUsjDFKj1vDANZ+X38qbYhL+uHV/VvEK9AGqeWiwj146a+iQFCDoomVvfQH4WkHQa2
 Nr++Ejaj0RfOlLMXzDm2QYQVJmBwdVBcP4u+5ezXIGPn2oBrPdBnZJrJ2WNGM/RYgEk1NWdXa
 1BVY7YmaQCcPWnDnm7Q2ez8HZu4ass2DV81qVwuG+93wiMn9mXwEmbMeqPLjrcZtVvP+5KPCV
 G757zqaVtP4CMiD+1rAnhlGJYtxxSLckyZ7HOe2TIP/BJos4m86yaYrLJ9b+CbnKD+eFU1oni
 bmQD1SDFeA8/4AyLmWAT9vTkaG71hfCSjx9ZFm9g+Mc8YwYJwnb+qvvR7zBGdWYea3UwdAtcT
 t/GPT0dF7vkVzcJVNPTCo8uuWIJjk3ZuZN+S1jALHeY4EbWReaVBFpRV1S2frnMyBV1NKHaDb
 IB/iVvys1B0kxdPyJC6r4gys2GeVmcjFdbtu+6YhIeE9L8cTXj+uZHe+cr40RBqCIIwn9QVsy
 RvUwAbQOPp3RgEELH/GTtjcO3Z0rqn+yx1qq2DwNkypiWDAJqjTJYWhekc+LHwIgyJRFAxm78
 XJ3NpdhS5P6GPXpCGJVXy87Rzke2l+7MPpkeQSfZlixwUGnLufsRv/fw7gApAamj9MbnE3yaH
 /qY8KSoDbua8klcZl1JGlYsmaRBIHaY62PcAabU9X1AtCV0Do/JLwOvZjdhKHDrod+6aEd3Wd
 09r5DhFU9TY4Jskfy+/DVc/Zei8e/dmGKP1pzBpY7ujYyokH5Vtm/HHq3xQy9iZgZogYE7J5u
 jtRJRyRD0+TfcLucJBHrps8slUIkR3YvnI6XH6WmpJJ+C+tbxDd75IAdkkF2Xr7PpjyvQCUaw
 rXYfvQo3H6smxDqD7tOVlMPcnBjpcAi0xB8wgR3GKsUuqZVOF4yV0N/3Q==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 13, 2019 at 03:31:43PM +0000, Yagnatinsky, Mark wrote:
> Thank you once more.  Finally, I believe I understood everything you sai=
d.
> I was about to say that this contradicts my own experience.
> But then I remembered that I normally use my IDE rather than the command=
 line.
> And I just checked that indeed that the behavior of my IDE is totally di=
fferent!

Would you like to elobarate which IDE that is?
The core.autocrlf handling has been improved a couple of times,
and it seams that your IDE does things different from git.git
(Which is not ideal)

> It renormalizes line endings of existing files whenever autocrlf is set =
to input.
> Sigh.  Okay, great, life makes sense again.  I want to yell at my IDE no=
w.
>
> I now feel brave enough to attempt to come up with better wording for au=
tocrlf docs, if you think that's worth trying.

That would be good, I am happy to review patches.
