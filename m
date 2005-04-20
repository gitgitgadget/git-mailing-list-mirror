From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 18:56:11 +0200
Message-ID: <dnbr898k0k.fsf@magla.zg.iskon.hr>
References: <20050419043938.GA23724@kroah.com>
	<20050419185807.GA1191@kroah.com>
	<Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org>
	<426583D5.2020308@mesatop.com>
	<Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
Reply-To: zlatko.calusic@iskon.hr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 18:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIQt-0007nc-2e
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 18:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261737AbVDTQ4Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 12:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVDTQ4Y
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 12:56:24 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:39587 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S261737AbVDTQ4R (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 12:56:17 -0400
Received: (qmail 12896 invoked from network); 20 Apr 2005 18:56:14 +0200
X-Remote-IP: 213.191.142.122
Received: from unknown (HELO mx.iskon.hr) (213.191.142.122)
  by mxout2.iskon.hr with SMTP; 20 Apr 2005 18:56:14 +0200
Received: (qmail 2347 invoked from network); 20 Apr 2005 18:56:13 +0200
X-Remote-IP: 213.191.128.21
Received: from oganj.iskon.hr (HELO magla.zg.iskon.hr) (213.191.128.21)
  by mx.iskon.hr with SMTP; 20 Apr 2005 18:56:13 +0200
Received: (qmail 4838 invoked by uid 804); 20 Apr 2005 18:56:13 +0200
To: Linus Torvalds <torvalds@osdl.org>
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
In-Reply-To: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 19 Apr 2005 15:38:17 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Real merges have no patches taking place _anywhere_. And they take about 
> half a second. Doing an "update" of your tree should _literally_ boil down 
> to
>
> 	#
> 	# "repo" needs to point to the repo we update from
> 	#
> 	rsync -avz --ignore-existing $repo/objects/. .git/objects/.

I see this -avz incantation mentioned everytime when rsync is
involved. But, is the -z part (compression) really necessary knowing
that we're dealing with an already compressed tree? Doesn't it put
additional strain on the rsync server without any benefit in this
case?

Or I might be too ignorant and not understand some internals well, but
then... I would like to know the reason. :)

Regards,
-- 
Zlatko
