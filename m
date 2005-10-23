From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: LCA2006 Git/Cogito tutorial
Date: Sun, 23 Oct 2005 12:33:43 -0300
Message-ID: <200510231533.j9NFXhOv019272@inti.inf.utfsm.cl>
References: <martin@catalyst.net.nz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Oct 23 20:50:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETkud-0000cd-UC
	for gcvg-git@gmane.org; Sun, 23 Oct 2005 20:49:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbVJWStl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Oct 2005 14:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbVJWStl
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Oct 2005 14:49:41 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:52706 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750963AbVJWStl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Oct 2005 14:49:41 -0400
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id j9NFXhOv019272;
	Sun, 23 Oct 2005 12:33:45 -0300
To: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
In-Reply-To: Message from "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> 
   of "Fri, 21 Oct 2005 15:59:06 +1300." <4358597A.6000306@catalyst.net.nz> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10499>

Martin Langhoff (CatalystIT) <martin@catalyst.net.nz> wrote:

[...]

> If you combine the coolness of git-merge.sh with the fact that
> cg-merge right now is buggy[*]... I'm starting to rely on doing
> cg-fetch and running git-merge.sh by hand.
> 
> * I just merged your latest fixes, knowing that they'd conflict on
> * cg-fetch, but the merge didn't say a thing a bout cg-fetch, and only
> * complained like this:
> 
>     MERGE ERROR: : Not handling case  ->  ->
> 
> But there were no conflicts at all in the tree! It seems to be that
> it's dropping the upstream changes it doesn't like.

It happens when a new file with the same name appears in both parents. For
example, we both see the need for a README file, and then I pull from you
and try to merge into my version.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
