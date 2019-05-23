Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2833E1F462
	for <e@80x24.org>; Thu, 23 May 2019 20:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387809AbfEWUxO (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 16:53:14 -0400
Received: from thyrsus.com ([71.162.243.5]:55586 "EHLO snark.thyrsus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387533AbfEWUxO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 16:53:14 -0400
Received: by snark.thyrsus.com (Postfix, from userid 1000)
        id 806E74704887; Thu, 23 May 2019 16:53:13 -0400 (EDT)
Date:   Thu, 23 May 2019 16:53:13 -0400
From:   "Eric S. Raymond" <esr@thyrsus.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Subject: Re: RFC: Separate commit identification from Merkle hashing
Message-ID: <20190523205313.GB69096@thyrsus.com>
Reply-To: esr@thyrsus.com
References: <20190521013250.3506B470485F@snark.thyrsus.com>
 <86h89lq96v.fsf@gmail.com>
 <20190523200929.GA70860@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523200929.GA70860@google.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com>:
> In other words, usually the benefit of supporting multiple hash
> functions as a reader is that you want the strength of the strongest
> of those hash functions and you need a migration path to get there.
> If you don't have a way to eventually drop support for the weaker
> hashes, then what benefit do you get from supporting multiple hash
> functions?

Not losing the capability to verify old parts of histories up to the
strength of the old hash algorithm.  Not perfect, but better than nothing.
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>


