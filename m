From: Daniel Jacobs <djacobs7@gmail.com>
Subject: excluding files from a merge
Date: Sun, 15 Mar 2009 01:23:03 +0000 (UTC)
Message-ID: <loom.20090315T011519-497@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 09:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lim9I-0005HX-2q
	for gcvg-git-2@gmane.org; Sun, 15 Mar 2009 09:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbZCOIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2009 04:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752633AbZCOIzI
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Mar 2009 04:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:39033 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbZCOIzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2009 04:55:07 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1Lim7a-0003bU-68
	for git@vger.kernel.org; Sun, 15 Mar 2009 08:55:02 +0000
Received: from c-24-6-255-91.hsd1.ca.comcast.net ([24.6.255.91])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 08:55:02 +0000
Received: from djacobs7 by c-24-6-255-91.hsd1.ca.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 15 Mar 2009 08:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.6.255.91 (Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_5; en-us) AppleWebKit/525.18 (KHTML, like Gecko) Version/3.1.2 Safari/525.20.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113278>

Our project has two main branches set up, one called 'development, and 
another called 'production'.

Each branch has a file in it called database.yml, (this is a rails project)...
 The development branch and the 
production branch are supposed to have different versions of this file. 
(and not only this file, but other 
config sorts of files as well, but this is a good example).

At the same time, when development is ready for deployment, we will do
git checkout production
git merge development

I would like it if every file was merged, except for files that were explictly 
excluded from a merge between these two branches.  Is there a good way to do
this?

-Daniel
