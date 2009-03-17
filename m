From: Roger Garvin <yoyodyn@gmail.com>
Subject: Suggested Workflow Question
Date: Tue, 17 Mar 2009 17:51:10 +0000 (UTC)
Message-ID: <loom.20090317T175010-470@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 17 18:57:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjdWu-0003BE-FE
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 18:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbZCQRzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 13:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754315AbZCQRzI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 13:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:34091 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbZCQRzH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 13:55:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LjdVG-0005LP-NZ
	for git@vger.kernel.org; Tue, 17 Mar 2009 17:55:03 +0000
Received: from smtp.qmsionline.com ([65.163.36.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 17:55:02 +0000
Received: from yoyodyn by smtp.qmsionline.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Mar 2009 17:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 65.163.36.90 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.0.7) Gecko/2009021910 Firefox/3.0.7)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113511>

I work for a small company with about 15 developers who work concurrently on
about 10+ projects both in new development and support.
We do custom software for manufacturing and production systems.  Part of our
contracts with our customers is a perpetual single use license of the source
code at each facility.
So we have a copy of the source on our office server, and another copy at each
customer site.  When we had only 5 developers it was easier to handle.  Now that
we are growing we need a source control system and I have been looking heavily
into Git.  Our old workflow does not seem that it will fit well with Git
however, but I feel that I need a distributed system to keep track of the office
version and the on-site versions of our source since development is taking place
on both.
(Some customers also have separate development, and testing versions on their
servers as well.)

I have created git repositories on a couple of our project source directories as
test beds.  Right now (second day) I am the only one who is actually using git.
 Everyone else is simply accessing the files on the server as they have always
done, and I am making the commits when I see signifigant changes. 

My question is really a request for modified workflow ideas.  My plan was to
have a master repository in our office server with clones at each customer site,
and multiple branches for test, QA, and production versions of the source.
Since most of these customers have closed networks, we would rely on people
traveling onsite, or emailing patches to get any updates back into our office
repository. 

Thank you for any assistance for this revision control newb.

Roger Garvin
