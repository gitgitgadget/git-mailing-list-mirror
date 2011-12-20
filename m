From: Nathan Panike <nwp@cs.wisc.edu>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Tue, 20 Dec 2011 16:50:15 -0600
Message-ID: <20111220225014.GD21353@llunet.cs.wisc.edu>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <87k45qriu2.fsf@thomas.inf.ethz.ch>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Dec 20 23:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd8Vv-0000nl-Tg
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 23:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231Ab1LTWuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 17:50:23 -0500
Received: from llunet.cs.wisc.edu ([128.105.175.76]:52591 "EHLO
	llunet.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1LTWuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 17:50:21 -0500
Received: from llunet.cs.wisc.edu (localhost [127.0.0.1])
	by llunet.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id pBKMoGxS014696;
	Tue, 20 Dec 2011 16:50:16 -0600
Received: (from nwp@localhost)
	by llunet.cs.wisc.edu (8.14.1/8.14.1/Submit) id pBKMoFTb014695;
	Tue, 20 Dec 2011 16:50:15 -0600
Content-Disposition: inline
In-Reply-To: <87k45qriu2.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187534>

On Tue, Dec 20, 2011 at 11:15:01PM +0100, Thomas Rast wrote:
> "Nathan W. Panike" <nathan.panike@gmail.com> writes:
> 
> > This is useful when one is working on a system where the pager is lousy.
> 
> I'm curious.  Are you saying your less does not have -S (or you do not
> even have less), or do you have a reason not to use it?
> 
> -- 
> Thomas Rast
> trast@{inf,student}.ethz.ch

The reason I thought of this initially was that I have a bot reporting commits
at $dayjob in an IRC channel. Since some of my colleagues commit with long
subject lines, I thought of this as a way to control the output of the bot
(e.g., by controlling the bot's input).

Nathan Panike
