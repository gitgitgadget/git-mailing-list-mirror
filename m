From: Junio C Hamano <junkio@cox.net>
Subject: Re: Something wrong with pickaxe?
Date: Thu, 19 Jan 2006 10:24:50 -0800
Message-ID: <7vfynkdqj1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0601190004130.15298@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601181541150.3240@g5.osdl.org>
	<7v3bjlt66q.fsf@assigned-by-dhcp.cox.net> <43CF5816.1010004@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 19:28:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzeSx-0001kX-IW
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 19:24:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWASSYy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 13:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWASSYy
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 13:24:54 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11212 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030275AbWASSYx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2006 13:24:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060119182253.LHKC17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 Jan 2006 13:22:53 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14922>

Andreas Ericsson <ae@op5.se> writes:

>> True again.  It is hard to be "more friendly" without actually
>> generating a diff ;-).
>
> I thought generating diffs was fairly cheap...

Probably.  But we currently do not do diff generation
internally, so the comparison is "now doing diff with N lines of
code" vs "having 0 lines of code to do diff".

> ... I give it a function name to search for and want to
> know when the calling semantics changed for that function.

"Calling semantics" meaning "function signature"?
