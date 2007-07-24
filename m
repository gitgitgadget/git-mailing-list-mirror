From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add glossary that can be converted into a po file for each language.
Date: Mon, 23 Jul 2007 23:56:53 -0700
Message-ID: <7vk5sqi91m.fsf@assigned-by-dhcp.cox.net>
References: <622391.43998.qm@web38909.mail.mud.yahoo.com>
	<200707212150.49351.stimming@tuhh.de>
	<7vabtpv43d.fsf@assigned-by-dhcp.cox.net>
	<200707232216.40300.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Brett Schwarz <brett_schwarz@yahoo.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 08:56:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDEKI-0002hm-Or
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 08:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754999AbXGXG44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 02:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754989AbXGXG44
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 02:56:56 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53161 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754473AbXGXG4z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 02:56:55 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070724065655.SXAW1358.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Jul 2007 02:56:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TJwt1X00H1kojtg0000000; Tue, 24 Jul 2007 02:56:54 -0400
In-Reply-To: <200707232216.40300.stimming@tuhh.de> (Christian Stimming's
	message of "Mon, 23 Jul 2007 22:16:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53528>

Christian Stimming <stimming@tuhh.de> writes:

> diff --git a/po/glossary/git-gui-glossary.txt b/po/glossary/git-gui-glossary.txt
> new file mode 100644
> index 0000000..e079bb2
> --- /dev/null
> +++ b/po/glossary/git-gui-glossary.txt
> @@ -0,0 +1,34 @@
> +"English Term (Dear translator: This file will never be visible to the user!)"	"English Definition (Dear translator: This file will never be visible to the user! It should only serve as a tool for you, the translator. Nothing more.)"
> +"amend"	""
> +"annotate"	""
> +"branch [noun]"	"A 'branch' is an active line of development."
> +"branch [verb]"	""
> +"checkout [noun]"	""
> +"checkout [verb]"	"The action of updating the working tree to a revision which was stored in the object database."
> +"commit [noun]"	"A single point in the git history."

I wonder.... couldn't this be written as a Tcl array that maps
word to its definition, marked with [mc] 'gettext'ese, perhaps,
glossary.tcl?  Then perhaps git-gui can include it and have a
user-visible glossary as part of its help system.

Am I dreaming, or too drunk?
