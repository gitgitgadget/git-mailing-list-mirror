Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916841F453
	for <e@80x24.org>; Wed, 24 Oct 2018 03:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbeJXMHv (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 08:07:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:5824 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbeJXMHu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 08:07:50 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2018 19:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,418,1534834800"; 
   d="scan'208";a="81100027"
Received: from surajsin-mobl1.amr.corp.intel.com (HELO ldmartin-desk.jf.intel.com) ([10.251.137.218])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2018 19:43:09 -0700
Date:   Tue, 23 Oct 2018 19:43:09 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
Message-ID: <20181024024309.GA22379@ldmartin-desk.jf.intel.com>
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
 <87in29dj55.fsf@evledraar.gmail.com>
 <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
 <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
 <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 11:12:51AM +0900, Junio C Hamano wrote:
> Lucas De Marchi <lucas.demarchi@intel.com> writes:
> 
> >> Yes, I agree on both counts (i.e. it was totally unclear what
> >> problem is being solved and what the root cause of the problem is,
> >> and we would want a new test to protect this "fix" from getting
> >> broken in the future.
> >
> > have you seen I sent a v2 with proper test?
> 
> No, otherwise I wouln't have said it needs tests, and no, because I
> haven't seen the v2, I do not know if it came with proper test or
> other issues pointed out and fixes suggested in the review round
> were addressed in v2.  Sorry.

Your reply arrived just a little after I sent the v2, so I thought it
was just the race and you would end up seeing the unread email in the
same thread. Sorry for not including the msg id:
20181011081750.24240-1-lucas.demarchi@intel.com

thanks
Lucas De Marchi

> 
> When you ask such a question, please accompany it with "this is the
> message-id" to avoid the receiver of the question locating a wrong
> version of your patch from the archive.
> 
> Thanks.
