From: Bill Lear <rael@zopyra.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 13:12:08 -0500
Message-ID: <18032.13176.649702.276044@lisa.zopyra.com>
References: <1HyUO6-04z4yG0@fwd28.aul.t-online.de>
	<18032.3836.710438.73912@lisa.zopyra.com>
	<Pine.LNX.4.64.0706131916270.5241@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1HyXX4-0004bt-EQ
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759149AbXFMSMS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759145AbXFMSMS
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:12:18 -0400
Received: from mail.zopyra.com ([65.68.225.25]:61477 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759132AbXFMSMR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:12:17 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id l5DICFP30022;
	Wed, 13 Jun 2007 13:12:15 -0500
In-Reply-To: <Pine.LNX.4.64.0706131916270.5241@castor.milkiway.cos>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50108>

On Wednesday, June 13, 2007 at 19:31:50 (+0200) Michael Dressel writes:
>Hi,
>
>but even if they just play with the code. Why not always commit?
>As long as they don't push nobody else will be affected.
>
>Even if you play with the code it's useful to go back to earlier 
>versions. Why would you not want to benefit from this possibility?
>
>So this would really only be two commands the commit and the pull command.
>
>I hope I didn't miss your point completely.

Not completely: they don't want to commit, as this will then "pollute"
the history in their working repository (which is just temporarily
being used to play with a new feature, idea, bug fix, optimization,
etc.).  This pollution with a handful of garbage would then have to be
undone were they to say "ok, that's really not a good idea".  If a
pull into a dirty tree were possible, that last step could be just a
simple reset, or continuing to explore with the code, etc.

Their benchmark is CVS: CVS lets them do this easily (and yes, I
understand that CVS sucks compared to git, so don't even start), and
so even if they have to have 2 commands to do what they did in CVS
with 1, they complain.  My job is to either justify what git does to
them to shut them up, or to speak to the git community to see if their
desires are remotely rational.

It seems to me, based on several posts here, particularly Junio's,
that they are being remotely rational and it might be a reasonable
addition to git to be able to say "git pull --dirty" or whatever...


Bill
