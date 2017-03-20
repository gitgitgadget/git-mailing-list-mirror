Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7310520323
	for <e@80x24.org>; Mon, 20 Mar 2017 06:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbdCTGHm (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 02:07:42 -0400
Received: from mx1.constrainttec.com ([59.167.34.41]:48233 "EHLO
        mx1.constrainttec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbdCTGHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 02:07:41 -0400
X-Greylist: delayed 543 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Mar 2017 02:07:41 EDT
Received: from localhost (localhost [127.0.0.1])
        by mx1.constrainttec.com (Postfix) with ESMTP id CA18C149B9B9;
        Mon, 20 Mar 2017 05:58:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at maat.constrainttec.com
Received: from mx1.constrainttec.com ([127.0.0.1])
        by localhost (maat.contecint.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Z8KqbF5CTqpR; Mon, 20 Mar 2017 16:58:06 +1100 (AEDT)
Received: from [10.224.200.149] (dhcp-149.contecint.com.au [10.224.200.149])
        by mx1.constrainttec.com (Postfix) with ESMTP id 9492F149B9B6;
        Mon, 20 Mar 2017 16:58:06 +1100 (AEDT)
Subject: Re: Use base32?
To:     Jason Hennessey <henn@bu.edu>, johannes.schindelin@gmx.de
References: <alpine.DEB.2.20.1703081638010.3767@virtualbox>
 <27077870-76d9-b45a-5727-c339a3d0ffc8@bu.edu>
Cc:     bmwill@google.com, git@vger.kernel.org,
        ijackson@chiark.greenend.org.uk, jonathantanmy@google.com,
        jrnieder@gmail.com, peff@peff.net, sbeller@google.com,
        torvalds@linux-foundation.org
From:   Michael Steuer <Michael.Steuer@constrainttec.com>
Message-ID: <1c213acb-1deb-8959-b1f8-28f99974640f@constrainttec.com>
Date:   Mon, 20 Mar 2017 16:58:06 +1100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <27077870-76d9-b45a-5727-c339a3d0ffc8@bu.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 20/03/2017 16:21, Jason Hennessey wrote:
> On Wed, 8 Mar 2017, Johannes Schindelin wrote:
>>> Linus Torvalds writes ("Re: RFC: Another proposed hash function transition plan"): > > Of course, having written that, I now realize how it would cause
>>>> problems for the usual shit-for-brains case-insensitive
>> filesystems. > > So I guess base64 encoding doesn't work well for that
>> reason.
>> Given that the idea was to encode the new hash in base64 or base85, we
>> *are* talking about an encoding. In that respect, yes, it can be whatever
>> encoding we like, and Linus just made a good point (with unnecessary foul
>> language) of explaining why base64/base85 is not that encoding.
> Since the hash format is switching anyway, how about using base32
> instead of hex?
>
> Still get a 20% space savings over hex (minus a little for padding), and
> it's guaranteed to be a single case.
> Jason
>

If base32 is being considered, I'd suggest the "base32hex" variant, 
which uses the same amount of space.
