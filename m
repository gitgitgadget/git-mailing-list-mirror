Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0571F453
	for <e@80x24.org>; Wed, 24 Oct 2018 17:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbeJYBsf (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 21:48:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:53733 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbeJYBsf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 21:48:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Oct 2018 10:19:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,421,1534834800"; 
   d="scan'208";a="98241474"
Received: from ldmartin-desk.jf.intel.com ([10.24.8.127])
  by fmsmga002.fm.intel.com with ESMTP; 24 Oct 2018 10:19:41 -0700
Date:   Wed, 24 Oct 2018 10:19:41 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        lucas.de.marchi@gmail.com
Subject: Re: [PATCH] range-diff: allow to diff files regardless submodule
Message-ID: <20181024171940.GA2921@ldmartin-desk.jf.intel.com>
References: <20181010150916.4295-1-lucas.demarchi@intel.com>
 <87in29dj55.fsf@evledraar.gmail.com>
 <xmqqmurkgaap.fsf@gitster-ct.c.googlers.com>
 <20181023140710.GA7073@ldmartin-desk.jf.intel.com>
 <xmqqh8hcqeho.fsf@gitster-ct.c.googlers.com>
 <20181024024309.GA22379@ldmartin-desk.jf.intel.com>
 <xmqqtvlcnd1w.fsf@gitster-ct.c.googlers.com>
 <xmqqk1m7orbg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk1m7orbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 24, 2018 at 02:18:43PM +0900, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Lucas De Marchi <lucas.demarchi@intel.com> writes:
> >
> >> Your reply arrived just a little after I sent the v2, so I thought it
> >> was just the race and you would end up seeing the unread email in the
> >> same thread. Sorry for not including the msg id:
> >> 20181011081750.24240-1-lucas.demarchi@intel.com
> >
> > OK, then I am not surprised that I do not recall seeing such an old
> > message ;-)  Let me take a look.
> 
> Heh, it turns out that that is the version that has been queued in
> 'next' for about a week already.
> 
> One issue that was pointed out in v1 was that the log message was
> unclear; it seems v2 didn't address that at all, though.

ok, let me try to expand it.

thanks
Lucas De Marchi

> 
> Thanks.
> 
