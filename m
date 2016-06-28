Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DBAC2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 13:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752429AbcF1NP3 (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 09:15:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:53413 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbcF1NP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 09:15:28 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LymHf-1bN8L54BrL-0167QA; Tue, 28 Jun 2016 15:14:45
 +0200
Date:	Tue, 28 Jun 2016 15:14:43 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Duy Nguyen <pclouds@gmail.com>
cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] Native access to Git LFS cache
In-Reply-To: <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1606281513380.12947@virtualbox>
References: <1467005913-6503-1-git-send-email-larsxschneider@gmail.com> <CACsJy8B7ie_oQRZ7Pw3NTo4YyXwZOer-iDUVxDPSY_uhrQi1bw@mail.gmail.com> <alpine.DEB.2.20.1606281139490.12947@virtualbox>
 <CACsJy8DCovHoutyEYwaxdCTU4K-h8u_JTOwt8GUiNTkkXzGz3w@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YIBOyZGnsz1YzYEg6TRTg7xOhRR+4isH6wZuA83A9cu9M7U8leH
 8erLn1s7shY7rWNxoQcumqww9FDlDwk4NM/C1ZdUPA2QSI/VUrY2JmtO/M74vazeucYeloo
 8XhOpuZfsobGqxx4JKHm2dtNvgAfJj1nhzqUJGsY4EYu0lJtZZ1FMrIUDBrrs7tzYYv0yh9
 9WVfg9aAbjM8fog5+JYXQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:+iIK62ma7PM=:JzJm2Esk/GbYiS3gALo0U8
 EN0hUaERaaEU6y5CNrC2o2tvFssAGBisZSPOKLdwM5JRUenFFpwtgJ3B76y4Qm5NgUAR3zakr
 772MHqvTd066JtROtocDgeURB2Y9cyndArdztlBRNZuhJMQfncWSnhcJzt82cWjrDiLizoaom
 UHUfspcv9AOsgi5RMQT8iRBlRT62JTUNsyD5C5Tf+WUC+cUjk+QjHG+u8ct5cCDl10rhevXwI
 HjzRjT9YndvJlcbI7qIfzBWLqDKGwyqkRtvZ41VISi6gjxv8y+by0QFenbGv3cyqpG8dXbooW
 48oivBbUmx9vNSgkuSr/PptTUJDO7o4FZsi6Y87U8y2tPKhit2vmLBRTlWkUDwDNpWi9X1C9y
 X/R02fpvVNF/tLisB893n3mPdh5AZydIYQg4RlawND2Y0PxgwO/EPEnQZLxLGgS+rHx/JWvPC
 +fcxkSj86OyaNJVJz7hxvjvY1X8sgj0WAHCyNGww1gySzIuisawCJeFEDybMHJvy3oSBBwdzh
 9nkNnwmIn2G0GDhbSM3enlYuJVhLG+dhkNGAg44FOyA1b9FEkpY5c930DeaV0GIa15hYvDMxd
 7ZafNhPtC3VKpUQbqi3DCY+hYLjzwyLg6UGiC1cRXscrfuRl9fl5ezxHUJi+8KUW1g0fVhM0A
 v3JGVO/lE5K2uNaZfzdIMSO1coopgsQ9rWj6kuDFss4HC1a24hxTZ6l6c0btZDndt8JHZkZHv
 kivdmNI2ELCC7ajTVSaHD1zFbqshqr//V0RHNL6GvXIDW34WTMTzEA0/9CHktlUsyLgPPbPwc
 3t/zMrq
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Duy,

On Tue, 28 Jun 2016, Duy Nguyen wrote:

> On Tue, Jun 28, 2016 at 11:40 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 27 Jun 2016, Duy Nguyen wrote:
> >
> >> On Mon, Jun 27, 2016 at 7:38 AM,  <larsxschneider@gmail.com> wrote:
> >> > ## Proposed solution
> >> > Git LFS caches its objects under .git/lfs/objects. Most of the time
> >> > Git LFS objects are already available in the cache (e.g. if you
> >> > switch branches back and forth). I implemented these "cache hits"
> >> > natively in Git.  Please note that this implementation is just a
> >> > quick and dirty proof of concept. If the Git community agrees that
> >> > this kind of approach would be acceptable then I will start to work
> >> > on a proper patch series with cross platform support and unit
> >> > tests.
> >>
> >> Would it be possible to move all this code to a separate daemon?
> >> Instead of spawning a new process to do the filtering, you send a
> >> command "convert this" over maybe unix socket and either receive the
> >> whole result over the socket, or receive a path of the result.
> >
> > Unix sockets are not really portable...
> 
> It's the same situation as index-helper. I expect you guys will
> replace the transport with named pipe or similar.

Yes, I will have to work on that. But I might need to ask for a change in
the design if I hit some obstacle there: named pipes are not the same at
all as Unix sockets.

Read: it will be painful, and not a general solution. So every new Unix
socket that you introduce will introduce new problems for me.

Ciao,
Dscho
