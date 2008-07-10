From: Stephan Hennig <mailing_list@arcor.de>
Subject: git pull is slow
Date: Thu, 10 Jul 2008 16:40:17 +0200
Message-ID: <g5570s$d5m$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 16:41:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGxL2-0007Zn-3w
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 16:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbYGJOkl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 10:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754746AbYGJOkl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 10:40:41 -0400
Received: from main.gmane.org ([80.91.229.2]:38742 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598AbYGJOkl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 10:40:41 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGxK1-0000wo-Ht
	for git@vger.kernel.org; Thu, 10 Jul 2008 14:40:37 +0000
Received: from dialin-145-254-067-152.pools.arcor-ip.net ([145.254.67.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 14:40:37 +0000
Received: from mailing_list by dialin-145-254-067-152.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 14:40:37 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: dialin-145-254-067-152.pools.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87978>

Hi,

I am observing very large data transfers when pulling from the
repository at <URL:http://repo.or.cz/w/wortliste.git>.  This repository
contains one 13 MB text file that compressed is roughly 3 MB large.

While I'd expect pulling commits that change only a few lines of the
large text file to result in a download of less than, say 10kB, git pull
seems to transfer the complete, compressed file.  I have observed this
several times for different commits.  On the other hand, pushing my own
commits to the repository is fast (with git+ssh access method).  Any
ideas what's going on and how to make pulling faster?

Best regards,
Stephan Hennig

> $ git version
> git version 1.5.6.1.1071.g76fb
