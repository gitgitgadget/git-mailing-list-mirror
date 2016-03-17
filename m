From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 01:32:41 -0400
Message-ID: <CAPig+cSmQpt3u+1PPFD6CP9TF58R6NR=KCgC1dik9U=deaeCkA@mail.gmail.com>
References: <CAFZEwPPd2wFqFq2LFEzN2CzhTV6C420SLPcXi1SWE=z2epOYLw@mail.gmail.com>
	<20160316204912.GA1890@sigill.intra.peff.net>
	<CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
	<20160316212308.GA4538@sigill.intra.peff.net>
	<CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
	<20160316214442.GC4441@sigill.intra.peff.net>
	<CAGZ79kbbAv=PukD+sftmoO8u3GX=S1YCYGV8zcNMxrZ+E41-UA@mail.gmail.com>
	<20160316231626.GA11808@sigill.intra.peff.net>
	<CAGZ79kYVT0cq8XgruZ+i_gGuSDySE+s3POU95PXyra9DwVGLkQ@mail.gmail.com>
	<20160317014310.GA12830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 06:33:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agQYX-0002Se-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 06:33:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540AbcCQFcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 01:32:43 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35987 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbcCQFcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 01:32:42 -0400
Received: by mail-vk0-f41.google.com with SMTP id c3so89250462vkb.3
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 22:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=CgrAvTZFzQub9WM5+DrYk8Uj5ie5OBsqBSngMFl7lX0=;
        b=YTl5JtmAyv2A8H3HJfwyLuILe0CG1MazG8ez0ZOO7j5XoCTSATcGX8UAMRDnqQcGul
         LJOJEanz+igF9tPmpFdhIIcCKeGiWrvEQ93AhTJ3OJbAXro8+Hm8FVq3zsCtZwJ7S5v7
         BIKI/Sl2b7fB/qw9JvKaWNCaTsk21mI62FMjMXI/wSnqgNvjD8hTC3S9W0UKhFNsOI48
         iTc3wLw9Lyd+Y6I/Yozq8OD2rWMTyELnW3WE1ViawqdM7XL2LYP9x3wnPjUFKJpe2/2C
         6sjG3EzxGCYteH2PCq8Oespnj18yYZgoImoKVV5AmEZ/3dV8yT++sePfg7CbWaJ1tKFc
         XlMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=CgrAvTZFzQub9WM5+DrYk8Uj5ie5OBsqBSngMFl7lX0=;
        b=N8/2Q2Nu2BjF3TReQgepx+RXOgGc2ChwdVqoFIIp0bJhjLRCbsVA++jnMRfmIq3K2q
         SIYhuqmazxvD9VzybjrPtbts7JOEM2BPl+SI/0P5LLcbQ3/t7OKppilToGL6jRTMlRNq
         WQT4LSBN5+ngQmGKYV3wPzuY4KIlqlQyhYzWoTGrpJEBGnvwHKkBixoxCW1xugaG7Wev
         uLMxHMMIBzs92/lQjNryr9scs/4vKKEam5pjo6/TTjzsuY5M7xg9oZagAeysHmVqOEYj
         SA0FiaVIU+w8isDWSt/mdXXtNFDQ/omaiMXjgFAnOrL3f9zOtotwfy9cd2pGyLKl1m1M
         ev8A==
X-Gm-Message-State: AD7BkJL1pmCUdH/dOPf/RPBxbxBfYoivKpv7inZFV5jrpiLOQ9qfEN0ag1qeyExxAhPBeYV9IkLzzV6yNBTaiw==
X-Received: by 10.31.182.143 with SMTP id g137mr9312285vkf.45.1458192761672;
 Wed, 16 Mar 2016 22:32:41 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Wed, 16 Mar 2016 22:32:41 -0700 (PDT)
In-Reply-To: <20160317014310.GA12830@sigill.intra.peff.net>
X-Google-Sender-Auth: uv2soWrYXA4QvrE24sDeEuS7c4E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289074>

On Wed, Mar 16, 2016 at 9:43 PM, Jeff King <peff@peff.net> wrote:
> Arguably cmd_commit() should be using OPT_BOOL instead of OPT__VERBOSE,
> as there is no such thing as "verbose > 1" here. But I don't think there
> is any real user-facing consequence of that (however, given Eric's
> suggestion, I suspect it would make Pranit's problem just go away, as it
> assigns rather than increments; IOW, it does the thing Eric was
> suggestion OPT__VERBOSE to do).

Actually, Pranit's previous version of the patch did treat verbosity
as a boolean, but then SZEDER pointed out this bit from
git-commit.txt:

    --verbose::
        ...
        If specified twice, show in addition the unified diff between
        what would be committed and the worktree files, i.e. the unstaged
        changes to tracked files.

which is what led us to the current discussion about wanting an
"unspecified" value for OPT__VERBOSE.
