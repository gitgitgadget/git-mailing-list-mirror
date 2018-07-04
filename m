Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E5C81F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 08:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933844AbeGDITG (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 04:19:06 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:49542 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933822AbeGDITE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 04:19:04 -0400
Received: from glandium by mitsuha.glandium.org with local (Exim 4.91)
        (envelope-from <mh@glandium.org>)
        id 1fad05-0003n8-2O; Wed, 04 Jul 2018 17:18:57 +0900
Date:   Wed, 4 Jul 2018 17:18:57 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: Checks added for CVE-2018-11235 too restrictive?
Message-ID: <20180704081857.kgoiniydk44ooq6v@glandium.org>
References: <20180703070650.b3drk5a6kb4k4tnp@glandium.org>
 <20180703141518.GA21629@sigill.intra.peff.net>
 <20180703223030.xds2bfgeuaa35isj@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703223030.xds2bfgeuaa35isj@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180512
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 04, 2018 at 07:30:30AM +0900, Mike Hommey wrote:
> That being said, I'm not even sure this particular use case is worth a
> new feature. I'm not storing random stuff as gitlinks, I'm storing
> sha1s. Well, maybe a mode that makes the distinction between "git oid"
> and "external oid" might make things clearer for git itself, especially
> for fsck.

Actually, I'm also abusing the lower bits of the gitlink mode, to
differentiate between regular files, executable files, and symlinks.

Mike
