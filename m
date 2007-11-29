From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 28 Nov 2007 20:06:06 -0500
Message-ID: <20071129010606.GA5856@fieldses.org>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <alpine.LFD.0.99999.0711270917580.9605@xanadu.home> <20071127150829.GB3853@fieldses.org> <alpine.LFD.0.99999.0711271013310.9605@xanadu.home> <20071127153411.GA11731@fieldses.org> <alpine.LFD.0.99999.0711271047590.9605@xanadu.home> <20071127164243.GE11731@fieldses.org> <alpine.LFD.0.99999.0711271155250.9605@xanadu.home> <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 02:07:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxXrV-0001Cm-BV
	for gcvg-git-2@gmane.org; Thu, 29 Nov 2007 02:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760619AbXK2BGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 20:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759679AbXK2BGW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 20:06:22 -0500
Received: from mail.fieldses.org ([66.93.2.214]:59435 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756857AbXK2BGV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 20:06:21 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1IxXqw-0001f1-FW; Wed, 28 Nov 2007 20:06:06 -0500
Content-Disposition: inline
In-Reply-To: <7vlk8hzx0g.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66486>

On Wed, Nov 28, 2007 at 05:00:15PM -0800, Junio C Hamano wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > ...  In all the tutorials for $job I've done so 
> > far, I simply never talk about pull nor clone, but rather about init, 
> > "git remote", fetch and merge, with explicit and meaningful branch 
> > names.  I think that basic commands, even if there is a bit more of 
> > them, make Git easier to learn and understand than talking about those 
> > magic meta commands hiding the truth away.
> 
> That's actually a quite interesting approach for teaching.
> 
> The original "tutorial" (now core-tutorial) was similar in spirit; it
> built the user experience by starting at sequence of low level commands,
> and then finally said "since this is so often used combination, there is
> a short-hand for it that does all".  I think the approach would work
> quite well for people who want to use the tool with deep understanding.

Yeah.  I considered doing the above some time ago and ran into some
differences between git-clone and "git init && git remote add && git
fetch"--I think it may have just been that the latter didn't guess the
HEAD in the same way.  That's fixed now, right?  Is there any other
difference people would run into?  If not, I'll work on that.  I
wouldn't want to break things down quite as far as the core-tutorial,
but this particular thing is so simple....

--b.
