From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: metastore (was: Track /etc directory using Git)
Date: Sat, 15 Sep 2007 23:14:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709152310380.28586@racer.site>
References: <20070915132632.GA31610@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151507310.28586@racer.site> <20070915145437.GA12875@piper.oerlikon.madduck.net>
 <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	"Thomas Harning Jr." <harningt@gmail.com>,
	Francis Moreau <francis.moro@gmail.com>,
	Nicolas Vilz <niv@iaglans.de>,
	David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Sep 16 00:15:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWfvF-00085v-Jg
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 00:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbXIOWPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 18:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751699AbXIOWPX
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 18:15:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:36249 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751600AbXIOWPX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 18:15:23 -0400
Received: (qmail invoked by alias); 15 Sep 2007 22:15:19 -0000
Received: from unknown (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 16 Sep 2007 00:15:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tsO9uAs3tjFC+l6eB54uy3yom94gCKoELe6HbUn
	+eIPdDuz2qbGXT
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709151430040.5298@iabervon.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58273>

Hi,

On Sat, 15 Sep 2007, Daniel Barkalow wrote:

> Git doesn't have any way to represent owners or groups, and they would 
> need to be represented carefully in order to make sense across multiple 
> computers.

[speaking mostly to the proponents of git-as-a-backup-tool]

While at it, you should invent a fallback what to do when the owner is not 
present on the system you check out on.  And a fallback when checking out 
on a filesystem that does not support owners.

And a fallback when a non-root user uses it.

Oh, and while you're at it (you said that it would be nice not to restrict 
git in any way: "it is a content tracker") support the Windows style 
"Group-or-User-or-something:[FRW]" ACLs.

Looking forward to your patches,
Dscho
