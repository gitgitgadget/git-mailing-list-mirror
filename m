From: marcos <marcos@arena.com.br>
Subject: Re: Absolute Beginner
Date: Tue, 23 Nov 2010 07:24:28 -0800 (PST)
Message-ID: <1290525868767-5766781.post@n2.nabble.com>
References: <1290516065002-5766449.post@n2.nabble.com> <AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 23 16:24:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKujT-0002CK-Rc
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 16:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0KWPYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 10:24:30 -0500
Received: from kuber.nabble.com ([216.139.236.158]:49574 "EHLO
	kuber.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109Ab0KWPY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 10:24:29 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <marcos@arena.com.br>)
	id 1PKujM-0005Ks-Ox
	for git@vger.kernel.org; Tue, 23 Nov 2010 07:24:28 -0800
In-Reply-To: <AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161970>


Hello Duy,

I've just replied by email. See below the message sent:

(...)
Thanks for your reply. Since this is my first visit to this mailing-list, I
don't know its etiquette rules yet. Is this the place to get help? Can I
post long messages? The whole story of setting up our Git server is quite
big... :-)

Anyway, follows below a list of some of the places where I've found the
instructions I've mentioned:

http://progit.org/book/ch4-0.html
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
http://www.howtoforge.com/how-to-install-a-public-git-repository-on-a-debian-server
http://batterypowered.wordpress.com/2008/07/04/deploying-a-git-repository-server-in-ubuntu/
http://mattrude.com/2009/07/creating-a-secure-git-repository-server/
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
http://www.kernel.org/pub/software/scm/git/docs/git-daemon.html
http://gofedora.com/how-to-install-configure-gitweb/

Trying to make it short, the last attempt to push a local project to the
server produced the following results:

marcos@hp-laptop:~/teste_sem_bare$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
nothing to commit (working directory clean)

marcos@hp-laptop:~/teste_sem_bare$ ls
teste.txt

marcos@hp-laptop:~/teste_sem_bare$ git push origin master
Counting objects: 5, done.
Writing objects: 100% (3/3), 293 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
remote: error: refusing to update checked out branch: refs/heads/master
remote: error: By default, updating the current branch in a non-bare
repository
remote: error: is denied, because it will make the index and work tree
inconsistent
remote: error: with what you pushed, and will require 'git reset --hard' to
match
remote: error: the work tree to HEAD.
remote: error: 
remote: error: You can set 'receive.denyCurrentBranch' configuration
variable to
remote: error: 'ignore' or 'warn' in the remote repository to allow pushing
into
remote: error: its current branch; however, this is not recommended unless
you
remote: error: arranged to update its work tree to match what you pushed in
some
remote: error: other way.
remote: error: 
remote: error: To squelch this message and still keep the default behaviour,
set
remote: error: 'receive.denyCurrentBranch' configuration variable to
'refuse'.
To git@srvpkt:/home/public/teste_sem_bare
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to 'git@srvpkt:/home/public/teste_sem_bare'

marcos@hp-laptop:~/teste_sem_bare$ 
(...)

Then I received a reply from Howard Miller:

(...)
You are trying to push to a repo that isn't bare. Not impossible but
problematic and you can't do it at all by default (as you have found).

Personally I would look at a central shared repo. You could just get an
account on (something like) GitHub or setup your own (something like
Gitosis).
(...)

>From now on I'll remain here at Nabble regarding this subject.

Thanks again,

Marcos

-- 
View this message in context: http://git.661346.n2.nabble.com/Absolute-Beginner-tp5766449p5766781.html
Sent from the git mailing list archive at Nabble.com.
