From: Jeremy White <jwhite@codeweavers.com>
Subject: Status of Thunderbird work
Date: Thu, 12 Feb 2009 10:09:04 -0600
Message-ID: <499449A0.4060002@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 17:10:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXe96-0004o1-9y
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 17:10:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756181AbZBLQJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 11:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754487AbZBLQJI
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 11:09:08 -0500
Received: from mail.codeweavers.com ([216.251.189.131]:51156 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbZBLQJH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 11:09:07 -0500
Received: from localhost
	([127.0.0.1] helo=[216.251.189.140] ident=stunnel4)
	by mail.codeweavers.com with esmtp (Exim 4.63)
	(envelope-from <jwhite@codeweavers.com>)
	id 1LXe7e-0002ro-KB
	for git@vger.kernel.org; Thu, 12 Feb 2009 10:09:06 -0600
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109627>

Okay, I am now done with the due diligence I felt I had to do as
penance for sending 14 wrapped and flowed patches to the wine-devel
mailing list :-/.

To summarize, I have:
  1.  Submitted a patch that,imho, improves the git documentation
      on this subject.
  2.  Revised a Mozillazine KB Entry to hopefully help others:
      http://kb.mozillazine.org/Plain_text_e-mail_-_Thunderbird#Completely_plain_email
  3.  Submitted a patch that implements Ben's suggestion to use <pre>
      and ctype of html to trick Thunderbird into doing the right thing.
  4.  Submitted a patch to allow attach to be the default for git-format-patch.

I am not wedded to #3 and #4; in fact, I'm about to go revise the Wine Git
instructions to make it clear that --attach is a last resort, and not a preferred
choice (the current Wine Wiki makes --attach look more preferable than it really is).

If the html patch went in, I would use it, chortling with evil glee
each time I did so.

Additionally, Dscho has written a Thunderbird extension to facilitate
sending patches.  That doesn't fit my ideal flow (I'm actually quite fond
of git-imap-send :-/), but Michael Gruber seemed interested and he and
Dscho may take it somewhere.

Finally, Michael also communicated in a private email that he may
consider some sort of rethink around git-send-email and git-imap-send,
which sounded intriguing to me, but way past my fair penance.

Now to go send some more sick and twisted patches to wine-devel... <grin>.

Cheers,

Jeremy

p.s.  My apologies for the duplicate patch #1; I thought the from @winehq.org
email wasn't going through, and resent from my subscribed email.  I would
like to sing the praises of list moderators everywhere.
