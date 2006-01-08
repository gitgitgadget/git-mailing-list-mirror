From: Yann Dirson <ydirson@altern.org>
Subject: Re: [PATCH 4/7] Add a test for rebase when a change was picked upstream
Date: Sun, 8 Jan 2006 11:01:59 +0100
Message-ID: <20060108100159.GE32585@nowhere.earth>
References: <20060108003948.GL1113@nowhere.earth> <7v7j9b7922.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 08 10:59:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EvXKd-000139-7n
	for gcvg-git@gmane.org; Sun, 08 Jan 2006 10:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWAHJ7U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jan 2006 04:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030630AbWAHJ7U
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jan 2006 04:59:20 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41873 "EHLO smtp1-g19.free.fr")
	by vger.kernel.org with ESMTP id S1030629AbWAHJ7T (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jan 2006 04:59:19 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp1-g19.free.fr (Postfix) with ESMTP id E3B0E10C42;
	Sun,  8 Jan 2006 10:59:18 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.60)
	(envelope-from <ydirson@altern.org>)
	id 1EvXN9-0001Cp-Jv; Sun, 08 Jan 2006 11:01:59 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7j9b7922.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14314>

On Sat, Jan 07, 2006 at 06:22:29PM -0800, Junio C Hamano wrote:
> Yann Dirson <ydirson@altern.org> writes:
> 
> > +export GIT_AUTHOR_EMAIL=bogus_email_address
> 
> This is probably not needed for this test, although it would not
> hurt.

Inheritance from t3400 :)

> > +test_expect_success \
> > +    'rebase topic branch against new master and check git-am did not get halted' \
> > +    'sh -x git-rebase master &&
> > +     test ! -d .dotest
> > +'
> 
> Some people build git with SHELL_PATH=/bin/bash because their
> /bin/sh is not POSIX enough (e.g. Solaris).  Perhaps emulate
> what t5501 does?

Oh, that "sh -x" is only a forgotten debugging item, I'll drop it.

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
