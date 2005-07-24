From: Wolfgang Denk <wd@denx.de>
Subject: Re: Should cg-mkpatch output be usable with cg-patch?
Date: Sun, 24 Jul 2005 19:50:18 +0200
Message-ID: <20050724175018.3D721352B73@atlas.denx.de>
References: <20050720234904.B3ED735267C@atlas.denx.de> <20050722210352.GG11916@pasky.ji.cz>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 24 19:51:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dwkcy-000708-5O
	for gcvg-git@gmane.org; Sun, 24 Jul 2005 19:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVGXRuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jul 2005 13:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVGXRuj
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jul 2005 13:50:39 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:31695 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261219AbVGXRuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2005 13:50:37 -0400
Received: from fwd27.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1DwkcU-0007Ay-04; Sun, 24 Jul 2005 19:50:34 +0200
Received: from denx.de (ZB+OJiZTre+sL2UbSyhiH3b7uzxUOHMwunY95AEsStu0-cXQvJP8gh@[84.150.77.91]) by fwd27.sul.t-online.de
	with esmtp id 1DwkcF-20YKSu0; Sun, 24 Jul 2005 19:50:19 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 7560F42C04; Sun, 24 Jul 2005 19:50:18 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 3D721352B73;
	Sun, 24 Jul 2005 19:50:18 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: <20050722210352.GG11916@pasky.ji.cz> 
Comments: In-reply-to Petr Baudis <pasky@suse.cz>
   message dated "Fri, 22 Jul 2005 23:03:52 +0200."
X-ID: ZB+OJiZTre+sL2UbSyhiH3b7uzxUOHMwunY95AEsStu0-cXQvJP8gh@t-dialin.net
X-TOI-MSGID: 3f584630-031a-49c9-89ef-b7ff345699fa
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <20050722210352.GG11916@pasky.ji.cz> you wrote:
>
> > I wander what I should do with "cg-mkpatch" generated output;  I  had
> > the  impression that this should be usable with "cg-patch", but these
> > are incompatible with each other.
> 
> They certainly aren't.

Is this a problem with the current implementation, or intentional?

> > 	diff --git a/tools/img2brec.sh b/tools/img2brec.sh
> > 	old mode 100644
> > 	new mode 100755
> > 	...
> > If I feed this into "cg-patch", I get:
> > 	patch: **** Only garbage was found in the patch input.
> 
> And did the changes apply? :-)

No, they did not. No file modes were changed.

> The message is surely confusing, but appeared to be rather corner-casy
> and after I imagined the required complexity of filtering this, I
> decided to spend my time on something more useful for the time being. :)

I don't think this is a corner case. I think it is  pretty  important
to be able to promote permissiong changes.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Too many people are ready to carry the stool when the piano needs  to
be moved.
