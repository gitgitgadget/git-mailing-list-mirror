From: Florian Weimer <fw@deneb.enyo.de>
Subject: git svn clone stops after r2 for svn://mlton.org/mlton/trunk
Date: Sat, 29 Jan 2011 16:55:24 +0100
Message-ID: <87aaijso0j.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 17:42:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjDsQ-0006eu-0z
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 17:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057Ab1A2QmM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 11:42:12 -0500
Received: from ka.mail.enyo.de ([87.106.162.201]:56477 "EHLO ka.mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753708Ab1A2QmL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 11:42:11 -0500
X-Greylist: delayed 2805 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2011 11:42:11 EST
Received: from [172.17.135.4] (helo=deneb.enyo.de)
	by ka.mail.enyo.de with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	id 1PjD92-0001n0-PR
	for git@vger.kernel.org; Sat, 29 Jan 2011 16:55:24 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.72)
	(envelope-from <fw@deneb.enyo.de>)
	id 1PjD92-0007Iu-Hp
	for git@vger.kernel.org; Sat, 29 Jan 2011 16:55:24 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165661>

There's something strange going on there:

$ git svn clone svn://mlton.org/mlton/trunk mlton 
Initialized empty Git repository in /home/fw/src/mlton/.git/
r2 = 61f0dd5ba401ece2ff4668bc7454b7742c60fa99 (refs/remotes/git-svn)
Checked out HEAD:
  svn://mlton.org/mlton/trunk r2
$
 
"git svn fetch" is able to continue, though, so this is only a very
minor inconvenience.
