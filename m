From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 28 Nov 2007 17:00:15 -0800
Message-ID: <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com>
	<Pine.LNX.4.64.0711271109130.27959@racer.site>
	<alpine.LFD.0.99999.0711270917580.9605@xanadu.home>
	<20071127150829.GB3853@fieldses.org>
	<alpine.LFD.0.99999.0711271013310.9605@xanadu.home>
	<20071127153411.GA11731@fieldses.org>
	<alpine.LFD.0.99999.0711271047590.9605@xanadu.home>
	<20071127164243.GE11731@fieldses.org>
	<alpine.LFD.0.99999.0711271155250.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:01:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXlp-0007qF-RZ
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:00:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758503AbXK2BA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759455AbXK2BA0
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:00:26 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54680 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818AbXK2BAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:00:25 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id BD9FC2FA;
	Wed, 28 Nov 2007 20:00:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0A9D99AAE7;
	Wed, 28 Nov 2007 20:00:38 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66482>

Nicolas Pitre <nico@cam.org> writes:

> ...  In all the tutorials for $job I've done so 
> far, I simply never talk about pull nor clone, but rather about init, 
> "git remote", fetch and merge, with explicit and meaningful branch 
> names.  I think that basic commands, even if there is a bit more of 
> them, make Git easier to learn and understand than talking about those 
> magic meta commands hiding the truth away.

That's actually a quite interesting approach for teaching.

The original "tutorial" (now core-tutorial) was similar in spirit; it
built the user experience by starting at sequence of low level commands,
and then finally said "since this is so often used combination, there is
a short-hand for it that does all".  I think the approach would work
quite well for people who want to use the tool with deep understanding.

However, I am not so sure about people who just want canned set of
instructions and follow them blindly to get their work done.  And I do
not think the latter classes of users are necessarily wrong.

Such a canned set of instructions would (if the project that supplies
the cheat-sheet encourages merges instead of rebases) talk about "clone
then commit then push then pull and repeat", without mentioning what
pull does is fetch+merge nor what fetch means and what merge means, and
that would let people get started without deeper understanding.

But the lack of deeper understanding would hurt them in the longer run
(e.g. "my push was rejected with something called non-fast-forward ---
what does that mean and what would I do now?").  
