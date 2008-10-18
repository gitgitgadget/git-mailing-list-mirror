From: Paul Mackerras <paulus@samba.org>
Subject: Re: [Gitk Patch 0/6]
Date: Sat, 18 Oct 2008 23:11:22 +1100
Message-ID: <18681.53866.855255.688290@cargo.ozlabs.ibm.com>
References: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Sat Oct 18 14:19:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrAlo-0002qt-60
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 14:19:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbYJRMQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYJRMQ2
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 08:16:28 -0400
Received: from ozlabs.org ([203.10.76.45]:57823 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466AbYJRMQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 08:16:27 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 23309DDDF0; Sat, 18 Oct 2008 23:16:26 +1100 (EST)
In-Reply-To: <1223532590-8706-1-git-send-email-robin.rosenberg@dewire.com>
X-Mailer: VM 8.0.9 under Emacs 22.2.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98541>

Robin Rosenberg writes:

> I finally got tired of pressing Alt and some letter to activate menus in Gitk. 
> For example in "any" program you can press Alt-F to have the File menu drop 
> down and then select the underscored character to select the wanted menu.
> 
> This series makes it possible. Friends of TCL may think my solution is too
> hack-ish. It doesn't fix all of the similary problem (mostly button) but 
> that is the subject of later patches as it looks like it requires other
> means.

Have a look at what I just pushed out.  It adds infrastructure to let
us use "&" in menu items to specify an alt+letter accelerator, but in
a different way to your patches.  If you'd like to redo your patch to
add "&" to the menu items, that would be good.

Paul.
