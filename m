From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH] [BUG] Add a test to check git-prune does not throw away revs hidden by a graft.
Date: Fri, 19 May 2006 20:55:58 +0200
Message-ID: <20060519185558.GE6535@nowhere.earth>
References: <20060518213519.14577.67309.stgit@gandelf.nowhere.earth> <Pine.LNX.4.64.0605181435230.10823@g5.osdl.org> <7viro3nh07.fsf@assigned-by-dhcp.cox.net> <20060518222045.GB6535@nowhere.earth> <20060518225216.GC6535@nowhere.earth> <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 20:44:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh9xQ-00081I-WA
	for gcvg-git@gmane.org; Fri, 19 May 2006 20:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964793AbWESSoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 14:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964792AbWESSoN
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 14:44:13 -0400
Received: from smtp4-g19.free.fr ([212.27.42.30]:49808 "EHLO smtp4-g19.free.fr")
	by vger.kernel.org with ESMTP id S964793AbWESSoN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 14:44:13 -0400
Received: from bylbo.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp4-g19.free.fr (Postfix) with ESMTP id D9FD354974;
	Fri, 19 May 2006 20:44:11 +0200 (CEST)
Received: from dwitch by bylbo.nowhere.earth with local (Exim 4.62)
	(envelope-from <ydirson@altern.org>)
	id 1FhA8m-0003p3-48; Fri, 19 May 2006 20:56:00 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vsln7lzbj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20351>

On Thu, May 18, 2006 at 03:53:36PM -0700, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > To make my point maybe more clear: if someone really wants to make a
> > graft permanent, wouldn't some history rewriting ... be the
> > way to go,...
> 
> Yes.

So if temporary usage is a typical use for grafts, don't we want to
protect people using them from pruning ?  I got no feedback to my
suggestion of changing the default behaviour, even to say it was a bad
idea :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
