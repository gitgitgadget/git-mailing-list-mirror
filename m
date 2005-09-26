From: Paul Mackerras <paulus@samba.org>
Subject: Re: The latest commit to add new keybindings
Date: Mon, 26 Sep 2005 10:26:49 +1000
Message-ID: <17207.16457.551775.470665@cargo.ozlabs.ibm.com>
References: <7v4q8b8d5j.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 02:28:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJgqL-000257-JE
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 02:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbVIZA0l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 20:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbVIZA0l
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 20:26:41 -0400
Received: from ozlabs.org ([203.10.76.45]:38606 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751577AbVIZA0l (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 20:26:41 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 0782568351; Mon, 26 Sep 2005 10:26:40 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q8b8d5j.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9296>

Junio C Hamano writes:

> Do you actually require 8.4, or any reasonably recent wish would
> do?

Checking in the change from "wish" to "wish8.4" was a mistake - that
was a change I made for some tests, and I forgot to change it back.
However, gitk does need tk 8.4 or later, since it uses the panedwindow
widget, which tk 8.3 doesn't have.  I have tk8.5a2 installed here,
which is nice because it does antialiased fonts, although it is a bit
slower (clock format is much slower because they changed it from being
implemented in C to Tcl).

> With "${1+$@}", you are passing an empty parameter after '--'
> when gitk itself receives no parameter.  Maybe it is intended,
> maybe not...

No, it isn't intended, thanks for pointing that out.

Regards,
Paul.
