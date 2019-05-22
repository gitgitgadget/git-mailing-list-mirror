Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F451F462
	for <e@80x24.org>; Wed, 22 May 2019 06:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfEVGTf (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 02:19:35 -0400
Received: from buzz.no-dns-yet.org.uk ([81.187.49.251]:36148 "EHLO
        buzz.no-dns-yet.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfEVGTf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 02:19:35 -0400
Received: from simon by buzz.no-dns-yet.org.uk with local (Exim 4.90_1)
        (envelope-from <simon@no-dns-yet.org.uk>)
        id 1hTKb7-0001OI-8A; Wed, 22 May 2019 07:19:33 +0100
Date:   Wed, 22 May 2019 07:19:33 +0100
From:   Simon Williams <simon@no-dns-yet.org.uk>
To:     Luke Diamand <luke@diamand.org>
Cc:     Git Users <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-p4: Allow unshelving of branched files
Message-ID: <20190522061933.GA5224@buzz.no-dns-yet.org.uk>
References: <20190521225016.GA32526@buzz.no-dns-yet.org.uk>
 <CAE5ih7_FMCY9ZLyYoY2XmmaaSTQAiXSMMwC_j+kLzdKY4M=hRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5ih7_FMCY9ZLyYoY2XmmaaSTQAiXSMMwC_j+kLzdKY4M=hRw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 22, 2019 at 06:49:38AM +0100, Luke Diamand wrote:
> On Tue, 21 May 2019 at 23:50, Simon Williams <simon@no-dns-yet.org.uk> wrote:
> >
> > When unshelving a changelist, git-p4 tries to work out the appropriate
> > parent commit in a given branch (default: HEAD).  To do this, it looks
> > at the state of any pre-existing files in the target Perforce branch,
> > omiting files added in the shelved changelist.  Currently, only files
> > added (or move targets) are classed as new.  However, files integrated
> > from other branches (i.e. a 'branch' action) also need to be considered
> > as added, for this purpose.
> 
> Looks good to me!
> 
> "omiting" in the comment should perhaps be "omitting".

Thanks and good point.  I'll send the revised patch.


Regards,
-- 
Simon Williams <simon@no-dns-yet.org.uk>
PGP Key ID: 0xF4A23C69

