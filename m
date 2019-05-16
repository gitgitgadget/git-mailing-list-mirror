Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849131F4B6
	for <e@80x24.org>; Thu, 16 May 2019 01:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbfEPBqW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:46:22 -0400
Received: from thyrsus.com ([71.162.243.5]:59766 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbfEPAfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 20:35:22 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 54B9E4703049; Wed, 15 May 2019 20:35:22 -0400 (EDT)
Date:   Wed, 15 May 2019 20:35:22 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Finer timestamps and serialization in git
Message-ID: <20190516003522.GD124956@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190515191605.21D394703049@snark.thyrsus.com>
 <871s0zwjv0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s0zwjv0.fsf@evledraar.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com>:
> You put it key-values in the commit message and read it back out via
> git-interpret-trailers.

Speaking as a person who has done a lot of repository migrations, this
makes me shudder.  It's fragile, kludgy, and does not maintain proper
separation of concerns.

The feature I *didn't* ask for at the next format break is a user-modifiable
key-value store per commit that is *not* in the commit comment.  Bzr
has this.  It's useful.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


