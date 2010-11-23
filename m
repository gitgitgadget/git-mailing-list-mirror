From: Marcos Nogueira <marcos@arena.com.br>
Subject: Re: Absolute Beginner
Date: Tue, 23 Nov 2010 12:16:32 -0200
Organization: Arena
Message-ID: <201011231216.33207.marcos@arena.com.br>
References: <1290516065002-5766449.post@n2.nabble.com> <AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 15:52:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKuDv-0001Zo-KT
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 15:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151Ab0KWOvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 09:51:54 -0500
Received: from hm1831-31.locaweb.com.br ([189.126.112.51]:24812 "EHLO
	hm1831-31.locaweb.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab0KWOvx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 09:51:53 -0500
X-Greylist: delayed 1906 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Nov 2010 09:51:53 EST
Received: from hm2084.locaweb.com.br (189.126.112.73) by hm1831-34.locaweb.com.br (PowerMTA(TM) v3.5r15) id htfagi0nva4d for <git@vger.kernel.org>; Tue, 23 Nov 2010 12:20:05 -0200 (envelope-from <marcos@arena.com.br>)
Received: from bart0008.locaweb.com.br (bart0008.email.locaweb.com.br [200.234.210.74])
	by hm2084.locaweb.com.br (Postfix) with ESMTP id 1544D4409C7;
	Tue, 23 Nov 2010 12:16:34 -0200 (BRST)
X-LocaWeb-COR: locaweb_2009_x-mail
Received: from hp-laptop.localnet (c953be9d.virtua.com.br [201.83.190.157])
	(Authenticated sender: marcos@arena.com.br)
	by bart0008.locaweb.com.br (Postfix) with ESMTPA id E5DBF8C35E;
	Tue, 23 Nov 2010 12:16:33 -0200 (BRST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-22-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <AANLkTindQRaUMXiQ_2Fa-guKtZz5oV89Gw7W0dapO9MT@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.96.3 at bart0008
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161968>

Hello Duy,

Thanks for your reply. Since this is my first visit to this mailing-list, I don't know its etiquette rules yet. Is this the place to get help? Can I post long messages? The whole story of setting up our Git server is quite big... :-)

Anyway, follows below a list of some of the places where I've found the instructions I've mentioned:

http://progit.org/book/ch4-0.html
http://www.kernel.org/pub/software/scm/git/docs/howto/setup-git-server-over-http.txt
http://www.howtoforge.com/how-to-install-a-public-git-repository-on-a-debian-server
http://batterypowered.wordpress.com/2008/07/04/deploying-a-git-repository-server-in-ubuntu/
http://mattrude.com/2009/07/creating-a-secure-git-repository-server/
http://scie.nti.st/2007/11/14/hosting-git-repositories-the-easy-and-secure-way
http://www.kernel.org/pub/software/scm/git/docs/git-daemon.html
http://gofedora.com/how-to-install-configure-gitweb/

Trying to make it short, the last attempt to push a local project to the server produced the following results:

(...)
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
remote: error: By default, updating the current branch in a non-bare repository
remote: error: is denied, because it will make the index and work tree inconsistent
remote: error: with what you pushed, and will require 'git reset --hard' to match
remote: error: the work tree to HEAD.
remote: error: 
remote: error: You can set 'receive.denyCurrentBranch' configuration variable to
remote: error: 'ignore' or 'warn' in the remote repository to allow pushing into
remote: error: its current branch; however, this is not recommended unless you
remote: error: arranged to update its work tree to match what you pushed in some
remote: error: other way.
remote: error: 
remote: error: To squelch this message and still keep the default behaviour, set
remote: error: 'receive.denyCurrentBranch' configuration variable to 'refuse'.
To git@srvpkt:/home/public/teste_sem_bare
 ! [remote rejected] master -> master (branch is currently checked out)
error: failed to push some refs to 'git@srvpkt:/home/public/teste_sem_bare'

marcos@hp-laptop:~/teste_sem_bare$ 
(...)

Thanks again,

Marcos

> On Tue, Nov 23, 2010 at 7:41 PM, marcos <marcos@arena.com.br> wrote:
> >
> > I'm an absolute beginner with Git. So far I've managed to install, understand
> > and use Git locally, but am facing many difficulties on using a centralized
> > repository on a LAN local server. I've followed the instructions on many
> > places over the web, but none has worked so far. As the development team
> > grows (we're 5 at this moment), consolidating and synchronizing the files is
> > becoming almost impossible. Any help will be much appreciated.
> 
> We need to know what difficulties you have. What do you want to
> achieve? What instructions have you followed? What commands have you
> tried? Any errors from them...
> 
