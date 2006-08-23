From: Paul Mackerras <paulus@samba.org>
Subject: Re: Tiny default fonts in gitk
Date: Wed, 23 Aug 2006 16:37:58 +1000
Message-ID: <17643.63430.187776.878100@cargo.ozlabs.ibm.com>
References: <20060811100706.GA22767@bohr.gbar.dtu.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 08:48:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFmWx-0007zY-N3
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 08:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWHWGru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 02:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWHWGru
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 02:47:50 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:59520 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750969AbWHWGru (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Aug 2006 02:47:50 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 31D9E67CED; Wed, 23 Aug 2006 16:47:49 +1000 (EST)
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-Reply-To: <20060811100706.GA22767@bohr.gbar.dtu.dk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25898>

Peter Eriksen writes:

> Is it just some X/Tk setting causing this, or is point 9 just very
> small?  This is under Fedora Core 5.  Changing these sizes to 12 gives
> the text the same size as in the rest of the desktop.  It would be nice,
> if that was the default.

First, check what X thinks your display resolution (dots per inch)
is.  If it thinks the resolution is 75dpi but your monitor is doing
more like 100dpi that will make the fonts small.

Secondly, you can use control -KP+ and control-KP- to change the font
size.

Paul.
