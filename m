From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Internationalization of git-gui
Date: Sat, 21 Jul 2007 15:57:22 -0700
Message-ID: <7vvecdtlf1.fsf@assigned-by-dhcp.cox.net>
References: <7vodi7vtct.fsf@assigned-by-dhcp.cox.net>
	<200707210815.l6L8F2Da032066@mi0.bluebottle.com>
	<7vr6n2upwv.fsf@assigned-by-dhcp.cox.net>
	<4d8e3fd30707211157l1be243basfb259082b7aa8160@mail.gmail.com>
	<Pine.LNX.4.64.0707212224480.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	=?utf-8?B?44GX44KJ44GE?= =?utf-8?B?44GX44Gq44Gq44GT?= 
	<nanako3@bluebottle.com>, "Shawn O. Pearce" <spearce@spearce.org>,
	Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 22 00:57:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICNtB-0002Xi-49
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 00:57:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXGUW5Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 18:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbXGUW5Z
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 18:57:25 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34072 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbXGUW5Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 18:57:24 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070721225724.GVVJ1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Jul 2007 18:57:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SNxP1X0051kojtg0000000; Sat, 21 Jul 2007 18:57:23 -0400
In-Reply-To: <Pine.LNX.4.64.0707212224480.14781@racer.site> (Johannes
	Schindelin's message of "Sat, 21 Jul 2007 22:25:28 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53194>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> paolo@paolo-desktop:~/git-gui-i18n$ ls po/
>> de.msg  de.po  glossary.csv  ja.msg  ja.po
>> 
>> There is "po/git-gui.pot" file in my repository.
>
> My fault.  I was rebasing Junio's patch on top of Christian's new series.  
> Alas, the PO_TEMPLATE was no longer created by default.
>
> Should be fixed now.

Note that if everybody agrees that the division of labor between
the developer, the i18n coordinator and translators I suggested
in the earlier message is the way to go, po/git-gui.pot should
be managed by the i18n coordinator and revision tracked in-tree.
Simple "make" should not try to update it for ordinary people,
but we can have a "i18n coordinator only" maintenance target to
update it.

That way, translators do not have to touch anything other than
their own po/xx.po files.
