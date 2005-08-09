From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Make git-rev-tree obsolete
Date: Tue, 9 Aug 2005 00:48:34 -0400
Message-ID: <20050809044834.GA13404@havoc.gtf.org>
References: <Pine.LNX.4.63.0508090222190.4076@wgmdd8.biozentrum.uni-wuerzburg.de> <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 06:48:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2M2b-0006Lz-Cb
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 06:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbVHIEsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Aug 2005 00:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750935AbVHIEsi
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 00:48:38 -0400
Received: from havoc.gtf.org ([69.61.125.42]:21383 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750939AbVHIEsi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 00:48:38 -0400
Received: from havoc.gtf.org (havoc.gtf.org [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by havoc.gtf.org (Postfix) with ESMTP id 4FCBE1C3A254;
	Tue,  9 Aug 2005 00:48:35 -0400 (EDT)
Received: (from garzik@localhost)
	by havoc.gtf.org (8.13.1/8.13.1/Submit) id j794mYSA013507;
	Tue, 9 Aug 2005 00:48:34 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhddzygcp.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 08, 2005 at 07:49:26PM -0700, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Junio remarked that Jeff's git-changes-script still uses git-rev-tree, and 
> > therefore it should not be removed. This patch changes git-changes-script 
> > over to git-rev-list:
> 
> Just to make things clear, "Junio remarked" that Cogito also
> seems to use it as well, so git-rev-tree is not going away.

git-changes-script is basically an old Cogito script, as you can see
from looking at the source code.

I only use it for

	cd /repos/misc-2.6
	git-changes-script -L ../linux-2.6

i.e. where there are two separate trees, rather than separate branches
that I normally work with.

	Jeff
