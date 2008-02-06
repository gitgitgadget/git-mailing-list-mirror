From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: git-cvsexportcommit and commit date
Date: Thu, 07 Feb 2008 08:51:52 +1300
Message-ID: <47AA0FD8.1050801@catalyst.net.nz>
References: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Derek Mahar <derek.mahar@db.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:53:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqJs-0004B1-77
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:52:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755014AbYBFTv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755344AbYBFTv5
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:51:57 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:51026 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbYBFTv4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:51:56 -0500
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.94])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JMqJE-0005cn-Sr; Thu, 07 Feb 2008 08:51:52 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <OFFF18703C.5539A99A-ON852573E7.00699FE4-852573E7.006A0F3E@db.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72835>

Derek Mahar wrote:
> Thank you.  You've pointed out another good reason to dislike (or 
> despise?) CVS.  I feel very unfortunate that I must still use CVS.  Makes 
> me even miss Perforce.  git-cvsexportcommit certainly helps, but the fact 
> that it cannot require CVS to preserve the original Git timestamps means 
> that in order to make the commit times between Git and CVS roughly the 
> same, I'll have to commit to both Git an CVS at the same time.  Is this 
> how you usually work with git-cvsexportcommit?

I just don't worry about the timestamps ;-)

I normally track the Moodle CVS tree, and do all my "new feature" and
"client customization" branches in git. The feature branches I rebase
aggressively, until they are ready to be "landed" in CVS. It is in that
"landing in cvs" that I use cvsexportcommit, usually with a long list of
commits!

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
