From: Mike Hommey <mh@glandium.org>
Subject: What should a user expect from git log -M -- file
Date: Thu, 26 Nov 2009 17:36:54 +0100
Message-ID: <20091126163654.GA14509@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 26 17:37:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDhLo-0007yC-83
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 17:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbZKZQhg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 11:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753879AbZKZQhg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 11:37:36 -0500
Received: from vuizook.err.no ([85.19.221.46]:55652 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754534AbZKZQhg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 11:37:36 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1NDhLe-0007PQ-Hx
	for git@vger.kernel.org; Thu, 26 Nov 2009 17:37:41 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1NDhKw-0003nE-Li
	for git@vger.kernel.org; Thu, 26 Nov 2009 17:36:54 +0100
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133808>

Hi,

I recently reorganized a project of mine, and the result is that a lot of
files moved from the top directory to a sub directory.

Now, I innocently tried to 'git log -M' some of these files in the
subdirectories, and well, the history just stops when the file was
created. Obviously, if I put both the old and the new location it works,
but shouldn't users expect 'git log -M -- file' to try to find the
previous path and continue from there ?

Mike
