From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Initial push to remote repository
Date: Wed, 19 Sep 2007 13:35:57 +0200
Message-ID: <20070919113557.GA24674@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 13:43:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXxxW-00017A-26
	for gcvg-git-2@gmane.org; Wed, 19 Sep 2007 13:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754511AbXISLnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 07:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754424AbXISLnE
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 07:43:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:52296 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753845AbXISLnD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 07:43:03 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Sep 2007 07:43:03 EDT
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 228923F447; Wed, 19 Sep 2007 13:35:57 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58703>

Hello,
I used to publish my local work on a machine with all my git
repositories using the following commands:

# Publish a local created repository to a remote repository.
ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/astro.git init-db
git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/astro.git
git push origin master:master
echo >> .git/config <<EOF
[branch "master"]
        remote = origin
        merge = refs/heads/master
EOF
git pull

But since my last update of git it doesn't seem to work that way anymore. Is
there another way to do what I like to using the git way?

        (ad027088pc) [~] mkdir test_initial_push
        (ad027088pc) [~] cd !$
        (ad027088pc) [~/test_initial_push] touch a
        (ad027088pc) [~/test_initial_push] git init
        Initialized empty Git repository in .git/
        (ad027088pc) [~/test_initial_push] git add a
        (ad027088pc) [~/test_initial_push] git commit -m "whatever" a
        Created initial commit 0d408ed: whatever
        0 files changed, 0 insertions(+), 0 deletions(-)
        create mode 100644 a
        (reverse-i-search)`':
        (ad027088pc) [~/test_initial_push] ssh 131.188.30.102 git --git-dir=/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git init-db
        Initialized empty Git repository in /home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/
        (ad027088pc) [~/test_initial_push] git remote add origin 131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/
        You have new mail in /home/adglth0/Maildir
        (ad027088pc) [~/test_initial_push] git push origin master:master
        error: dst refspec master does not match any existing ref on the remote and does not start with refs/.
        fatal: The remote end hung up unexpectedly
        error: failed to push to '131.188.30.102:/home/cip/adm/sithglan/work/repositories/private/test_initial_push.git/'
        (ad027088pc) [~/test_initial_push] git version
        git version 1.5.3.1
        (ad027088pc) [~/test_initial_push] ssh 131.188.30.102 git version
        git version 1.5.2.1

                Thomas
