From: Paul Mackerras <paulus@samba.org>
Subject: Re: any problems with new branch of gitk?
Date: Wed, 15 Mar 2006 22:18:45 +1100
Message-ID: <17431.63509.670409.212654@cargo.ozlabs.ibm.com>
References: <17419.24973.402408.237865@cargo.ozlabs.ibm.com>
	<20060306202340.GA5946@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 15 13:06:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJUm5-0001pb-Ju
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 13:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751954AbWCOMG0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 07:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCOMG0
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 07:06:26 -0500
Received: from ozlabs.org ([203.10.76.45]:46025 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751954AbWCOMG0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Mar 2006 07:06:26 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 7A975679EB; Wed, 15 Mar 2006 23:06:25 +1100 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060306202340.GA5946@steel.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17606>

Alex Riesen writes:

> I don't if that was intended (see the screenshot attached), but some
> lines miss arrows. Click on where the arrow would be works (jump to
> counterpart arrow). Never have this with the old gitk.
> 
> Tcl/Tk 8.4.9 (Gentoo).

Yes, it seems that tk 8.4 can't draw arrows on the ends of diagonal
line segments.  The old gitk coped with this by simply shortening the
line until it got to a vertical line segment.  I can probably do
better than that with the new layout algorithm.  I'll look at it.

Paul.
