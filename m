Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8647320988
	for <e@80x24.org>; Mon, 17 Oct 2016 09:05:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933165AbcJQJFA (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Oct 2016 05:05:00 -0400
Received: from mout.gmx.net ([212.227.15.18]:59925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932309AbcJQJE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2016 05:04:58 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Lp3sy-1cYOrR0Ws0-00ewar; Mon, 17 Oct 2016 11:04:21
 +0200
Date:   Mon, 17 Oct 2016 11:04:19 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jeff King <peff@peff.net>
cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] convert: mark a file-local symbol static
In-Reply-To: <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
Message-ID: <alpine.DEB.2.20.1610171058580.197091@virtualbox>
References: <b21c8a92-4dd5-56d6-ec6a-5709028eaf5f@ramsayjones.plus.com> <A430A9E0-B2A2-4857-8DEA-EBD7AA2C9E29@gmail.com> <de24ed05-2857-9c17-920f-66770f898f80@ramsayjones.plus.com> <B7662EA0-3181-413E-A40B-69C88FC46F96@gmail.com>
 <5a9a1c44-8a3f-1894-c4c5-8f1fa96b63b9@ramsayjones.plus.com> <20161017021825.jgpsew7qqfjrirhw@sigill.intra.peff.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:VSlcdHL1aphxhcVSWue05CwLnNYiD+Eddt8C8Ao6VLSAYaBc+UB
 bXGG2Hgllj4Hti2+DXRwIO2ZER1+QPspQltAwnfd7nmQHq4ye8/Hebon9tBD9Zr3wVnsiVD
 KbR/1P79xMBilfVmVFHy10g/Mjano6vknEbe6iKBSnbQlkU+y0r/zIxFYbD8PNnrqA5JOkU
 LUc8Nh2L5RZOUSPkHij7A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:CQBbtzh0wxU=:8Myeu9PKwFKdwlOfngX0uT
 N3dypHz97AfCjfd2J2xy5Lbt9ovJ5CXoAKPLBt1rEY1f6L5YFl/8qCsRLbRFCsvabJ9ujEwqQ
 FsP/YaQneQwzY8G0TtZwscdnv4Pqdf+ORPhDVzgcXFqa/BU32M0JWLG7jJca+w85FB+iurySv
 izPJer2GADvAeK4PQnPDtnOBceiwpcbXfQprMKY9lxHDmPUFNu8gzgSNhOMkAQ0sa+8Z3boJj
 FJbnu52w/OQmxFq75q2Dn752fqSrxj/+YYxgNymGtL5VtbZmCtckEjmj87n32k8ENwnAcG+Cb
 II+yvXuRzG3pF9lrT4j3n6x60eTw8mAtXk6ymkSYr8bzq9WEUQp5c7J8E/DZjj7+xb+w1C5t1
 jkrYvCQVZmS/MLmBKHw/E9nVhRypDNb0AebDS4NSNWzr7gF0gKl8XA6iS5tA3FoHQrbBh7eQ/
 YehR1noxGAY9i8OYDaKxILv4AxSZpIJJktI1v0fWmCC797zM/UlSSKlk43VI7ghtdykcXlo4E
 I74OJNpURg309xw7IW9InFW+afIyHxhujfx4nKfTi8AQ52YXIiTBhigCW3Sk8A+U8EH5VbNSi
 oWSqHL2fOilHh1lIqYIZkdIkRV+xxhAfXfDkL4MvEphr7rzW2e5boDeuud6BRKOZRf3lKPwQi
 PIYf3ga9oa1Lmr1S4NuGqFdx9zLwlc4F8E1YxYUGhcKPeTJ71q/QpGTRx90ikL69CelfqMJSo
 KGcmKH/RoH4/j5rmeMLt6RA7nSjyiIme/tsaKwmwhA4S4YtvEdqSQdyD0/rSBh+8LhCFCnj/r
 MA7m8H5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ramsay & Peff,

On Sun, 16 Oct 2016, Jeff King wrote:

> On Mon, Oct 17, 2016 at 02:37:58AM +0100, Ramsay Jones wrote:
> 
> > Hmm, well, you have to remember that 'make clean' sometimes doesn't
> > make clean. Ever since the Makefile was changed to only remove
> > $(OBJECTS), rather than *.o xdiff/*.o etc., you have to remember to
> > 'make clean' _before_ you switch branches. Otherwise, you risk leaving
> > some objects laying around. Since the script runs 'nm' on all objects
> > it finds, any stale ones can cause problems.  (Of course, I almost
> > always forget, so I frequently have to manually check for and remove
> > stale objects!)
> 
> Gross. I would not be opposed to a Makefile rule that outputs the
> correct set of OBJECTS so this (or other) scripts could build on it.

You could also use the method I use in Git for Windows to "extend" the
Makefile:

-- snipsnap --
cat >dummy.mak <<EOF
include Makefile

blub: $(OBJECTS)
	do-something-with $^
EOF

make -f dummy.mak blub
