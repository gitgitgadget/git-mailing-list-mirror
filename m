From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] graph API: fix extra space during pre_commit_line state
Date: Wed, 22 Apr 2009 06:25:33 +0300
Message-ID: <87y6tt2wuq.fsf@iki.fi>
References: <87zlea9lit.fsf_-_@iki.fi> <20090421183412.GA8499@linux.vnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 05:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwT7M-0004xG-9x
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 05:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbZDVDZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 23:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbZDVDZv
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 23:25:51 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:39118 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754001AbZDVDZv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 23:25:51 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 49CA1EE50125DC47; Wed, 22 Apr 2009 06:25:48 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LwT5Z-0000x9-BQ; Wed, 22 Apr 2009 06:25:33 +0300
In-Reply-To: <20090421183412.GA8499@linux.vnet> (Allan Caffee's message of "Tue\, 21 Apr 2009 14\:34\:12 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117166>

On 2009-04-21 14:34 (-0400), Allan Caffee wrote:

> An extra space is being inserted between the "commit" column and all of
> the successive edges.  Remove this space.  This regression was
> introduced by 427fc5b.
>
> Signed-off-by: Allan Caffee <allan.caffee@gmail.com>

Looks like it's working now, thanks. Let's Cc to Junio so that he
doesn't miss the fix.

> This issue exposes a gap in the existing test coverage, which doesn't
> exercise the pre_commit_line code.  Maybe another patch is in order to
> extend t4202-log to cover pre-commit lines and octopus merges.

I think that's a good idea. I like "log --graph" very much and when
someone alters that part of the code I run my own visual "test suites"
to notice if my pet feature has been broken. :-) Automatic tests would
be helpful.
