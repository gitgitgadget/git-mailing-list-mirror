From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Subject: Re: [script] ge: export commits as patches
Date: Wed, 20 Apr 2005 19:21:43 +0200
Message-ID: <dn7jix8iu0.fsf@magla.zg.iskon.hr>
References: <20050419134843.GA19146@elte.hu>
Reply-To: zlatko.calusic@iskon.hr
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 19:23:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOIuZ-0004Sx-Cb
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 19:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVDTRZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 13:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVDTRWx
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 13:22:53 -0400
Received: from mxout2.iskon.hr ([213.191.128.16]:33707 "HELO mxout2.iskon.hr")
	by vger.kernel.org with SMTP id S261762AbVDTRVu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 13:21:50 -0400
Received: (qmail 18107 invoked from network); 20 Apr 2005 19:21:44 +0200
X-Remote-IP: 213.191.142.124
Received: from unknown (HELO mx.iskon.hr) (213.191.142.124)
  by mxout2.iskon.hr with SMTP; 20 Apr 2005 19:21:44 +0200
Received: (qmail 7320 invoked from network); 20 Apr 2005 19:21:44 +0200
X-Remote-IP: 213.191.128.21
Received: from oganj.iskon.hr (HELO magla.zg.iskon.hr) (213.191.128.21)
  by mx.iskon.hr with SMTP; 20 Apr 2005 19:21:43 +0200
Received: (qmail 5501 invoked by uid 804); 20 Apr 2005 19:21:43 +0200
To: Ingo Molnar <mingo@elte.hu>
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
In-Reply-To: <20050419134843.GA19146@elte.hu> (Ingo Molnar's message of
 "Tue, 19 Apr 2005 15:48:43 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> TREE1=$(cat-file commit 2>/dev/null $1 | head -4 | grep ^tree | cut -d' ' -f2)
                                         --------------------------------------

And to make it easier on your eyes, you can always rewrite stuff like
that (mentioned everywhere these days :)) like:

TREE1=$(cat-file commit 2>/dev/null $1 | awk '/^tree/ {print $2}'
                                         ------------------------

No, I'm definitely not trying to save some CPU cycles, CPU cycles are
cheap, eyes are expensive! :)
-- 
Zlatko
