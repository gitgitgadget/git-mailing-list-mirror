From: Petr Baudis <pasky@ucw.cz>
Subject: [ANNOUNCE] repo.or.cz does full-fledged hosting now, and more
Date: Wed, 11 Oct 2006 02:30:51 +0200
Message-ID: <20061011003051.GS20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Oct 11 02:32:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXRzu-0005VM-R7
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 02:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030726AbWJKAay (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 20:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030727AbWJKAay
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 20:30:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45756 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030726AbWJKAax (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 20:30:53 -0400
Received: (qmail 3637 invoked by uid 2001); 11 Oct 2006 02:30:51 +0200
To: git@vger.kernel.org
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28685>

  Hi,

  few weeks ago, I have announced repo.or.cz public mirroring service
which would snap repositories, mirror them and provide a gitweb
interface for them. While at it, it also aims to serve as a testbed
for various new cool gitweb-related enhancements.

  I have finally got around to enhance it some more. Here go the big
changes:


  (i) repo.or.cz now permits an alternative hosting model: instead of
mirroring a remote repository, you can push over SSH. This makes
repo.or.cz full-fledged public hosting service. Each developer can
create own account, and you can give push access to multiple developers
if you want to do the CVS-style development. Authentication is done
purely using SSH keys. Furthermore, _optional_ support for anonymous
pushing to a dedicated 'mob' branch is supported.


  (ii) Bunch of extra project fields have been added - you can now
customize short description, homepage URL, give a short README to be
shown at the project summary page, ...


  (iii) Reorganized and extended the online documentation; gitweb now
uses pathinfo URLs and is aliased to http://repo.or.cz/w/


  (iv) Select a project and click at the 'graphiclog' button; if you
have a javascript-capable browser, watch the fireworks. This gadget
(http://repo.or.cz/w/git-browser.git) is nearly year old now and
back then swooshed through the mailing list without much interest
(apart few "cool!" replies). And I positively *HATE* not having it
when I browse any project whose history is not totally linear.

  OTOH, I have almost zero javascript skills so I'm not gonna be able
to develop it much further. Will someone pick up the slack? It's pretty
nice but leaves much to be desired; more tight gitweb integration (make
it basically some kind of external gitweb plugin) would be great.


  (v) Basically all the infrastructure is available at

	http://repo.or.cz/w/repo.git

Please review the code, send patches, feel free to roll out your very
own...


  What now? Send me your ideas, or even patches! (Hey, the code is
public. ;-) It might be interesting to have some forking support: there
goes project X and anyone can setup project fork(X, foo) and push his
changes there. I currently think the best way to do it technically would
be to just set up a separate repository with alternate pointing to the
main repository's database, and only group the forks with the main
project in gitweb. Is there a demand for that?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
