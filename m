From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Sun, 19 Aug 2007 23:30:19 -0700
Message-ID: <7vveba90qs.fsf@gitster.siamese.dyndns.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net>
	<20070814231422.GA10662@pe.Belkin>
	<7vps1paceh.fsf@assigned-by-dhcp.cox.net>
	<46C90C46.1030000@midwinter.com>
	<20070820055221.GA22993@coredump.intra.peff.net>
	<20070820060522.GA27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Steven Grimm <koreth@midwinter.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0mY-0002Db-8r
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbXHTGab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbXHTGaa
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:30:30 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:54136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbXHTGaa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:30:30 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A5A3A1248C6;
	Mon, 20 Aug 2007 02:30:43 -0400 (EDT)
In-Reply-To: <20070820060522.GA27913@spearce.org> (Shawn O. Pearce's message
	of "Mon, 20 Aug 2007 02:05:22 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56177>

"Shawn O. Pearce" <spearce@spearce.org> writes:

>> Am I the only one who messes this up? If not, patch is below.
>
> Maybe.  ;-)
>
> I've memorized it long long ago.  But my coworkers haven't and always
> get it wrong, and look at me funny when I tell them "trust me, your
> data is in stage 2 and theirs is in stage 3...  because that's the
> convention all of the tools you are using follows".

I am not _opposed_ to :ours:$path syntax, but I suspect there is
something else that is wrong if you need to use :$n:$path syntax
that often.

I have never been in a situation I had to say :base:$path,
unless I am debugging the merge driver.  So it is between :ours:$path
and :theirs:$path.

But aren't they by definition HEAD:$path and MERGE_HEAD:$path,
which are far more descriptive?
