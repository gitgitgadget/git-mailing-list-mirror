From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: most commonly used git commands?
Date: Sat, 30 Jun 2007 15:14:28 +0200
Message-ID: <20070630131428.GA2866@steel.home>
References: <20070625064017.GA2839@mellanox.co.il> <7vlke833wr.fsf@assigned-by-dhcp.pobox.com> <20070625071752.GB15343@mellanox.co.il> <Pine.LNX.4.64.0706250846200.4059@racer.site> <81b0412b0706280152g5cbd777y76757d9c608ea483@mail.gmail.com> <Pine.LNX.4.64.0706281408280.4438@racer.site> <4683BDA5.996874EF@eudaptics.com> <Pine.LNX.4.64.0706281506390.4438@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 30 15:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4cme-0000yQ-Kq
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 15:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056AbXF3NOc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 09:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756048AbXF3NOc
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 09:14:32 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38951 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756007AbXF3NOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 09:14:31 -0400
Received: from tigra.home (Fc956.f.strato-dslnet.de [195.4.201.86])
	by post.webmailer.de (mrclete mo6) (RZmta 7.6)
	with ESMTP id z03dcbj5UBUtVV ; Sat, 30 Jun 2007 15:14:29 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 1139F277BD;
	Sat, 30 Jun 2007 15:14:29 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id DC4AFC164; Sat, 30 Jun 2007 15:14:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706281506390.4438@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzA3k6g==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51214>

Johannes Schindelin, Thu, Jun 28, 2007 16:07:17 +0200:
> > No. It was meant as Alex said it. Windows (MinGW) doesn't understand
> > "chmod a+x blub".
> 
> Yes, I suspected that. But I don't see a need for it on Windows (MinGW) to 
> begin with.
> 

But it is necessary on Windows (Cygwin): chmod(2) with mode set to
0644 will happily take execute permission from an .com, .bat, .cmd,
.pl, .exe or .dll file. Which means something different on Windows,
but results in unexpectedly (for a Windows user) looking errors. The
users there do not expect seeing an .exe-file but be not able to
run it.
