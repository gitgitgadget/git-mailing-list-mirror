From: Alex Vandiver <alex@chmrr.net>
Subject: Re: [spf:guess] Re: [PATCH 2/5] git-svn: Make merge metadata accessible to make_log_entry
Date: Sat, 05 Dec 2009 18:10:10 -0500
Message-ID: <1260054349-sup-9732@utwig>
References: <1259780874-14706-1-git-send-email-alex@chmrr.net> <1259780874-14706-3-git-send-email-alex@chmrr.net> <1259786690-sup-8337@utwig> <20091205223241.GB2120@dcvr.yhbt.net> <1260052934-sup-9563@utwig> <1260053972.22680.5.camel@denix>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sun Dec 06 00:10:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NH3lt-0004aW-UA
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 00:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758004AbZLEXKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 18:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757927AbZLEXKF
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 18:10:05 -0500
Received: from chmrr.net ([209.67.253.66]:42438 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757903AbZLEXKE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 18:10:04 -0500
Received: from chmrr by utwig.chmrr.net with local (Exim 4.69)
	(envelope-from <chmrr@chmrr.net>)
	id 1NH3lS-0006yw-1l; Sat, 05 Dec 2009 18:10:10 -0500
In-reply-to: <1260053972.22680.5.camel@denix>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134636>

At Sat Dec 05 17:59:32 -0500 2009, Sam Vilain wrote:
> Hi, I've just seen the series, looks like a good idea.  Just a couple of
> questions then I'll review the code;
> 
>  - when a change is merged upstream with svk, you will get multiple log
> entries in a single commit message.  What do you do with commits like
> that?

If the user edited the merge message and supplied their own message,
nothing.  If the first line is an SVK merge line, it inserts a message
"Merged from /svn/path/to/trunk:12345\n\n" at the top.

>  - there are quite a few repos which will have empty commits (ie, no
> changes), but with one or more of the above log entries, owing to a bug
> which I can't seem to find the details of right now..  how might those
> appear?

Without seeing an example, I'm not sure offhand -- but what you're
describing does ring a bell, so I'm sure I've seen the mismerges
you're talking about as well.
 - Alex
-- 
Networking -- only one letter away from not working
