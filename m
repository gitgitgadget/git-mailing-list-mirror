Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2458C1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 22:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfKBWuu (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 18:50:50 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:50541 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfKBWuu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 18:50:50 -0400
X-Originating-IP: 1.186.12.57
Received: from localhost (unknown [1.186.12.57])
        (Authenticated sender: me@yadavpratyush.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B27CCE0002;
        Sat,  2 Nov 2019 22:50:47 +0000 (UTC)
Date:   Sun, 3 Nov 2019 04:20:45 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-shortlog.txt: mention commit filtering options
Message-ID: <20191102225045.zxxomy357zctxhfh@yadavpratyush.com>
References: <20191030203603.27497-1-me@yadavpratyush.com>
 <xmqqftj64yv2.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqftj64yv2.fsf@gitster-ct.c.googlers.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/11/19 02:43PM, Junio C Hamano wrote:
> Pratyush Yadav <me@yadavpratyush.com> writes:
> 
> > git-shortlog, like git-log, supports options to filter what commits are
> > used to generate the log. These options come from git-rev-list. Add a
> > pointer to these options in the documentation page so readers can know
> > these filtering options can be used with git-shortlog too.
> >
> > Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
> > ---
> > Since [0] didn't get any responses, I figured a patch might get some
> > more attention since it is something concrete to comment on.
> >
> > [0] https://public-inbox.org/git/20191024191709.gqkjljuibyashtma@yadavpratyush.com/
> >
> >  Documentation/git-shortlog.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
> > index bc80905a8a..acae695388 100644
> > --- a/Documentation/git-shortlog.txt
> > +++ b/Documentation/git-shortlog.txt
> > @@ -76,6 +76,11 @@ them.
> >  Paths may need to be prefixed with `--` to separate them from
> >  options or the revision range, when confusion arises.
> >
> > +In addition to the options above, 'git shortlog' also supports a range of
> > +options to select which subset of commits will be used to generate the
> > +shortlog. A list of these options can be found in the "Commit Limiting"
> > +section of linkgit:git-rev-list[1].
> 
> How does "git log --help" handle the corresponding part of its
> documentation?  
> 
> 	... goes and looks ...
> 
> I wonder if it is better to just include rev-list-options.txt like
> "git-log.txt" does, instead of adding these four lines?

Quoting from my initial email [0] about this topic:

  rev-list-options.txt is a rather large file and I'm not sure if 
  including it in both git-log and git-shortlog would be a good idea. 
  The way I see it, git-log is the "primary" log interface, and 
  git-shortlog is a "secondary" log interface, so git-log warrants such 
  a large man page, but git-shortlog doesn't especially since most 
  options are repeated. So maybe it is a better idea to just include a 
  pointer to git-rev-list in the shortlog man page. 

But if you think including the whole thing is better, I don't mind that 
either. Will re-roll.

[0] https://public-inbox.org/git/20191024191709.gqkjljuibyashtma@yadavpratyush.com/

-- 
Regards,
Pratyush Yadav
