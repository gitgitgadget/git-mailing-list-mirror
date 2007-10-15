From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 21:30:53 +0200
Message-ID: <20071015193053.GA15541@steel.home>
References: <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <feud8j$kdg$1@ger.gmane.org> <20071015173832.GB2966@steel.home> <85ejfwi3gr.fsf@lola.goethe.zz>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Gebetsroither <gebi@sbox.tugraz.at>, git@vger.kernel.org,
	make-w32@gnu.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Oct 15 22:28:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhVee-0004q0-RV
	for gcvg-git-2@gmane.org; Mon, 15 Oct 2007 21:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759119AbXJOTa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 15:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759147AbXJOTa5
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 15:30:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:19290 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757715AbXJOTa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 15:30:56 -0400
Received: from tigra.home (Fca67.f.strato-dslnet.de [195.4.202.103])
	by post.webmailer.de (klopstock mo47) (RZmta 13.4)
	with ESMTP id K033c4j9FJ906c ; Mon, 15 Oct 2007 21:30:54 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B8925277AE;
	Mon, 15 Oct 2007 21:30:53 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5C98856D22; Mon, 15 Oct 2007 21:30:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <85ejfwi3gr.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTv2MPo=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61032>

David Kastrup, Mon, Oct 15, 2007 21:26:44 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > Michael Gebetsroither, Mon, Oct 15, 2007 02:46:11 +0200:
> >> > - it is the only OS in the world with multi-root (/a/b/c and /a/b/c
> >> >   can be not the same, depending on what current "drive" is) and
> >> >   multi-cwd, which hasn't had formed itself into a problem yet, but
> >> >   surely will
> >> 
> >> Thats true for linux too.
> >> /a/b/c and /a/b/c can be 2 totally different files depending on the vfs
> >> namespace you are one.
> >
> > No it is not. A process will always see the same filesystem object
> > under the same path at the any given time (IOW, you can't have many
> > namespaces active at the same time).
> 
> dak@lola:/home/tmp/emacs$ mkdir -p /tmp/a/b
> dak@lola:/home/tmp/emacs$ cd /tmp/a/b
> dak@lola:/tmp/a/b$ sudo mount --bind /usr /tmp/a

Well don't do that in your repos (unless need that for something).

It is not like someone creates a distribution which does it
automagically all the time and you're forced to use that distribution.
