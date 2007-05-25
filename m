From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Fri, 25 May 2007 16:51:34 +0200
Message-ID: <200705251651.35234.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site> <200705251559.53846.Josef.Weidendorfer@gmx.de> <Pine.LNX.4.64.0705251514220.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>, skimo@liacs.nl,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 25 16:51:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hrb8p-0002Gh-QG
	for gcvg-git@gmane.org; Fri, 25 May 2007 16:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759708AbXEYOvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 25 May 2007 10:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759611AbXEYOvi
	(ORCPT <rfc822;git-outgoing>); Fri, 25 May 2007 10:51:38 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:60415 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759708AbXEYOvi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2007 10:51:38 -0400
Received: from dhcp-3s-55.lrr.in.tum.de (dhcp-3s-55.lrr.in.tum.de [131.159.35.55])
	by mail.in.tum.de (Postfix) with ESMTP id 379DB2803;
	Fri, 25 May 2007 16:51:36 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0705251514220.4648@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48386>

On Friday 25 May 2007, Johannes Schindelin wrote:
> On Fri, 25 May 2007, Josef Weidendorfer wrote:
> > * Submodules can appear/disappear any time in the superproject.
> > Therefore, going back in time can make it necessary to have to clone
> > a submodule you did not have before.
> > * Not every submodule is interesting for every developer; therefore,
> > an important design-decision for submodules is to allow at git-clone time
> > to not clone some submodules at all. However, you can change your mind and
> > want to follow a given submodule later.
> 
> Okay, so there are exceptions to the rule, just as everywhere.

The question here is in how many superprojects the exception
will become the rule, which would make manual overriding quite
cumbersome.

However, the exact policy for finding a fitting URL for a submodule
is not a fundamental design decision, and can be incrementally
improved, depending on use cases.

I agree with Junio that a simply, basic and robust submodule
implementation currently is important as first goal.

> We should not design for the exception. Therefore I think the .gitmodules, 
> overrideable by .git/config is sufficient.
> 
> And the point about my config being private still stands. You have no 
> business looking into my config.

I totally agree.

Josef
