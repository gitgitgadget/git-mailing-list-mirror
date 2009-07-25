From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [PATCH 1/2] Make section_name_match start on '[', and return the length on success
Date: Sat, 25 Jul 2009 13:18:52 -0400
Message-ID: <1248542170-sup-4264@utwig>
References: <1248470504-16326-1-git-send-email-alex@chmrr.net> <1248470504-16326-2-git-send-email-alex@chmrr.net> <alpine.DEB.1.00.0907251605240.8306@pacific.mpi-cbg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:24:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUkzO-0005rF-OB
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 19:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbZGYRSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbZGYRSx
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 13:18:53 -0400
Received: from chmrr.net ([209.67.253.66]:43215 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750865AbZGYRSw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 13:18:52 -0400
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1MUktY-00032V-Co; Sat, 25 Jul 2009 13:18:52 -0400
In-reply-to: <alpine.DEB.1.00.0907251605240.8306@pacific.mpi-cbg.de>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124022>

At Sat Jul 25 10:09:56 -0400 2009, Johannes Schindelin wrote:
> Is this not unnecessary, given that we  only call that function when we 
> know that buf[0] == '[':

Yes.  However, given that I had changed the calling convention for the
code, (it used to be passed the string starting just _inside_ the
'['), I wanted to make the new calling convention clearer, and catch
any places that were using the old convention.

I'm happy to submit a new version without it, if you wish.

> I was a bit surprised that "offset" is not used further in your patch, but 
> I saw that 2/2 uses it.

Yeah, this hunk should probably have gone in 2/2 instead.
 - Alex
-- 
Networking -- only one letter away from not working
