Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB3D1F859
	for <e@80x24.org>; Wed, 31 Aug 2016 20:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753618AbcHaUfM (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Aug 2016 16:35:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:51413 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752745AbcHaUfL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2016 16:35:11 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LyS5K-1b065Z1hcU-015rEH; Wed, 31 Aug 2016 22:34:31
 +0200
Date:   Wed, 31 Aug 2016 22:34:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/4] cat-file: optionally convert to worktree
 version
In-Reply-To: <xmqqpoor8f0d.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608312233440.129229@virtualbox>
References: <cover.1471524357.git.johannes.schindelin@gmx.de> <cover.1472041389.git.johannes.schindelin@gmx.de> <xmqqpoor8f0d.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Oufd8Md6JgnEvMvZCrhAG8HGJKmOGNhqk5xK2w//q/XkK3JgrzZ
 MqzB8iuTmS/fLZ/lxtbGyQx6dkEGM9bC88KXFxW9BL/pfsTqQSCEqGAp6nYAQek5xvsVtye
 LzpXOF5W6UHLEp8G0lSoq/CPbPTjaq0KEiSWPGb6Uw9Xm+X0wVFbajkKQZruuPsol2sPXlL
 ESxUOLpvkoDJQ3bVrmZug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vN33jw7E/gA=:XIGvxPJ+2S+N/S+oZLw6mZ
 i04iEdpsF7EJSYb1kT2qmscZ6y5tUV0ACreUYjgLl+Pd1TNqytlvmVLwu30NC4rfOE92R/bPL
 tshLw8fanN44+izEvcjIu7G6QE0LqeuH3I5zjb7dOdsSe+Kb7koSJb/oAw0Z8h+YKdTvhEIi6
 OMsYTBk2HG4VHs0MskkBFwONB2+lSvGpZAr12wbtAFNnKMSTqBaz4wNC25QJQPJt2Pv8ixHo2
 RErT/+ZNR51dSU/HnhjvBm8nRpgwHrDWlMgEnx3hYQFjyVwVG11VImnA+Aq8hiCYkNlVhAkuR
 COJi0JQgDBFQXZs9YQmDj0KbCzLFY/tX6sCOBIp47tSxlsRLOUjSE1+Cl/U5H50VZWiMvVmVj
 25quzrPjfqF+osIswGDcdQb8mqfCi3B14P3xgio+Rz3LUr64HPvb3vI2517NgupyfumSfZrHN
 hqQe0VCdCP7PIKsaTScisxk3b2nqQfmkeytjhnCi174nubOXs6oXU0bMZt8osMJVtfRtu+gAq
 gQ2r6uSZtx4snn5T+iL5GNf4qkyyNYBsG03z84btACRI2tzh16JP1867FBn7f0dRKMPI2bx36
 A7gxn8CF1WIeVwSi6aWfdlD6Sv80ivwsMmLhQphpRddiF6pcHWYQDOXpce1wo9A7TRAPhqhtk
 98zS27ayXcJONllIk216Psuh0iYnVxvp8q8MEsmBw77N2YoVnl0L1eW46WrDWoV7pZEpxQ9bz
 ySBD4O7keoL1tpHNFnw3MQbQo3owrSLxJpytG8PW0wjMr/jmsGvGILFgSWyyO9OHIPH+KWWRA
 ddSn1x4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 29 Aug 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > When third-party tools need to access to contents of blobs in the
> > database, they might be more interested in the worktree version than in
> > the "clean" version of said contents.
> 
> Just a friendly reminder before you completely shift your attention
> to unrelated topics.  I think this topic is almost there; let's not
> stretch ourselves too thin by nibbling-here-nibbling-there and leaving
> loose ends untied.

I answered the comments and changed one thing locally. Will send out v3
tomorrow.

Ciao,
Dscho
