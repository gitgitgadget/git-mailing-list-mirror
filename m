From: Martin Langhoff <martin@catalyst.net.nz>
Subject: Re: [PATCH] Allow passing of an alternative CVSROOT via -d.
Date: Mon, 19 Feb 2007 18:25:32 +1300
Message-ID: <45D934CC.6080707@catalyst.net.nz>
References: <45D88A14.4040400@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 06:49:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJ1Or-0001i6-BQ
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 06:49:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbXBSFtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 00:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752954AbXBSFtJ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 00:49:09 -0500
Received: from godel.catalyst.net.nz ([202.78.240.40]:48577 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbXBSFtI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 00:49:08 -0500
X-Greylist: delayed 1407 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Feb 2007 00:49:08 EST
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1HJ11t-0005zO-KR; Mon, 19 Feb 2007 18:25:37 +1300
User-Agent: Thunderbird 1.5.0.9 (X11/20070103)
In-Reply-To: <45D88A14.4040400@fs.ei.tum.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40098>

Simon 'corecode' Schubert wrote:
> This is necessary if using CVS in an asymmetric fashion, i.e. when the
> CVSROOT you are checking out from differs from the CVSROOT you have to
> commit to.

I guess you have an anon checkout and then use CVSROOT at commit time to
switch to cvs-over-ssh perhaps even on a different server. In-te-rest-ing.

I've never in my life used cvs this way -- or thought something like
this would work. But if it works for you, I can only ACK it ;-)

is "Assymmetric CVS" a known term for this practice? If not, it might be
useful to flesh out what this is for in the docs.



m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224  UK: 0845 868 5733 ext 7224  MOB: +64(21)364-017
      Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
