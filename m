From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Subject: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 23:34:56 +0100
Message-ID: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 26 23:55:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZuJI-000690-Oy
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 23:55:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534Ab0AZWy5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 17:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523Ab0AZWy5
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 17:54:57 -0500
Received: from witko.kerneis.info ([213.186.56.95]:45971 "EHLO
	witko.kerneis.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab0AZWy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 17:54:56 -0500
X-Greylist: delayed 1187 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Jan 2010 17:54:56 EST
Received: from 88-121-54-9.rev.libertysurf.net ([88.121.54.9] helo=trurl.pps.jussieu.fr)
	by witko.kerneis.info with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <jch@pps.jussieu.fr>)
	id 1NZu01-0006mF-Au
	for git@vger.kernel.org; Tue, 26 Jan 2010 23:35:05 +0100
Received: from jch by trurl.pps.jussieu.fr with local (Exim 4.71)
	(envelope-from <jch@trurl.pps.jussieu.fr>)
	id 1NZtzs-00057k-Ki
	for git@vger.kernel.org; Tue, 26 Jan 2010 23:34:56 +0100
X-SA-Exim-Connect-IP: 88.121.54.9
X-SA-Exim-Mail-From: jch@pps.jussieu.fr
X-SA-Exim-Scanned: No (on witko.kerneis.info); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138084>

Hi,

I'm seeing Git patches being corrupted by mailers and still apply
correctly.  It would be great if git-format-patch could include a hash
of the patch body (and commit message); git-am should check the hash,
and refuse to commit if the patch was corrupted (--force should override
that, of course).

                                        Juliusz
