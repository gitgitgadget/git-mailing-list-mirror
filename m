From: Wolfgang Denk <wd@denx.de>
Subject: Re: "git cvsimport" with branches?
Date: Sun, 17 Jul 2005 12:15:59 +0200
Message-ID: <20050717101559.579C93525D1@atlas.denx.de>
References: <20050717084053.94D603525D1@atlas.denx.de> <pan.2005.07.17.09.37.58.463540@smurf.noris.de>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 12:19:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Du6En-0002L8-OS
	for gcvg-git@gmane.org; Sun, 17 Jul 2005 12:19:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVGQKSx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jul 2005 06:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261266AbVGQKSx
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jul 2005 06:18:53 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:25826 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261245AbVGQKRp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2005 06:17:45 -0400
Received: from fwd24.aul.t-online.de 
	by mailout08.sul.t-online.com with smtp 
	id 1Du6D4-0004gQ-02; Sun, 17 Jul 2005 12:17:22 +0200
Received: from denx.de (SgdU9EZage2hpFwi7Zq1ys179rPAFPN8f-7Vr1KCXsXBauIMKQKLwj@[84.150.113.51]) by fwd24.sul.t-online.de
	with esmtp id 1Du6Cz-0DjLPs0; Sun, 17 Jul 2005 12:17:17 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 3361C42882; Sun, 17 Jul 2005 12:17:15 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 579C93525D1;
	Sun, 17 Jul 2005 12:15:59 +0200 (MEST)
To: Matthias Urlichs <smurf@smurf.noris.de>
In-reply-to: <pan.2005.07.17.09.37.58.463540@smurf.noris.de> 
Comments: In-reply-to Matthias Urlichs <smurf@smurf.noris.de>
   message dated "Sun, 17 Jul 2005 11:37:59 +0200."
X-ID: SgdU9EZage2hpFwi7Zq1ys179rPAFPN8f-7Vr1KCXsXBauIMKQKLwj@t-dialin.net
X-TOI-MSGID: bc425a42-1c95-4c76-8fe1-88957834bee4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

In message <pan.2005.07.17.09.37.58.463540@smurf.noris.de> you wrote:
>
> > All my imports so far show just a linear line of development, and CVS
> > branch information seems lost.
> 
> Umm, exactly what did you do to visualize that? "gitk origin" obvioously
> shows only one branch, because CVS doesn't have merge infe. Use
> "gitk $(cat .git/revs/heads/*)" to show everything.

s/v/f/

I see. Thanks for pointing out. Umm... is there  a  way  to  manually
adjust  this  later?  I  can  identify the specific PatchSet(s) which
merge my CVS branches back into the trunk.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Either one of us, by himself, is expendable.  Both of us are not.
	-- Kirk, "The Devil in the Dark", stardate 3196.1
