From: Junio C Hamano <junkio@cox.net>
Subject: Re: quieter installs
Date: Sat, 02 Jun 2007 22:53:38 -0700
Message-ID: <7vfy59oa71.fsf@assigned-by-dhcp.cox.net>
References: <20070603010044.GA4507@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jun 03 07:53:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huj2D-0003Ev-Ef
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 07:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbXFCFxk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 01:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755118AbXFCFxk
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 01:53:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63966 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755023AbXFCFxk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 01:53:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070603055339.JSJA22318.fed1rmmtao101.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Jun 2007 01:53:39 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6tte1X00K1kojtg0000000; Sun, 03 Jun 2007 01:53:39 -0400
In-Reply-To: <20070603010044.GA4507@spearce.org> (Shawn O. Pearce's message of
	"Sat, 2 Jun 2007 21:00:44 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48975>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> So I'm looking at adding this to git-gui, to replace Alex's patch,
> as it addresses most of the issues that Junio raised.  Thoughts?
>
> I'm a little unhappy with how mess the install target is now, but
> fortunately most of it is data driven through the other variables in
> the Makefile, so hopefully I don't have to tweak it too frequently.
> ;-)

Good job.  I actually almost like it.

Without V=1, I get this from 'pu' that merged your 'pu'.

    ...
    make -C git-gui install
    make[1]: Entering directory `/git/git.git/git-gui'
      DEST /home/junio/git-pu/bin
        INSTALL 755 git-gui
        LINK        git-citool -> git-gui
      DEST /home/junio/git-pu/share//git-gui/lib
        INSTALL 644 tclIndex
        INSTALL 644 blame.tcl
        INSTALL 644 branch.tcl
        INSTALL 644 branch_rename.tcl
        INSTALL 644 browser.tcl
    ...

And with V=1, what I see seem very readable.
