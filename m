From: Reza Mostafid <m.r.mostafid@gmail.com>
Subject: GIT and SSH
Date: Wed, 28 Dec 2011 08:43:45 +0000 (UTC)
Message-ID: <loom.20111228T091942-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 28 09:55:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfpI8-0005Z1-Ox
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 09:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab1L1IzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 03:55:16 -0500
Received: from lo.gmane.org ([80.91.229.12]:47644 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751343Ab1L1IzP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 03:55:15 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RfpI0-0004oO-AZ
	for git@vger.kernel.org; Wed, 28 Dec 2011 09:55:13 +0100
Received: from 213.207.203.115 ([213.207.203.115])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 09:55:12 +0100
Received: from m.r.mostafid by 213.207.203.115 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 09:55:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.207.203.115 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.10) Gecko/20100915 Ubuntu/9.04 (jaunty) Firefox/3.6.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187745>

I am starting to use GIT and I would be grateful for a simple answer to a
specific situation to help me find the right ball-park.


a.) Does the communication that takes place between a GIT `client` and a remote
    GIT `repository` involve 'ssh' traffic?


Our connections here are heavily censored and ssh traffic is suppressed most of
the time which is why I need to figure out why a simple  

    $ git clone git://<URL> 

command chokes to a halt and freezes most of the time ( the same command when
executed remotely on our V.P.S. in Europe works flawlessly ).
 

b.) Are there means to make the `git` client on my machine circumvent this?


Y/N answers or brief hints to my questions suffice, I'll work out the rest. 

Basically I would like to know whether there is a point at all trying to make
git work from where I am, given the limitations mentioned.

Regards

Reza
