From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Do not use GUID on dir in git init --shared=all on
	FreeBSD 4.11p2
Date: Tue, 4 Mar 2008 22:46:56 +0100
Message-ID: <20080304214656.GE3295@steel.home>
References: <20080303234406.GA28158@steel.home> <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org> <20080304072519.GA3070@steel.home> <7vir02ap3b.fsf@gitster.siamese.dyndns.org> <20080304202047.GC3295@steel.home> <alpine.LSU.1.00.0803042048330.22527@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:47:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWez2-0001W3-8T
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 22:47:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422AbYCDVq7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 16:46:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbYCDVq6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 16:46:58 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:35741 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586AbYCDVq6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 16:46:58 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtoAegw==
Received: from tigra.home (Faa57.f.strato-dslnet.de [195.4.170.87])
	by post.webmailer.de (klopstock mo16) (RZmta 16.8)
	with ESMTP id L03f2bk24KgiHj ; Tue, 4 Mar 2008 22:46:56 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4736E277BD;
	Tue,  4 Mar 2008 22:46:56 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 40D5956D24; Tue,  4 Mar 2008 22:46:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803042048330.22527@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76141>

Johannes Schindelin, Tue, Mar 04, 2008 21:50:34 +0100:
> Hi,
> 
> On Tue, 4 Mar 2008, Alex Riesen wrote:
> 
> > +#if !defined(__FreeBSD__) || (__FreeBSD__ > 4)
> 
> We are not avoiding to clutter the source code with ugly __MINGW32__ 
> conditionals with a huge effort, so that you can clutter it with 
> __FreeBSD__ conditionals.
> 

Will fix.

> >  	if (S_ISDIR(mode))
> >  		mode |= S_ISGID;
> 
> What problem does FreeBSD < 4 have with that?
> 

No idea.

