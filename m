Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D39C21F462
	for <e@80x24.org>; Thu, 23 May 2019 21:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfEWVTS (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 17:19:18 -0400
Received: from thyrsus.com ([71.162.243.5]:56324 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387914AbfEWVTR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 17:19:17 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 81BFD4704887; Thu, 23 May 2019 17:19:16 -0400 (EDT)
Date:   Thu, 23 May 2019 17:19:16 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190523211916.GA73150@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <86h89lq96v.fsf@gmail.com>
 <20190523205009.GA69096@thyrsus.com>
 <20190523205457.GC70860@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523205457.GC70860@google.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com>:
> Honestly, I do think you have missed some fundamental issues.
> https://public-inbox.org/git/ab3222ab-9121-9534-1472-fac790bf08a4@gmail.com/
> discusses this further.

Have re-read.  That was a different pair of proposals.

I have abandoned the idea of forcing timestamp uniqueness entirely - that was
a hack to define a canonical commit order, and my new RFC describes a better
way to get this.

I still think finer-grained timestamps would be a good idea, but that is
much less important than the different set of properties we can guarantee
via the new RFC.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


