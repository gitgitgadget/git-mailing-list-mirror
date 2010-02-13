From: Johan Herland <johan@herland.net>
Subject: Re: Commit annotations (editable commit messages)
Date: Sat, 13 Feb 2010 22:46:04 +0100
Message-ID: <201002132246.04558.johan@herland.net>
References: <op.u71cw50km02fvl@cybershadow.mshome.net>
 <op.u71e00v4m02fvl@cybershadow.mshome.net>
 <ca433831002121701u7c4e47ddn2f8bc19c45b2bd03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Mark Lodato <lodatom@gmail.com>,
	Vladimir Panteleev <thecybershadow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 13 22:46:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPof-00038C-D2
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124Ab0BMVqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:46:11 -0500
Received: from smtp.getmail.no ([84.208.15.66]:36783 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989Ab0BMVqK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:46:10 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00FV9V4U5490@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:46:06 +0100 (MET)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00A4OV4TBL10@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:46:06 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.213630
User-Agent: KMail/1.13.0 (Linux/2.6.32-ARCH; KDE/4.4.0; x86_64; ; )
In-reply-to: <ca433831002121701u7c4e47ddn2f8bc19c45b2bd03@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139863>

On Saturday 13 February 2010, Mark Lodato wrote:
> 2010/2/12 Vladimir Panteleev <thecybershadow@gmail.com>:
> > The documentation looks pretty scant. Does anyone know how close were
> > my suggestions to the actual implemented behavior (esp. regarding
> > rebasing)?
> 
> 1, 2, 3, and 4 are all implemented, as far as I know.  However, I
> don't think notes copy during a rebase.

The last patch of the latest iteration of the jh/notes series (posted 5 
minutes ago) adds a "git notes copy" command that does just this. Patching 
rebase/cherry-pick/amend to call "git notes copy" should be fairly 
straightforward.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
