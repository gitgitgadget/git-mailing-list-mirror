From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH v2 08/16] remote-helpers: Support custom transport
	options
Date: Tue, 13 Oct 2009 13:52:58 -0700
Message-ID: <20091013205258.GD9261@spearce.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-9-git-send-email-spearce@spearce.org> <alpine.LNX.2.00.0910122357230.32515@iabervon.org> <20091013184531.GB9261@spearce.org> <alpine.LNX.2.00.0910131550170.32515@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 22:58:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxoRz-0006dS-Or
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 22:58:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760626AbZJMUxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 16:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760371AbZJMUxf
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 16:53:35 -0400
Received: from george.spearce.org ([209.20.77.23]:36599 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbZJMUxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 16:53:34 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9B0B6381FE; Tue, 13 Oct 2009 20:52:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0910131550170.32515@iabervon.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130208>

Daniel Barkalow <barkalow@iabervon.org> wrote:
> On Tue, 13 Oct 2009, Shawn O. Pearce wrote:
> > > > +'option thin'::
> > > > +	Transfer the data as a thin pack if possible.
> > > 
> > > Does anyone still use non-default thinness? 
> > 
> > Its a command line option on the porcelain.
> 
> Actually, the command line supports turning it on, and it defaults to on. 
> So I think your helper can safely assume that it's on. :)

For fetch it defaults to "on", but for push I think it defaults
to "off".  Turning it on when pushing on a low bandwidth network
connection might actually be useful to an end-user.

-- 
Shawn.
