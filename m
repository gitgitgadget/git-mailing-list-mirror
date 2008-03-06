From: Paul Mackerras <paulus@samba.org>
Subject: Re: How to make gitk not overwrite my selection?
Date: Thu, 6 Mar 2008 21:34:30 +1100
Message-ID: <18383.51382.866732.308234@cargo.ozlabs.ibm.com>
References: <47CD6D1C.1080202@gmx.ch>
	<20080304230306.GA18246@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 12:36:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXEPB-0000FL-Pa
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 12:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753770AbYCFLgT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 06:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753950AbYCFLgT
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 06:36:19 -0500
Received: from ozlabs.org ([203.10.76.45]:44917 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753680AbYCFLgS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 06:36:18 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 3AEFADDF00; Thu,  6 Mar 2008 22:36:16 +1100 (EST)
In-Reply-To: <20080304230306.GA18246@sigill.intra.peff.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76376>

Jeff King writes:

> The patch below seems to work for me (see the "auto-select sha1" option
> under preferences). However, I don't actually know tcl, so I
> cargo-culted all of the option processing magic. Paul, if you want to
> take this patch, please read it carefully. ;)

Looks OK to me.  Care to re-send it with a Signed-off-by?  Oh, and
put "sha1" in capitals, i.e. "SHA1".

(Tcl is actually a very simple language, and there are man pages for
it; try "man Tcl" for a start. :)

Paul.
