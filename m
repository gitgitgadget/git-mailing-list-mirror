From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 02:38:37 +0100
Message-ID: <20051119013837.GA3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <437DDDB1.60103@b-i-t.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 02:38:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdHfM-00030E-7N
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 02:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161110AbVKSBhR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 20:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKSBhQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 20:37:16 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:23986 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1161110AbVKSBhP (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 20:37:15 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 957C08AD5;
	Sat, 19 Nov 2005 02:37:14 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdHgd-0006Z1-Ed; Sat, 19 Nov 2005 02:38:39 +0100
To: sf <sf@b-i-t.de>
Content-Disposition: inline
In-Reply-To: <437DDDB1.60103@b-i-t.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12319>

On Fri, Nov 18, 2005 at 02:57:05PM +0100, sf wrote:
> >Indeed that emphasizes that the history lines are on living on a
> >higher level of abstraction that commits.  Now what if we used
> >trees->tree commits, instead of the current commits->tree ones ?  The
> >main problem would be to be able to reconstruct those history lines,
> >so that we can still extract the log - what's a better model if we
> >loose functionnality ? ;)
> 
> You can traverse tree -> commit -> tree -> commit -> tree ... to get the 
> history. No functionality lost.

No, that would require that a tree knows about the commits leading to
it, which would mix levels of abstraction as well.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
