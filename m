From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 14:27:20 +0100
Message-ID: <20051119132720.GC3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de> <Pine.LNX.4.64.0511180915560.13959@g5.osdl.org> <7v3bltea1t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511181705390.13959@g5.osdl.org> <7vr79dcu0j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 14:27:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdSj7-0004tA-LV
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 14:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbVKSNZy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 08:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbVKSNZy
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 08:25:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:11987 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751107AbVKSNZy (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 08:25:54 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 711C93727D;
	Sat, 19 Nov 2005 14:25:52 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdSkS-0007Ae-Kc; Sat, 19 Nov 2005 14:27:20 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr79dcu0j.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12337>

On Fri, Nov 18, 2005 at 05:21:16PM -0800, Junio C Hamano wrote:
> I do not think tree-to-tree thing is very useful and that is
> what I meant to say by "tree-to-tree is still stronger than
> necessary".
> 
> What is recorded as a "change" by darcs feels more like "This
> makes it to do Y instead of doing X", and it is not about
> tree-to-tree.

I'm not sure we could go that path.  I see git and darcs as quite
opposed in approach, since darcs works by explicitely describing the
structure of changes, whereas git allows to use arbitrary ways to
derive this structure from the trees.

But then if we could reconcile those 2 approaches...

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
