From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: git-cvsexportcommit and commit date
Date: Sat, 02 Feb 2008 12:50:45 +1300
Message-ID: <47A3B055.2010804@catalyst.net.nz>
References: <OFEEDE9683.291E2C34-ON852573E2.00555C6A-852573E2.0055C505@db.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Derek Mahar <derek.mahar@db.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 02 00:51:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL5fH-0007ik-3I
	for gcvg-git-2@gmane.org; Sat, 02 Feb 2008 00:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbYBAXuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 18:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbYBAXuv
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 18:50:51 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:46371 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbYBAXuu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2008 18:50:50 -0500
Received: from 166-179-22-94.jamamobile.co.nz ([166.179.22.94])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JL5ef-0000T9-Uq; Sat, 02 Feb 2008 12:50:46 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <OFEEDE9683.291E2C34-ON852573E2.00555C6A-852573E2.0055C505@db.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72195>

Derek Mahar wrote:
> When committing a commit to CVS, does git-cvsexportcommit apply the Git 
> commit date to each new revision of every file in the CVS repository that 
> the commit touches?

It can't - CVS does not let you tell the server a commit timestamp.
It'll be the server's notion of "now" - so pray NTPd is in place and
running correctly.

git@vger CC'd as this is worth mentioning ;-)

cheers,


m

-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
