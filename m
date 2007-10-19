From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Thu, 18 Oct 2007 21:57:15 -0400
Message-ID: <20071019015715.GW14735@spearce.org>
References: <c594999b2337.2337c594999b@nyroc.rr.com> <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: lmage11@twcny.rr.com, git@vger.kernel.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Fri Oct 19 03:57:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iih7M-0004N3-DC
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 03:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762699AbXJSB5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 21:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762669AbXJSB5U
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 21:57:20 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42443 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761799AbXJSB5T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 21:57:19 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Iih6k-0006zO-63; Thu, 18 Oct 2007 21:57:02 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A41CF20FBAE; Thu, 18 Oct 2007 21:57:15 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <D2EAAC6D-567D-454A-AECA-C90FA2C369AE@mit.edu>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61597>

Michael Witten <mfwitten@MIT.EDU> wrote:
> On 18 Oct 2007, at 11:47:32 AM, lmage11@twcny.rr.com wrote:
> 
> >I don't know exactly how git manages the index
> >internally, but a
> >shortcut for this would be to simply rename the index entry in place.
> 
> Seems like the shortcut would lose the history and confuse git.

No.  It wouldn't.  The index has no knowledge of history of anything.
For good reason.  Its strictly a mapping of file name to some basic
stat information (used to determine if the file has been modified
by the user or not) and the SHA-1 of the staged blob.  That's it.
No history.  The shortcut the original poster was asking about
wouldn't confuse Git one bit.
 
-- 
Shawn.
