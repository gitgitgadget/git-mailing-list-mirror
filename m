From: Dale Rowley <ddrowley3@juno.com>
Subject: git-push segfault
Date: Wed, 24 Feb 2010 03:46:37 +0000 (UTC)
Message-ID: <loom.20100224T043557-954@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 24 04:46:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk8D9-0000RK-1J
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 04:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755116Ab0BXDqt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 22:46:49 -0500
Received: from lo.gmane.org ([80.91.229.12]:56092 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab0BXDqt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 22:46:49 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nk8D2-0000OZ-1C
	for git@vger.kernel.org; Wed, 24 Feb 2010 04:46:48 +0100
Received: from 71-212-187-72.hlrn.qwest.net ([71.212.187.72])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:46:48 +0100
Received: from ddrowley3 by 71-212-187-72.hlrn.qwest.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:46:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 71.212.187.72 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091212 Gentoo Firefox/3.5.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140896>

Steps to reproduce:

git clone /path/to/some/repo
cd repo
git config --unset branch.master.remote
git push
(seg fault)

I'm using version 1.7.0.

Dale
