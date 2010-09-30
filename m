From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: Re: [PATCH 00/16] git-send-email cleanups
Date: Thu, 30 Sep 2010 11:15:19 -0400
Message-ID: <7703AA30-C1A1-455D-9856-022588EF00B4@gernhardtsoftware.com>
References: <1285854189-10240-1-git-send-email-avarab@gmail.com> <18E0A903-D625-4C7A-A575-AC5C5EF448C9@gernhardtsoftware.com> <20100930145218.GB32728@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ryan Anderson <rda@google.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:17:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1KsW-00051l-2U
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654Ab0I3PP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:15:26 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:43142 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756646Ab0I3PP0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 11:15:26 -0400
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 854B21FFC6B6; Thu, 30 Sep 2010 15:15:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 1D3D11FFC544;
	Thu, 30 Sep 2010 15:15:18 +0000 (UTC)
In-Reply-To: <20100930145218.GB32728@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157680>


On Sep 30, 2010, at 10:52 AM, Jeff King wrote:

> They don't necessarily do what you want:
> 
>  perl -e 'sub want_scalar($) { print "got $_[0]\n" }
>           want_scalar("ok");
>           my @a = qw(totally broken);
>           want_scalar(@a);
>  '
> 
> I get:
> 
>  got ok
>  got 2
> 
> And using "sub want_list(@)" basically does nothing at all (you can pass
> nothing, a scalar, or a list).

I'm not surprised by that at all, but I've spent too much time in scripting languages recently.

> For more details, read:
> 
> http://www.perlmonks.org/?node_id=861966
> 
> (If you're impatient, skip to the section "Problems with Regular
> Prototypes").

Huh.  Somewhere along the way I had picked up using prototypes as a solution to some problem and got used to them.  Interesting to see the full discussion why you shouldn't.  I guess I'm reading too much Ruby and Perl6 and didn't think about how that would work with Perl5.

~~ Brian
