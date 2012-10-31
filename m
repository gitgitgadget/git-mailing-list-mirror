From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Tue, 30 Oct 2012 18:51:03 -0700
Message-ID: <20121031015103.GA15167@elie.Belkin>
References: <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
 <CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
 <20121030214531.GN15167@elie.Belkin>
 <CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
 <20121030220717.GO15167@elie.Belkin>
 <CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
 <20121030235506.GT15167@elie.Belkin>
 <CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
 <20121031010823.GX15167@elie.Belkin>
 <CAMP44s0RcbAiUmvGACxO+H-b-anQSPXxUqUuZwYRKWfrpXYeew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 02:51:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNSr-0002Yf-3S
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 02:51:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933073Ab2JaBvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 21:51:15 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:58647 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932421Ab2JaBvO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 21:51:14 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so589582pad.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 18:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=J4pP+ML7wEgZqNtiErSRMDGIddZqVlUzcv2vcBllbrc=;
        b=JUyDENKb40azQCRevUkLUEC1HWLLYfXSpUBX2p2XlZ88snHSd1OufkVmAoFBy7NaXV
         IFQlB4vlI02nHAfdwVhH1YRXido8x10AAKddv5y09cP8JL5ONJ4SQ0fUtRK5SBXREB5D
         Lq7u9T2eFj3O47csfdzFvj04EcOIcqjg9aqP+5Rrerq8o111XLmIRqrS0sDjmQ2hFjHj
         39DKN7vzAXo2E6PHxGPCmUJ4RBys5tgmOvuy7gT1bWns7ShmwWhkLWHnanUZoj4gnsA8
         q+/7bLB+yoH/qVnkZQGuDu9Kj/UENuwV7q/j6/FzqkPYXAfoBwpl1EYOH9aRDW2alYBA
         6W3A==
Received: by 10.68.233.196 with SMTP id ty4mr109014336pbc.23.1351648274010;
        Tue, 30 Oct 2012 18:51:14 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id vc2sm1410131pbc.64.2012.10.30.18.51.12
        (version=SSLv3 cipher=OTHER);
        Tue, 30 Oct 2012 18:51:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s0RcbAiUmvGACxO+H-b-anQSPXxUqUuZwYRKWfrpXYeew@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208782>

Felipe Contreras wrote:

>                                                    It's not my job to
> explain to you that 'git fast-export' doesn't work this way, you have
> a command line to type those commands and see for yourself if they do
> what you think they do with a vanilla version of git. That's exactly
> what I did, to make sure I'm not using assumptions as basis  for
> arguing, it took me a few minutes.

Well no, when I run "git blame" 10 years down the line and do not
understand what your code is doing, it is not at all reasonable to
expect me to checkout the parent commit, get it to compile with a
modern toolchain, and type those commands for myself.

Instead, the commit message should be self-contained and explain what
the patch does.

That has multiple parts:

 - first, what the current behavior is

 - second, what the intent behind the current behavior is.  This is
   crucial information because presumably we want the change not to
   break that.

 - third, what change the patch makes

 - fourth, what the consequences of that are, in terms of new use
   cases that become possible and old use cases that become less
   convenient

 - fifth, optionally, how the need for this change was discovered
   (real-life usage, code inspection, or something else)

 - sixth, optionally, implementation considerations and alternate
   approaches that were discarded

If you run "git log", you'll see many good and bad examples to think
over and compare to this goal.  It's hard work to describe one's work
well in terms that other people can understand, but I think it can be
satisfying, and in any event, it's just as necessary as including
comments near confusing code.

Sincerely,
Jonathan
