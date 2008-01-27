From: Mike Hommey <mh@glandium.org>
Subject: Is there a reason to keep walker.c ?
Date: Sun, 27 Jan 2008 21:45:35 +0100
Organization: glandium.org
Message-ID: <20080127204535.GA4702@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 21:44:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJEMz-0006y5-Ii
	for gcvg-git-2@gmane.org; Sun, 27 Jan 2008 21:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbYA0UoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2008 15:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753574AbYA0UoE
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jan 2008 15:44:04 -0500
Received: from [85.19.215.103] ([85.19.215.103]:55923 "EHLO vuizook.err.no"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753454AbYA0UoD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2008 15:44:03 -0500
Received: from aputeaux-153-1-83-190.w86-205.abo.wanadoo.fr ([86.205.41.190] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JJELy-0001wF-GM
	for git@vger.kernel.org; Sun, 27 Jan 2008 21:43:55 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JJENj-0001Fs-UF
	for git@vger.kernel.org; Sun, 27 Jan 2008 21:45:35 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71828>

Hi,

While working on the http code refactoring, I got to wonder if the
walker.c "wrapper", that is only used for the http transport, is still
worth keeping. If there are plans for others transport to use this code,
obviously, it would be worth keeping, but on the contrary, I think it
would simplify the http transport code even more. What do you think ?

Cheers,

Mike
