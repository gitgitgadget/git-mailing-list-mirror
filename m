From: Gelonida <gelonida@gmail.com>
Subject: how to push from  repository with two tracking branches
Date: Thu, 13 May 2010 11:09:11 +0200
Message-ID: <hsgfjn$onv$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 13 11:09:35 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCUQA-0005hM-6A
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 11:09:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758071Ab0EMJJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 05:09:28 -0400
Received: from lo.gmane.org ([80.91.229.12]:59284 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758006Ab0EMJJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 05:09:26 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OCUPz-0005cB-Vd
	for git@vger.kernel.org; Thu, 13 May 2010 11:09:23 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 11:09:23 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 13 May 2010 11:09:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
connect(): No such file or directory
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146982>

Hi,

I have a repository with two tracking branches ('master' and 'mybranch')

with only one tracking branch I can do
git pull
make_local_changes
git commit -a
git push


with two tracking branches I will be told off if the other branch has
been updated meanwhile, so what I currently to do is:

# 'pull and fastforward mybranch'
git checkout mybranch
git pull
git checkout master

# pull and commit and push as with one tracking branch
git pull
make_local_changes
git commit -a
git push


How can I do this more efficiently?
after a pull to master (I just had to fast forward mybranch to
remote/mybranch)
Switching branches and pulling seems a little clumsy


N
