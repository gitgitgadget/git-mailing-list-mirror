From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RESEND PATCH] fast-import: Cleanup mode setting.
Date: Tue, 13 Jan 2009 18:29:33 -0800
Message-ID: <20090114022933.GX10179@spearce.org>
References: <1231897027-16197-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0901140308200.3586@pacific.mpi-cbg.de> <20090114021751.GW10179@spearce.org> <alpine.DEB.1.00.0901140326530.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Miklos Vajna <vmiklos@frugalware.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 03:31:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMvX4-0003Ll-Nf
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 03:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbZANC3f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 21:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbZANC3e
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 21:29:34 -0500
Received: from george.spearce.org ([209.20.77.23]:56157 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbZANC3e (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 21:29:34 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6C77438210; Wed, 14 Jan 2009 02:29:33 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901140326530.3586@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105576>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 13 Jan 2009, Shawn O. Pearce wrote:
> > 
> > It cleans up the code to make it more readable.
> > 
> > It makes no sense to be doing S_IFREG | S_IFLINK, which happens when
> > the input is for a symlink.  It doesn't break anything to do that |
> > operation, but it also looks damn odd when reading the function.
> 
> Imagining myself reading the commit message 6 months from now, in all 
> likeliness I will have wished that those two paragraphs were in there.  
> Verbatim.

Maybe Junio or Felipe can copy it into the message.

Or you can use a git note now to attach it to the commit Junio
hasn't yet created, so you can look it up in the future.  :-)

-- 
Shawn.
