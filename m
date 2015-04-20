From: Fusion Xavier <fusionx86@gmail.com>
Subject: git-p4 Question
Date: Mon, 20 Apr 2015 16:29:59 +0000 (UTC)
Message-ID: <loom.20150420T182646-173@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 18:35:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkEfB-0002na-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 18:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbbDTQfH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 12:35:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:33130 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751223AbbDTQfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 12:35:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YkEf1-0002hJ-Fu
	for git@vger.kernel.org; Mon, 20 Apr 2015 18:35:03 +0200
Received: from 50-202-92-238-static.hfc.comcastbusiness.net ([50.202.92.238])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 18:35:03 +0200
Received: from fusionx86 by 50-202-92-238-static.hfc.comcastbusiness.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 20 Apr 2015 18:35:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 50.202.92.238 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:37.0) Gecko/20100101 Firefox/37.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267474>

Hello,

Hopefully this is an appropriate place to ask questions about git-p4.

I started at a company that wants to migrate from Perforce to Git. I'm new
to Perforce and have been trying to learn just enough about it to get
through this migration. Anyway, I've been playing with git-p4 and have run
into something with it I don't understand.

After setting up the p4 cli client I can 'p4 sync' some //depot/main/app1
depot/folder which pulls down the files I would expect from the Perforce
server. If I use 'git p4 clone //depot/main/app1', I get:

"Doing initial import of //depot/main/app1/ from revision #head into
refs/remotes/p4/master"

But I don't get any files from that depot/folder pulled down. I can git p4
clone other depot/folders though and get some files. I suspect that I'm just
not understanding how the git-p4 module works.

Basically, I'm hoping to setup a live sync of Perforce to Git of certain
depots in preparation for the migration. Also, if anyone has pointers or
guides for this type of migration, any help is appreciated.
