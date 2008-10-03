From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-gui: Correctly set up locators in case of preset
	URL variable
Date: Fri, 3 Oct 2008 12:48:29 +0200
Message-ID: <20081003104829.GA10360@machine.or.cz>
References: <20080930195839.GK21310@spearce.org> <1223028826-10306-1-git-send-email-pasky@suse.cz> <20081003122329.432c6359@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org,
	Petr Baudis <petr.baudis@novartis.com>
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Fri Oct 03 12:50:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KliEx-0006jE-CQ
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 12:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752619AbYJCKsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 06:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbYJCKsb
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 06:48:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:49835 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbYJCKsb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 06:48:31 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 4138D3939B47; Fri,  3 Oct 2008 12:48:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20081003122329.432c6359@pc09.procura.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97411>

On Fri, Oct 03, 2008 at 12:23:29PM +0200, H.Merijn Brand wrote:
> On Fri,  3 Oct 2008 12:13:46 +0200, Petr Baudis <pasky@suse.cz> wrote:
> 
> > This patch fixes locators setup in case the URL variable is already set,
> > e.g. in the clone dialog during 'git gui clone'.
> 
> While you are working on git-gui's transport.tcl, would you consider a
> user setting to set the default for pushing tags to remote repositories?
> 
> After installation/update I always `fix' that by hand now.

Actually, I think for the time being I'm finished with transport.tcl,
I'm sorry. :-) I probably won't work further on git-gui now that my
Novartis stay is almost over. My last stab will be probably trying to
change locators support to use insteadOf and possibly configurability of
the publish dialog if people decide they want it.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
