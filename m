From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/7] limit the usage of the default remote "origin" to
	the minimum
Date: Tue, 29 Apr 2008 23:42:10 +0200
Message-ID: <20080429214210.GB2413@steel.home>
References: <4812DA50.3000702@gnu.org> <cover.1209391614.git.bonzini@gnu.org> <20080429193536.GA19340@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, johannes.schindelin@gmx.de,
	srb@cuci.nl
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 23:43:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqxbN-0003za-Cw
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 23:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752799AbYD2VmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 17:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752686AbYD2VmO
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 17:42:14 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:49229 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbYD2VmN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 17:42:13 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarO+D1WRsg==
Received: from tigra.home (Fabc8.f.strato-dslnet.de [195.4.171.200])
	by post.webmailer.de (fruni mo22) (RZmta 16.27)
	with ESMTP id R062e6k3TK1SsR ; Tue, 29 Apr 2008 23:42:11 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B85B9277BD;
	Tue, 29 Apr 2008 23:42:10 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8680A56D28; Tue, 29 Apr 2008 23:42:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080429193536.GA19340@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80748>

Jeff King, Tue, Apr 29, 2008 21:35:36 +0200:
> On Mon, Apr 28, 2008 at 05:23:53PM +0200, Paolo Bonzini wrote:
> > This patch may cause incompatibilities to be warned about in
> > the release notes.  Luckily, these incompatibilities only affect
> > users that already know their way in .git/config, because no porcelain
> > command creates push refspecs.
> 
> I think you understand the compatibility issues, but I think it needs to
> be not "warned in the release notes" but "warned in the release notes,
> followed by a period of adjustment, and then the change". And maybe it
> would even make sense to wait for a larger-number version change (like
> 1.6.0).

But please, make this "period of adjustment" actually visible to the
USER WHO DOES NOT READ RELEASE NOTES. Say loud and clear when you do
something different. And better yet - do not do anything unexpected
just yet. Describe it, print instructions about changing
configuration. So that next less-minor-release with changed behavior
(but the warning still in place) is less of a surprise.
