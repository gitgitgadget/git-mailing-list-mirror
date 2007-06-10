From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-submodule: allow submodule name and path to differ
Date: Sun, 10 Jun 2007 01:23:10 -0700
Message-ID: <7vps448bgx.fsf@assigned-by-dhcp.cox.net>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	<1181425132294-git-send-email-hjemli@gmail.com>
	<7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0706100820560.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:23:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIhe-0002a4-Sa
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762455AbXFJIXN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762550AbXFJIXN
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:23:13 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37029 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762337AbXFJIXM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:23:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070610082311.XAW29545.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 10 Jun 2007 04:23:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 9kPA1X00H1kojtg0000000; Sun, 10 Jun 2007 04:23:11 -0400
In-Reply-To: <Pine.LNX.4.64.0706100820560.4059@racer.site> (Johannes
	Schindelin's message of "Sun, 10 Jun 2007 08:25:43 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49673>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 9 Jun 2007, Junio C Hamano wrote:
>
>> Lars Hjemli <hjemli@gmail.com> writes:
>> 
>> > This teaches git-submodule to check module.*.path when looking for the 
>> > config for a submodule path. If no match is found it falls back to the 
>> > current behaviour (module.$path).
>> 
>> I have a feeling that it might be much less troublesome in the longer 
>> term to admit that module.$path was a mistake and support only one 
>> format; wouldn't trying to support both leave ambiguity and confusion?
>
> Just my 2cents: git-submodule is not yet in any released version. So let's 
> fix things early. In our world, it's not like you lose face when you have 
> to admit mistakes. (Instead, you lose face when you refuse to fix them.) 
> Ah, if only politics learnt from our world...

Well, I completely agree with what you said up to "So let's fix
things early.", but when I re-read what I wrote, I realize that
my wording was bad --- I did not mean to drive the discussion in
that direction.

It was not Lars's *mistake* to admit to begin with.  His was one
valid design that was consistent within his patch series.  The
thing is that there just was a better alternative suggested
later; it does not make the first iteration a mistake in any
way.

So, Lars, my apologies if I offended you -- I did not mean it
that way.
