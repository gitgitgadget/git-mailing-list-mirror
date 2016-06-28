Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFD7F1FF40
	for <e@80x24.org>; Tue, 28 Jun 2016 09:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbcF1JkW (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 05:40:22 -0400
Received: from mout.gmx.net ([212.227.17.20]:54555 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752070AbcF1JkO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 05:40:14 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MQRZw-1auhV825l6-00TnaN; Tue, 28 Jun 2016 11:40:10
 +0200
Date:	Tue, 28 Jun 2016 11:40:09 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] Native access to Git LFS cache
In-Reply-To: <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606281139490.12947@virtualbox>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com> <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Saquy1QsrfXfa6JvlHXRx3YPHZfvJtQ1AMis16fMcjh68hh09S8
 1gWcGdNApEE71wb+zoDnh3r3/OVrG53ZxareWM8HLMSX8ONppK222DsjHHMYOeSRUJNEw1Q
 qK+n/viNk8EVetcamks+DXFrQ7jnyhVfb+1BhLL+qEoYvPhMjKJGndssJNbynDHd5Ok/Esg
 a5eD9lOGUUTfe2W3M9hQA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:emXM9CG2UYA=:LmIAtzT4d4TcRodZhaBbT7
 YA1ZcKjoKgJuBUt2TjNjgCNjtBq+WDqylMl6hZnIe3XO7oaS7iGPOVGUS3DH94U/I+NZbjfRO
 sFK8lV6uuAgJYtqnZhKIJ6BdiRllI2YhJoBB6bpV7VLPwUhnErZWI+QD7fmYTuzNB7BlFAAow
 Xp3M8hnAVLm3Gjt1GZnpCsnnCF1AToJLI62lwqFW+qcs2GjlMVbG43en1S106xVtI48XqPMnd
 N//nh4yfvIiSNHxws8T3udwxb9KKOb34QHCJJ1nHNY6MN/cTfq5DoriCwUzjkiaoggYImCP3m
 SwweLgl4LulOpmogjd+eXZzOqY5Y2XdlStt4WlDSX305Byog1sj0bE2j/iQ/D/hzrDB1sYL4W
 GdsG3i5Dbzz5S0Xjp8hzIbDfGweJdaGaL2PImjux7d+tXPaWib5CPKRe2PYS+9LKAFgPfsxT0
 CHHcobvMLwkCjk0UrU3gsknoGeb5Brl2pSTPMOu6AlKVNoyHsnWUDRVVJI6hSHMaByaU99dDx
 zEXPLicvaFkfJQ4P9ZiysPa93fk5X/RqjznYf9lkWCrJS2BKEK+iqyKDAHZ5zBnUda6paLwuz
 COQgSm0vpYa2YbT2TE43uoVy73oXEoxswSo1pwnOMLQ26bGYZC+1Jy7NHWezW+k+p9aG6tBHI
 e9tWnzt99zOTFEFoT3/vsU6bF8mWgnCkC/z6bRSP9wahoLu5BJpyza0hEzS6bsbGalO3j7ChG
 4ocS0biBv4D7m8aAwSR8AyX+8Wt0Sb3eyDetZg1fRrgJiULJalXqN6feCJGxuLcAvfW3TJPWd
 BpR/Yom
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Mon, 27 Jun 2016, Duy Nguyen wrote:

> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
> > ## Proposed solution
> > Git LFS caches its objects under .git/lfs/objects. Most of the time
> > Git LFS objects are already available in the cache (e.g. if you switch
> > branches back and forth). I implemented these "cache hits" natively in
> > Git.  Please note that this implementation is just a quick and dirty
> > proof of concept. If the Git community agrees that this kind of
> > approach would be acceptable then I will start to work on a proper
> > patch series with cross platform support and unit tests.
> 
> Would it be possible to move all this code to a separate daemon?
> Instead of spawning a new process to do the filtering, you send a
> command "convert this" over maybe unix socket and either receive the
> whole result over the socket, or receive a path of the result.

Unix sockets are not really portable...

Ciao,
Dscho
