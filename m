From: Jonas <jonas@ibiz.se>
Subject: git repository in production release
Date: Thu, 21 Oct 2010 12:13:53 +0000 (UTC)
Message-ID: <loom.20101021T140249-924@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 14:15:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8u39-0005Sx-Ow
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 14:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712Ab0JUMPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 08:15:07 -0400
Received: from lo.gmane.org ([80.91.229.12]:44872 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752340Ab0JUMPG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 08:15:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1P8u2x-0005Op-II
	for git@vger.kernel.org; Thu, 21 Oct 2010 14:15:03 +0200
Received: from static-92-33-15-10.sme.bredbandsbolaget.se ([92.33.15.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:15:03 +0200
Received: from jonas by static-92-33-15-10.sme.bredbandsbolaget.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 14:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 92.33.15.10 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_4; sv-se) AppleWebKit/533.18.1 (KHTML, like Gecko) Version/5.0.2 Safari/533.18.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159494>

Hi,

I am afraid this is a rather stupid question, but I have spent quite some time
to figure it out without any success.

I use git in my Ruby on Rails applications. On my deployment server
there is a git directory that I push to in the admin users directory. 
When I run cap deploy Capistrano makes a new release and makes a new 
directory under releases from the repository, I guess this is standard.

My releases are getting bigger and bigger, it takes longer and 
longer time for the cap deploy command to 
finish and the backups contain a huge number of files.

What puzzels me is that in every release  there is a .git directory.
As far as I can see it makes no use there, 
just takes up much space. Is it supposed to be like this or have I made a mess?

How can I get rid of the .git directory in the deployment releases?

:-) j
