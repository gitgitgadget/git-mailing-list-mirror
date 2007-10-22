From: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
Subject: Re: [PATCH] git-cherry-pick: improve description of -x.
Date: Mon, 22 Oct 2007 07:19:08 +0200
Organization: Department of Numerical Simulation, University of Bonn
Message-ID: <20071022051908.GA16164@ins.uni-bonn.de>
References: <20071019174134.GD9906@ins.uni-bonn.de> <20071019211152.GN3917@planck.djpig.de> <20071020031917.GR14735@spearce.org> <20071021093618.GC12794@ins.uni-bonn.de> <20071022051453.GM14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:19:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjphC-0002wP-Nt
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751625AbXJVFTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbXJVFTL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:19:11 -0400
Received: from merkur.ins.uni-bonn.de ([131.220.223.13]:56787 "EHLO
	merkur.ins.uni-bonn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbXJVFTL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:19:11 -0400
Received: from localhost.localdomain (xdsl-87-78-69-149.netcologne.de [87.78.69.149])
	by merkur.ins.uni-bonn.de (Postfix) with ESMTP id 43E0A40000237;
	Mon, 22 Oct 2007 07:19:09 +0200 (CEST)
Received: from ralf by localhost.localdomain with local (Exim 4.63)
	(envelope-from <Ralf.Wildenhues@gmx.de>)
	id 1Ijpgy-0005Hy-Mn; Mon, 22 Oct 2007 07:19:08 +0200
Mail-Followup-To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071022051453.GM14735@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61934>

* Shawn O. Pearce wrote on Mon, Oct 22, 2007 at 07:14:53AM CEST:
> 
> I think you are right that the current behavior of -x *not*
> including the prior commit SHA-1 in the case of a conflict is wrong.
> The problem however is that git-commit.sh doesn't get the data
> necessary to preseve the original author name/email/date/tz unless
> you use the "-c $id" option.

But the note added by -x is even missing when I add "-c $id" to
the git-commit command!  That's the point I was trying to make,
and really the only thing that seemed weird to me.

Cheers,
Ralf
