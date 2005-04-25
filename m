From: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Subject: Git-aware darcs: gettable repo
Date: Mon, 25 Apr 2005 22:09:08 +0200
Message-ID: <7ipswir53v.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: darcs-devel-bounces@darcs.net Mon Apr 25 22:05:08 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQ9ob-0005tP-Re
	for gcvdd-darcs-devel@m.gmane.org; Mon, 25 Apr 2005 22:04:22 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQ9tL-0003U8-LM; Mon, 25 Apr 2005 16:09:15 -0400
Received: from shiva.jussieu.fr ([134.157.0.129])
	by abridgegame.org with esmtp (Exim 4.50) id 1DQ9tJ-0002ic-N3
	for darcs-devel@darcs.net; Mon, 25 Apr 2005 16:09:14 -0400
Received: from hydrogene.pps.jussieu.fr (hydrogene.pps.jussieu.fr
	[134.157.168.1])
	by shiva.jussieu.fr (8.12.11/jtpda-5.4) with ESMTP id j3PK981d067656
	; Mon, 25 Apr 2005 22:09:11 +0200 (CEST)
X-Ids: 168
Received: from lanthane.pps.jussieu.fr (lanthane.pps.jussieu.fr
	[134.157.168.57])
	by hydrogene.pps.jussieu.fr (8.13.3/jtpda-5.4) with ESMTP id
	j3PK99Oj020962 ; Mon, 25 Apr 2005 22:09:09 +0200
Received: from jch by lanthane.pps.jussieu.fr with local (Exim 4.34)
	id 1DQ9tE-0003vg-Vc; Mon, 25 Apr 2005 22:09:08 +0200
To: darcs-devel@darcs.net, Git Mailing List <git@vger.kernel.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.2
	(shiva.jussieu.fr [134.157.0.168]);
	Mon, 25 Apr 2005 22:09:11 +0200 (CEST)
X-Antivirus: scanned by sophie at shiva.jussieu.fr
X-Miltered: at shiva.jussieu.fr with ID 426D4E64.001 by Joe's j-chkmail
	(http://j-chkmail.ensmp.fr)!
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net

Hi,

Just to let you know that, thanks to some friendly tagging by Ian Lynagh,
I've been able to set up a gettable Darcs repository of the Git-aware
version of Darcs.

  http://www.pps.jussieu.fr/~jch/software/repos/darcs-git/

If you're on a Linux system with darcs, ghc 6.2, libz, libcurl and libssl,
you should be able to do

  $ darcs get --partial http://www.pps.jussieu.fr/~jch/software/repos/darcs-git
  $ cd darcs-git
  $ make darcs
  $ make Context.hs
  $ make darcs
  $ mv darcs ~/bin/darcs-git
  $ cd ..
  $ mkdir linux
  $ cd linux
  $ darcs-git initialize
  $ darcs-git pull /usr/local/src/linux-2.6

and see the OOM killer in action.

                                        Juliusz
