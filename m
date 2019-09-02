Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD5981F461
	for <e@80x24.org>; Mon,  2 Sep 2019 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfIBSxZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Sep 2019 14:53:25 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39901 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfIBSxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Sep 2019 14:53:25 -0400
X-Originating-IP: 1.186.12.26
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 75B641C0005;
        Mon,  2 Sep 2019 18:53:23 +0000 (UTC)
Date:   Tue, 3 Sep 2019 00:23:21 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] [PATCH] git-gui: Add hotkeys to set widget focus
Message-ID: <20190902185321.m76dffzfc76astar@yadavpratyush.com>
References: <CAKPyHN2_CpaJahKo2Ju2SWvU=Y79k2ArKVkkxPTbeW1t2TYRZQ@mail.gmail.com>
 <20190901193652.21086-1-birger.sp@gmail.com>
 <20190902181954.zcxuyqrdzs3dzjtq@yadavpratyush.com>
 <CAGr--=L64jiE=x_McdfWJuQTz1Qo3wp0nc8xaeKBGe0GgW5Kxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=L64jiE=x_McdfWJuQTz1Qo3wp0nc8xaeKBGe0GgW5Kxg@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/09/19 08:35PM, Birger Skogeng Pedersen wrote:
> On Mon, Sep 2, 2019 at 8:19 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > You missed removing this extra blank line. Will fix it up locally.
> >
> > > +             set _index $file_lists_last_clicked($widget)
> > [snip]
> 
> 
> To be honest I felt the blank line there was appropriate, in an
> attempt to follow the same code style as the rest of the git-gui.sh.
> For instance, the "add_range_to_selection" function
> (https://github.com/prati0100/git-gui/blob/master/git-gui.sh#L2601-L2625)
> has blank lines like this;
 
Oh yes, these types of blank lines are perfectly fine in my opinion too.  
I actually prefer this alternative over not having any spacing at all.  
This way you divide the function in logical sections/steps.

But that was not what I pointed out. The blank line I pointed out was 
like this:

  if {condition} {
  	
	foo
	bar
  }

My nitpick was with the blank line _just after_ the if.

> 
> proc add_range_to_selection {w x y} {
>     global file_lists last_clicked selected_paths
> 

So in this example, the above blank line is fine...

>     if {[lindex $last_clicked 0] ne $w} {

...but if I add a blank line here like:

  if {[lindex $last_clicked 0] ne $w} {

	toggle_or_diff click $w $x $y
	return
  }

instead of like:

  if {[lindex $last_clicked 0] ne $w} {
	toggle_or_diff click $w $x $y
	return
  }

It is the blank line just after the start of your if statement that I 
was pointing out. I did leave other blank lines untouched in your patch.

[snip]

-- 
Regards,
Pratyush Yadav
