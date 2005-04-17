From: Nomad Arton <lkml@lazy.shacknet.nu>
Subject: Re: using git directory cache code in darcs?
Date: Mon, 18 Apr 2005 00:37:00 +0200
Message-ID: <4262E50C.2070006@lazy.shacknet.nu>
References: <20050416132231.GJ2551@abridgegame.org> <Pine.LNX.4.58.0504161531470.7211@ppc970.osdl.org> <20050417121712.GA22772@abridgegame.org> <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 00:33:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNIKO-00027P-Gv
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 00:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVDQWhG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVDQWhG
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:37:06 -0400
Received: from viefep14-int.chello.at ([213.46.255.13]:63583 "EHLO
	viefep14-int.chello.at") by vger.kernel.org with ESMTP
	id S261533AbVDQWhB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:37:01 -0400
Received: from lazy.shacknet.nu ([80.109.132.21]) by viefep14-int.chello.at
          (InterMail vM.6.01.04.04 201-2131-118-104-20050224) with ESMTP
          id <20050417223659.TCCV7053.viefep14-int.chello.at@lazy.shacknet.nu>
          for <git@vger.kernel.org>; Mon, 18 Apr 2005 00:36:59 +0200
Received: from localhost ([127.0.0.1])
	by lazy.shacknet.nu with esmtp (Exim 3.36 #1 (Debian))
	id 1DNINw-0002Si-00
	for <git@vger.kernel.org>; Mon, 18 Apr 2005 00:37:00 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: de-DE, de, en-us, en
In-Reply-To: <Pine.LNX.4.58.0504170916080.7211@ppc970.osdl.org>
To: unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds schrieb:
> 
> In fact, one of my hopes was that other SCM's could just use the git
> plumbing. But then I'd really suggest that you use "git" itself, not any
> "libgit". Ie you take _all_ the plumbing as real programs, and instead of
> trying to link against individual routines, you'd _script_ it.

please excuse; libgit and scripting to me arent a contradiction. many 
sripting languages are extended by C modules, while still happening to 
have all the scripting rapidity. its just a matter of how to communicate 
with the C code, isnt it?

yours,

peter
