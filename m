From: =?utf-8?b?RnLDqWTDqXJpYw==?= Heitzmann 
	<frederic.heitzmann@gmail.com>
Subject: pre-dcommit hook for 'git svn dcommit'  ?
Date: Sat, 18 Jun 2011 15:55:25 +0000 (UTC)
Message-ID: <loom.20110618T172659-970@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 18 17:55:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXxs8-0002uj-6z
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 17:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248Ab1FRPzj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jun 2011 11:55:39 -0400
Received: from lo.gmane.org ([80.91.229.12]:34832 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756191Ab1FRPzj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2011 11:55:39 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QXxs1-0002sN-AZ
	for git@vger.kernel.org; Sat, 18 Jun 2011 17:55:37 +0200
Received: from dra38-7-88-179-84-80.fbx.proxad.net ([88.179.84.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 17:55:37 +0200
Received: from frederic.heitzmann by dra38-7-88-179-84-80.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 17:55:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 88.179.84.80 (Mozilla/5.0 (X11; U; Linux i686; fr; rv:1.9.2.17) Gecko/20110422 Ubuntu/10.04 (lucid) Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175976>

Hello.

There is no way to set a hook before 'git svn dcommit', similarly with
pre-commit hook. I could use SVN hooks instead, but I have no rights to tune the
SVN server (and it would also mean that my hooks would be applied to all SVN
commits).

Any better idea than a pre-svn-dcommit hook ?

Thanks,

Fred
