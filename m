From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: Re: Smart fetch via HTTP?
Date: Fri, 18 May 2007 22:06:18 +0200
Message-ID: <vpqbqgh99s5.fsf@bauges.imag.fr>
References: <20070515201006.GD3653@efreet.light.src>
	<20070517124006.GO4489@pasky.or.cz> <vpqlkfnipjl.fsf@bauges.imag.fr>
	<alpine.LFD.0.98.0705181123590.3890@woody.linux-foundation.org>
	<20070518190159.GS24644@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Fri May 18 22:07:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp8ja-0002tx-2X
	for gcvg-git@gmane.org; Fri, 18 May 2007 22:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139AbXERUHX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 16:07:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754475AbXERUHX
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 16:07:23 -0400
Received: from imag.imag.fr ([129.88.30.1]:64851 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbXERUHW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 16:07:22 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id l4IK6ILt017027
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Fri, 18 May 2007 22:06:18 +0200 (CEST)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Hp8iQ-0001WD-H9; Fri, 18 May 2007 22:06:18 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.63)
	(envelope-from <moy@imag.fr>)
	id 1Hp8iQ-0000dD-Em; Fri, 18 May 2007 22:06:18 +0200
Mail-Followup-To: Joel Becker <Joel.Becker@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>,  git@vger.kernel.org
In-Reply-To: <20070518190159.GS24644@ca-server1.us.oracle.com> (Joel Becker's message of "Fri\, 18 May 2007 12\:01\:59 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.97 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Fri, 18 May 2007 22:06:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact IMAG DMI for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47656>

Joel Becker <Joel.Becker@oracle.com> writes:

> 	A normal company needs to have their firewall allow CONNECT to
> 9418.  Then git proxying over HTTP is possible to a standard
> git-daemon.

443 should work too (that's HTTPS, and the proxy can't filter it,
since this would be a man-in-the-middle attack).

-- 
Matthieu
