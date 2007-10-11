From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: git branch performance problem?
Date: Thu, 11 Oct 2007 08:41:26 +0200
Message-ID: <20071011064126.GA3649@steel.home>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> <alpine.LFD.0.999.0710101610230.20690@woody.linux-foundation.org> <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Thu Oct 11 08:41:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifrjo-0003lL-OP
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 08:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754385AbXJKGlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 02:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753729AbXJKGlb
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 02:41:31 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:46842 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754037AbXJKGla (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 02:41:30 -0400
Received: from tigra.home (Fc872.f.strato-dslnet.de [195.4.200.114])
	by post.webmailer.de (klopstock mo13) (RZmta 13.4)
	with ESMTP id y0331dj9B3wj1v ; Thu, 11 Oct 2007 08:41:26 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 53F88277AE;
	Thu, 11 Oct 2007 08:41:26 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 33DD8C50A; Thu, 11 Oct 2007 08:41:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f329bf540710101926vedf8b19p52e3eeb193203d03@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWo+ecrQ=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60581>

Han-Wen Nienhuys, Thu, Oct 11, 2007 04:26:24 +0200:
> > So the rule really is: never *ever* do anything but fast-forward in a repo
> >[..]
> 
> Methinks this is all too difficult. I will use clone -l henceforth.

It is current default for local clones
