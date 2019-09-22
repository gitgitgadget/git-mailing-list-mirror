Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975651F463
	for <e@80x24.org>; Sun, 22 Sep 2019 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392542AbfIVVHj (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 17:07:39 -0400
Received: from avasout04.plus.net ([212.159.14.19]:45954 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbfIVVHj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 17:07:39 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Sep 2019 17:07:39 EDT
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id C8xfiQNRM37rvC8xhiMACJ; Sun, 22 Sep 2019 22:00:05 +0100
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UvodyN4B c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=J70Eh1EUuV4A:10
 a=8w0sICF6Jfexkq3VgCgA:9 a=5cUj-AAhIfbFW2Sy:21 a=GNtb71-I5PfxJ4j8:21
 a=CjuIK1q_8ugA:10 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
Received: from seabee by hashpling.plus.com with local (Exim 4.89)
        (envelope-from <seabee@hashpling.org>)
        id 1iC8xf-0002UT-DU; Sun, 22 Sep 2019 22:00:03 +0100
Date:   Sun, 22 Sep 2019 22:00:03 +0100
From:   CB Bailey <cb@hashpling.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 0/3] use mailmap by default in git log
Message-ID: <20190922210003.4vczwqqucnaww3c6@hashpling.org>
References: <20190711183727.8058-1-ariadne@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711183727.8058-1-ariadne@dereferenced.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CMAE-Envelope: MS4wfNPFRwEtgHaZu2gE8xB/u5b170JghgVqUx8oFKFbRgXcVq5XKLVLXpSzFhiaeSaDB3vqJTwFoF8f/7DgTTppaZwUFMZWgh1F3DRbFXRy0SRWXiubCe+O
 1dxft6dGbUcVY5GRDKoi88SHBR8NhUUluJXY601vQr0gLsyc+iFutQMgqMhlffLaKDE+MOQDc7GIpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 11, 2019 at 01:37:24PM -0500, Ariadne Conill wrote:
> It is not uncommon for people to change their name or e-mail address.
> To facilitate this, Git provides support for the `.mailmap` file,
> which contains a list of identities and previously used e-mail
> addresses that are associated with that identity.
> 
> Unfortunately, while Git's support for the `.mailmap` file is generally
> excellent, I recently discovered that `git log` does not treat the
> mail map file the same as the other tools, instead requiring an
> explicit flag to use the mailmap file.
> 
> I believe this is an unfortunate flaw, as the mailmap file should
> ideally contain the most current known contact information for a
> contributor, allowing anyone to contact the contributor about their
> patches in the future.
> 
> This should be the finished version of the patch set, thanks to
> everyone who has helped review it!

Thank you very much for following up on this. I've been meaning to
revisit my RFC from last year on this topic for some time but
unfortunately Git work has not been able to be a priority for me for
some time.

I think that this patch everything that covered 'log' specifically that
I'm aware of, 'shortlog' still has some issues that I'd like to address.

CB
