From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 19:53:54 +0200
Message-ID: <20071015175354.GD2966@steel.home>
References: <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710150039120.25221@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eli Zaretskii <eliz@gnu.org>, ae@op5.se, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 15 20:59:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhU8m-0007H6-UI
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 19:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762876AbXJORx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 13:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758467AbXJORx6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 13:53:58 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:33232 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757106AbXJORx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 13:53:57 -0400
Received: from tigra.home (Fc8e3.f.strato-dslnet.de [195.4.200.227])
	by post.webmailer.de (fruni mo46) (RZmta 13.4)
	with ESMTP id D02e03j9FHEveI ; Mon, 15 Oct 2007 19:53:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B0F3F277AE;
	Mon, 15 Oct 2007 19:53:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 8D9CB56D22; Mon, 15 Oct 2007 19:53:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710150039120.25221@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow2U+g=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61022>

Johannes Schindelin, Mon, Oct 15, 2007 01:45:47 +0200:
> On Mon, 15 Oct 2007, Eli Zaretskii wrote:
> > Alex Riesen said:
> > > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
> > >   can be not the same, depending on what current "drive" is)
> > 
> > So what? on Unix "a/b/c" can be not the same.  Both cases are simply not 
> > complete file names, that's all.  No one said there must be a single 
> > root for all volumes, it's the Posix jingoism creeping in again.
> 
> I think Alex means this: you can have C:\a\b\c and D:\a\b\c.  So depending 
> on which drive you are, you mean one or the other.  Just comparing the 
> paths is not enough.

Not really. I meant that "/a/b/c" and "/a/b/c". Note the leading
slash. On windoze it is _NOT_ absolute path. It is relative to the
root of the current drive.
