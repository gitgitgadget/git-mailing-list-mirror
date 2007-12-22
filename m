From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Pushing and fetching sha1s directly
Date: Sat, 22 Dec 2007 22:13:08 +0100
Message-ID: <20071222211308.GA27281@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 22:14:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J6Bfg-0006ZK-VQ
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 22:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753029AbXLVVNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 16:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbXLVVNL
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 16:13:11 -0500
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:59865 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751698AbXLVVNK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 16:13:10 -0500
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.60)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1J6Bee-0003VM-VR
	for git@vger.kernel.org; Sat, 22 Dec 2007 22:13:08 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69157>

Currently there seems to be no way of pusing a sha1 directly, or to
fetch a sha1 directly. When working with submodules, it is convenient
to be able to work with detached HEADs, so it would be good if this
could be supported also by fetch and push.

What would be a resonable syntax for this? I'm thinking something like
git fetch --sha1 <repository> <sha1>
git push --sha1 <repository> <sha1>

Where <sha1> could really be a <commit> I guess, but the option name
"--commit" seems wrong somehow. Another option is to extend refspecs
so sha1s can be allowed in there directly, so this would just work:

git fetch <repository> <sha1>

What do you prefer?

- Finn Arne
