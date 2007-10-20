From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH-resent] gitk: fix in procedure drawcommits
Date: Sat, 20 Oct 2007 20:16:24 +1000
Message-ID: <18201.54648.707559.480169@cargo.ozlabs.ibm.com>
References: <20071019052823.GI14735@spearce.org>
	<200710191544.22228.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Sat Oct 20 12:24:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjBUw-0006fV-4I
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 12:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756134AbXJTKXu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 06:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756018AbXJTKXu
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 06:23:50 -0400
Received: from ozlabs.org ([203.10.76.45]:59163 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756076AbXJTKXt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 06:23:49 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id C9D2DDDEBB; Sat, 20 Oct 2007 20:23:48 +1000 (EST)
In-Reply-To: <200710191544.22228.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61816>

Michele Ballabio writes:

> This patch indroduces a check before unsetting an array element.

introduces

> There's an error that seems to occur in gitk only on
> mutt's imported repo, but I don't know why. This is
> hopefully the right fix.

Well no.  I'd rather understand why this is happening, in case the
error indicates that I'm not handling a corner case correctly.  Can
you make a copy of the repo that triggers the bug available to me?

Paul.
