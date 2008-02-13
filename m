From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [offtopic?] xdelta patch format wrapper
Date: Thu, 14 Feb 2008 06:53:11 +1300
Message-ID: <47B32E87.5080403@catalyst.net.nz>
References: <47B24D8A.5090703@catalyst.net.nz> <7vy79py1it.fsf@gitster.siamese.dyndns.org> <47B26830.6090501@catalyst.net.nz> <alpine.LSU.1.00.0802131128040.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 13 18:54:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPLoZ-0006rT-5C
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 18:54:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765715AbYBMRxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2008 12:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765604AbYBMRxb
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 12:53:31 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:57483 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765650AbYBMRx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2008 12:53:29 -0500
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.94])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <martin@catalyst.net.nz>)
	id 1JPLnD-0007lZ-Vd; Thu, 14 Feb 2008 06:53:12 +1300
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <alpine.LSU.1.00.0802131128040.30505@racer.site>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73805>

Johannes Schindelin wrote:
> > FWIW I just checked.  In msysGit, git-apply.exe and git-diff.exe are
> > identical (no mystery there: they are both builtins), and weigh in with
> > 2893142 bytes.

Hmmm. I thought they depended on msys infrastructure. Can I trivially
compile a statically linked git-diff.exe and git-apply.exe and expect
them to just work? How large would they be then?

msysGIT is *excellent* to get a full GIT install for development
purposes. The requirements in this case are different...

cheers,



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
NZ: +64(4)916-7224    MOB: +64(21)364-017    UK: 0845 868 5733 ext 7224
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
