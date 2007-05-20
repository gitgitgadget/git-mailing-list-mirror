From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Commit ID in exported Tar Ball
Date: Sun, 20 May 2007 18:10:48 +0200
Message-ID: <20070520161048.GI5015@cip.informatik.uni-erlangen.de>
References: <20070517163803.GE4095@cip.informatik.uni-erlangen.de> <200705171857.22891.johan@herland.net> <20070517171150.GL5272@planck.djpig.de> <464F5CA2.3070809@lsrfire.ath.cx> <7vd50wv88t.fsf@assigned-by-dhcp.cox.net> <20070520035752.GG3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Gernoth <simigern@cip.informatik.uni-erlangen.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 20 18:10:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hpnzk-0005lu-28
	for gcvg-git@gmane.org; Sun, 20 May 2007 18:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757478AbXETQKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757346AbXETQKv
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 12:10:51 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:55814 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757478AbXETQKu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 May 2007 12:10:50 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id 08B533F3A5; Sun, 20 May 2007 18:10:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070520035752.GG3141@spearce.org>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47850>

Hello,

> git-describe is more human-friendly than a SHA-1...

For me git-describe does the following:

        (thinkpad) [~/work/slides] git-describe --all HEAD
        heads/master

I don't see how Michael is able to tell from this output what version
his users is using. Do I miss something? I really do like the patch Rene
has submitted. And it is exactly what is missing. A unique identifier
which tells the exact version of the tree the user is using.

        Thomas
