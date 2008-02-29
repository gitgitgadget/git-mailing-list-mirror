From: Mike Hommey <mh@glandium.org>
Subject: Problem with test from aa9c83c2
Date: Fri, 29 Feb 2008 22:04:10 +0100
Organization: glandium.org
Message-ID: <20080229210410.GA26683@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 29 22:02:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVCMc-0007wU-QQ
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:01:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759387AbYB2VAv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760149AbYB2VAv
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:00:51 -0500
Received: from vuizook.err.no ([194.24.252.247]:36381 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759221AbYB2VAu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:00:50 -0500
X-Greylist: delayed 1903 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Feb 2008 16:00:50 EST
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JVCLS-0003Bz-MX
	for git@vger.kernel.org; Fri, 29 Feb 2008 22:00:48 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JVCOo-00070E-3u
	for git@vger.kernel.org; Fri, 29 Feb 2008 22:04:10 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75561>

Hi,

When run as root, the test added in aa9c83c2 fails, because root is allowed
to remove files in unreadable and unwriteable directories. Now, the
problem is that I don't know what to do with that. Should we care ?

Mike
