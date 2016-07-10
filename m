Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4BB11F744
	for <e@80x24.org>; Sun, 10 Jul 2016 07:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbcGJHMr (ORCPT <rfc822;e@80x24.org>);
	Sun, 10 Jul 2016 03:12:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:62925 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbcGJHMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2016 03:12:46 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M2c1V-1b59pT3QtZ-00sKVu; Sun, 10 Jul 2016 09:12:38
 +0200
Date:	Sun, 10 Jul 2016 09:12:36 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v1] travis-ci: enable web server tests t55xx on Linux
In-Reply-To: <xmqqd1ndvxqf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1607100911090.6426@virtualbox>
References: <1463647511-54811-1-git-send-email-larsxschneider@gmail.com> <6C0F6649-C238-475E-BAA5-5F3A0EC5DA2D@gmail.com> <xmqqd1ndvxqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:CKHBz/w6NUMfA6VTl0hSNKYHr0CPNct9T6xzvgnMGyVyeW656ZX
 cHY15qFWu8q5+I8jDnpsUwqZg7YIq2aNre/Y/RwZDXSNtYx8uX9uWmZsnddfxt/ZIvI+BDW
 ZpNk3/G1z8NpLnVl8pHEN+jgz2ZwJq+yBiYEU5FXkXVijh+dKnbJDo878mh9h/qqFqH9NOb
 roD7y6Amgnz9002y1Zitw==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:QbmdtIIH0RY=:UV/xw8/lZI0e+5j7PNyUey
 0B2LlmByEASnDrH14GotcL7LXpBJzWW2eZazA7OxgCe6jLC7J5lD43dDnU1KHD0fXhoW9xjHi
 Rh1QdQxrCwpgcWFX+EB1uLOxPNrAOfBXhdKaebTjQK6vd7x3obbFIA4oL7hkCfCFgXvZ2SeBK
 gZ/KKkGZ0IcFF4oCmAjakqYVHcj0UlCLnJcuGaDCg+MMDwXT50yYXENtXywogUaMRkisFUFlW
 4d2oCTVFiXQbFXRU18MXBdTE/agQUIKRtqqB4oaI5NN1Ii1BT4NISCdv9vMITnlknj+J6zdbg
 npTgcVh7z84m8paDAuhi62KHspMU+4PPH5fgU2vgcFvwOFntY7+FKEwE4lzOGMbjPsJ4qCKzs
 eBWGywyG9ZwBLrFBXCJLqOSGB4JlfHHKkrUubUco3AHpk5iHEiHkUHf7yLIakOcB58+Eu/vQr
 CPvoWkeoXbK2VPdAVBf80ej+DNoabfUyfT00xmXuvHCkw8AA+sPK0QA0Z/Ld3PFKZVL8QLYQw
 pBxhEr8/SxashpDOfzQyKslS8DuGYtKJoTS/4LaZxGSx/6FVDWIOHkpjQ5EBBRD8lra7oyp3B
 IKxqHKP15pnZXNz06tz7e4xdrs/wMqamcWvUB3vetVSmaoPEoMhEXbxnJ3rPCgRdTvUOlv4PI
 YTKkk2SA4FFIZY1BrcBdQSGwd45p6nOcMcxOBYd8UxKZribIdHWATe4KCg8yMZNBRT8NgMMrJ
 kCK1zz0z4DToGTYcOESILCLDS9ZmMMeL+BV1HprhtR7UJCfzM9AIzjRd5J6izoXRAk0rvsLzl
 0GV1dLG
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

On Sun, 19 Jun 2016, Junio C Hamano wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > Hi Junio,
> >
> > is there any chance to pick this up? It would enable the web server
> > tests on Travis CI.
> 
> There always are chances unless a patch was rejected with some
> reason, like "no, I do not like it" ;-)
> 
> I do not see anybody commenting on it, and suspect that it simply
> did not register in anybody's radar.
> 
> Folks who actually read the Travis report of their own commits, do
> you have any comment (I just reproduced it from the original so that
> we can easily apply it when we agree it is a good thing to do)?

As long as we're not running the danger of timing out, I am all in favor
of including the tests.

I exercise Travis quite a bit these days, also because it catches more
bugs than I can catch locally.

Ciao,
Dscho
