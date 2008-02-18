From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsexportcommit: be graceful when "cvs status" reorders
 the arguments
Date: Tue, 19 Feb 2008 04:25:08 +1300
Message-ID: <47B9A354.7070905@catalyst.net.nz>
References: <alpine.LSU.1.00.0802180127100.30505@racer.site> <7vbq6fvudp.fsf@gitster.siamese.dyndns.org> <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Robin Rosenberg <robin.rosenberg@dewire.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 17:09:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR8Ym-0005OO-I3
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 17:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519AbYBRQJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 11:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754448AbYBRQJE
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 11:09:04 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:44774 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753039AbYBRQJC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 11:09:02 -0500
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[127.0.0.1])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JR8Xp-0001hQ-Bs; Tue, 19 Feb 2008 05:08:41 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <7vwsp3uf0u.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74305>

Junio C Hamano wrote:
> A related naming guideline I failed to follow (because I was
> mostly copying your code) suggests that the hash here should be
> named %fullname, instead of %basename.  Then logically:

Double ACK on your logic and arguments - I was thinking "fullname" as I
read your first email. Not sure how stable the output is across CVS
versions/ports WRT leading slashes, might be a good idea to try to
canonicalise the paths.

I am travelling at the moment, but I'll try and review the patch with
the actual code. Some of the ugliness you're complaining about might be
mine (plurals, and perhaps even the $#array) but I refuse to recognise
the grep as mine.

Annotate might still put me to shame - perhaps I was drunk?

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
