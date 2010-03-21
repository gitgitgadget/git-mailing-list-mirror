From: Benjamin Meyer <ben@meyerhome.net>
Subject: Re: [PATCH] use -q instead of redirect to /dev/null for git update-index
Date: Sun, 21 Mar 2010 13:02:29 -0400
Message-ID: <70E4FE83-0DC9-4AF1-BA20-BE6467FC8D07@meyerhome.net>
References: <1269168827-18694-1-git-send-email-romain@peerfuse.org> <7vy6hlvmoy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun Mar 21 18:08:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtOdj-0008Fg-2p
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 18:08:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab0CURIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 13:08:25 -0400
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:41046
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750799Ab0CURIY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 13:08:24 -0400
X-Greylist: delayed 353 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Mar 2010 13:08:24 EDT
Received: from omta11.westchester.pa.mail.comcast.net ([76.96.62.36])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id vsAX1d0060mv7h057t2XKH; Sun, 21 Mar 2010 17:02:31 +0000
Received: from [192.168.3.101] ([71.192.50.29])
	by omta11.westchester.pa.mail.comcast.net with comcast
	id vt2W1d00J0dnthT3Xt2Xqp; Sun, 21 Mar 2010 17:02:31 +0000
In-Reply-To: <7vy6hlvmoy.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142835>

> The above can be said to other "/dev/null to -q" patches we saw on the
> list recently.  The saddest part of the story is that, the review cost
> (not necessarily spent by me, but time spent by other people reviewing
> patches is precious) is paid only to prevent a breakage like this patch
> tries to introduce from getting accepted, without much potential reward.
> Even if some of those patches turn out to be harmless, the only thing we
> would have bought with the cost of reviewing is that we made sure that the
> system would continue to work as before, but that is what we could have
> easily done by not even looking at the patches at all.

For what it is worth I got the task from the Git Janitor wiki page.  https://git.wiki.kernel.org/index.php/Janitor

Sorry I didn't include that in my changelog.

-Benjamin Meyer
