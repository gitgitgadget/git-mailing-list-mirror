From: Mike Hommey <mh@glandium.org>
Subject: [Crash] git-push $remote $non_ref:$anything
Date: Sun, 15 Jun 2008 21:38:23 +0200
Organization: glandium.org
Message-ID: <20080615193823.GA11218@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 15 21:40:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7y5Q-00008K-8j
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 21:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbYFOTja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbYFOTja
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 15:39:30 -0400
Received: from vuizook.err.no ([194.24.252.247]:43696 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbYFOTj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 15:39:29 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K7y4P-0005OX-5u
	for git@vger.kernel.org; Sun, 15 Jun 2008 21:39:27 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K7y3T-0003HM-4q
	for git@vger.kernel.org; Sun, 15 Jun 2008 21:38:23 +0200
Content-Disposition: inline
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85110>

Hi,

I somehow managed to get a segfault by running this:

git push origin non-existant-branch-name:non-existant-branch-name

FWIW, the output looks like this:

error: src refspec patches/uri-handlers does not match any.
Segmentation fault
fatal: The remote end hung up unexpectedly

I don't have time to dig into this, unfortunately.

Mike
