From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 26 Jul 2007 07:48:40 +0200
Message-ID: <85ir8790lj.fsf@lola.goethe.zz>
References: <Pine.LNX.4.64.0707260630570.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 26 07:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDwDV-0001X0-1G
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 07:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbXGZFsu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 01:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753382AbXGZFsu
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 01:48:50 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:57566 "EHLO
	mail-in-04.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753279AbXGZFst (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 01:48:49 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 4095517F544;
	Thu, 26 Jul 2007 07:48:46 +0200 (CEST)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id EAE4813ED57;
	Thu, 26 Jul 2007 07:48:45 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-173.pools.arcor-ip.net [84.61.22.173])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id B87FE36E867;
	Thu, 26 Jul 2007 07:48:45 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id ADAC51C452FD; Thu, 26 Jul 2007 07:48:40 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.64.0707260630570.14781@racer.site> (Johannes Schindelin's message of "Thu\, 26 Jul 2007 06\:32\:07 +0100 \(BST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53772>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When you select the context menu item "Split Hunk" in the diff area,
> git-gui will now split the current hunk so that a new hunk starts at
> the current position.
>
> For this to work, apply has to be called with --unidiff-zero, since
> the new hunks can start or stop with a "-" or "+" line.

Unless one splits right at the beginning or end of an existing hunk,
wouldn't there be context which one could use?  Or does it confuse
patch when adjacent hunks have overlapping contexts?  At least if the
first hunk patches what is to be used as context in the second hunk, I
could imagine this.  And there is really no danger of losing synch in
this situation, anyhow.  So it would be more of a convenience thing
than anything else to be able to omit --unidiff-zero.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
