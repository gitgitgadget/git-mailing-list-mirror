From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: Fixed _main window_ for screen height equal
	600 px
Date: Mon, 12 Oct 2009 07:34:18 -0700
Message-ID: <20091012143418.GK9261@spearce.org>
References: <1255329194-2757-1-git-send-email-vietor@vxwo.org> <alpine.DEB.1.00.0910120934420.4985@pacific.mpi-cbg.de> <1255335812.2326.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Vietor Liu <vietor@vxwo.org>
X-From: git-owner@vger.kernel.org Mon Oct 12 16:40:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxM4T-0002uT-38
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 16:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001AbZJLOe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756999AbZJLOe4
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 10:34:56 -0400
Received: from george.spearce.org ([209.20.77.23]:40035 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756991AbZJLOe4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 10:34:56 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 534ED381FF; Mon, 12 Oct 2009 14:34:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1255335812.2326.20.camel@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130021>

Vietor Liu <vietor@vxwo.org> wrote:
> On Mon, 2009-10-12 at 09:35 +0200, Johannes Schindelin wrote:
> >  
> > So what you _actually_ do is reduce the space for the diff, no?

Dscho, I think what's happening is he is shrinking the minimum height
of the diff pane.  By allowing it to be shorter he is trading diff
pane space in order to make room for the fixed height commit message
area below it.
 
> Yes. 
> The _main window_ support auto resize. I was tested some way, only
> modify _diff body_ space could work. The _diff body_ is part of _main
> window_. 
> 
> Whether modify the commit message? 

Yes, please modify the commit message.  The message does not clearly
state what is occurring here, which is why Dsco had an issue.

Really you are trying to adjust the minimum height of the diff
pane, which is resizable, so that it can use less vertical height,
allowing the overall window to be shorter and still display the
entire commit pane.

Also, I find your use of underscores around widget names to be
very difficult to read.  I don't see a reason for it in the commit
message.

-- 
Shawn.
