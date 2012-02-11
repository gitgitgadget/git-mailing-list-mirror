From: isawk <kwasi.gyasiagyei@4things.co.za>
Subject: Git SSH Authentication
Date: Sat, 11 Feb 2012 04:01:37 +0000 (UTC)
Message-ID: <loom.20120211T045801-602@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 05:05:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw4Db-00049P-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 05:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758379Ab2BKEFL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 23:05:11 -0500
Received: from plane.gmane.org ([80.91.229.3]:33173 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754954Ab2BKEFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 23:05:10 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rw4Ct-0003pS-Ly
	for git@vger.kernel.org; Sat, 11 Feb 2012 05:05:04 +0100
Received: from 41-132-113-112.dsl.mweb.co.za ([41.132.113.112])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 05:05:03 +0100
Received: from kwasi.gyasiagyei by 41-132-113-112.dsl.mweb.co.za with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 05:05:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 41.132.113.112 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190481>

I'm unable to authenticate with git through ssh public key/password-less
authentication.

# git push origin master
# Permission denied (publickey,gssapi-keyex,gssapi-with-mic).
# fatal: The remote end hung up unexpectedly

git version

git version 1.7.8.4

git user

has .ssh/authorized_keys containing public key, but still nothing. I'm confused
on how to go about fixing this issue.
