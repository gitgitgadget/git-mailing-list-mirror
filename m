From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 2/2] gitk: Markup many strings for translation.
Date: Sat, 28 Jul 2007 16:21:33 +1000
Message-ID: <18090.57453.466507.354727@cargo.ozlabs.ibm.com>
References: <20070727165318.e96b1yxxwsooo884@webmail.tu-harburg.de>
	<20070727170300.t01ku4u2sg04sgsk@webmail.tu-harburg.de>
	<18090.44123.905869.974967@cargo.ozlabs.ibm.com>
	<7vvec5uo01.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Christian Stimming <stimming@tuhh.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 08:21:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEfgQ-0005kd-Db
	for gcvg-git@gmane.org; Sat, 28 Jul 2007 08:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbXG1GVn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 Jul 2007 02:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753505AbXG1GVn
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jul 2007 02:21:43 -0400
Received: from ozlabs.org ([203.10.76.45]:54172 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753403AbXG1GVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2007 02:21:42 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 12D18DDE27; Sat, 28 Jul 2007 16:21:41 +1000 (EST)
In-Reply-To: <7vvec5uo01.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53995>

Junio C Hamano writes:

> My preference is 1.b, as the longer term plan (when everybody
> has git 1.5.2 or newer) is to eject git-gui.git project from
> git.git proper, and use the subproject feature to have
> git-gui.git in git.git; it would be good if gitk.git can be
> handled the same way, and the layout 1.b would make it the
> easiest, as it matches how we treat git-gui.git project now.

1.b sounds fine to me too.

> You also expressed in a separate message about "catching package
> require msgcat to avoid breakage".  I think msgcat package is
> part of the standard Tcl distribution since 8.1; how old a
> tcl/tk do you support?

Gitk requires 8.4, so that sounds OK then.  I didn't realize it had
been part of the standard distribution for so long.

> In any case, I would very much appreciate if any of these will
> *NOT* happen before 1.5.3.  git-gui 0.8.0 which is scheduled to
> be in 1.5.3 will not have i18n.

No problem. :)

By the way, could you do a pull from gitk.git?  There are some
bug-fixes plus the change to show the index and working directory as
separate fake commits, as requested by Linus.

Paul.
