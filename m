From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:38:32 +0200
Message-ID: <20071015173832.GB2966@steel.home>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <feud8j$kdg$1@ger.gmane.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, make-w32@gnu.org
To: Michael Gebetsroither <gebi@sbox.tugraz.at>
X-From: git-owner@vger.kernel.org Mon Oct 15 19:50:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhTtz-00046M-1q
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbXJORih (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757478AbXJORig
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:38:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:22434 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757339AbXJORif (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 13:38:35 -0400
Received: from tigra.home (Fc8e3.f.strato-dslnet.de [195.4.200.227])
	by post.webmailer.de (fruni mo20) (RZmta 13.4)
	with ESMTP id z02d7aj9FE0vNc ; Mon, 15 Oct 2007 19:38:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id BA582277AE;
	Mon, 15 Oct 2007 19:38:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 892B856D22; Mon, 15 Oct 2007 19:38:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <feud8j$kdg$1@ger.gmane.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2U+g=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61015>

Michael Gebetsroither, Mon, Oct 15, 2007 02:46:11 +0200:
> > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
> >   can be not the same, depending on what current "drive" is) and
> >   multi-cwd, which hasn't had formed itself into a problem yet, but
> >   surely will
> 
> Thats true for linux too.
> /a/b/c and /a/b/c can be 2 totally different files depending on the vfs
> namespace you are one.

No it is not. A process will always see the same filesystem object
under the same path at the any given time (IOW, you can't have many
namespaces active at the same time).
