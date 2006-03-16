From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 23:57:19 -0800
Message-ID: <7vslpibz4w.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
	<7vek13ieap.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603151450070.3618@g5.osdl.org>
	<7vlkvbffhz.fsf@assigned-by-dhcp.cox.net>
	<20060316075324.GA19650@pfit.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 16 08:57:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJnMT-00007z-NS
	for gcvg-git@gmane.org; Thu, 16 Mar 2006 08:57:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbWCPH5W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Mar 2006 02:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752230AbWCPH5W
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Mar 2006 02:57:22 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:54010 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751930AbWCPH5V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Mar 2006 02:57:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060316075521.KQQS20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 16 Mar 2006 02:55:21 -0500
To: Qingning Huo <qhuo@mayhq.org>
In-Reply-To: <20060316075324.GA19650@pfit.vm.bytemark.co.uk> (Qingning Huo's
	message of "Thu, 16 Mar 2006 07:53:24 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17629>

Qingning Huo <qhuo@mayhq.org> writes:

> I cannot uninstall /usr/bin/git.  It is not under my control.  I am
> wondering whether I should move my home dir to the front of the PATH.

That's what I found your configuration quite unusual.

When people have standard system executable directories such as
/usr/bin and /bin and private directories like /home/$u/bin and
/usr/local/bin on their PATH, private directories always come
before the system directories, so that things in the system
directories (often you do not have write permission to) can be
overriden by private directories (which is under your control).
I've never seen anybody sane to have system path before private
ones.
