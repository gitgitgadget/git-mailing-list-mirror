From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fmt-patch: Support --attach
Date: Sat, 20 May 2006 22:23:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605202214430.634@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0605201537290.17869@wbgn013.biozentrum.uni-wuerzburg.de>
 <e4n8b3$ari$1@sea.gmane.org> <Pine.LNX.4.63.0605201904320.31887@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v4pzk3831.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0605201945110.32590@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu07k1sr8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 22:23:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhXyl-0001Nq-K3
	for gcvg-git@gmane.org; Sat, 20 May 2006 22:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWETUXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 May 2006 16:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbWETUXH
	(ORCPT <rfc822;git-outgoing>); Sat, 20 May 2006 16:23:07 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45528 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751476AbWETUXG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 May 2006 16:23:06 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id EB4F81C97;
	Sat, 20 May 2006 22:23:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id DF4CA1C56;
	Sat, 20 May 2006 22:23:04 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id BDA6A1BCB;
	Sat, 20 May 2006 22:23:04 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu07k1sr8.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20393>

Hi,

On Sat, 20 May 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 20 May 2006, Junio C Hamano wrote:
> >
> > As for --check: how about having yet another diff "format": 
> > DIFF_FORMAT_CHECK? Instead of showing the diff, it only shows the line(s) 
> > which are offending.
> 
> Never thought of that but I think it makes sense.  
> 
> I liked the way Sean did the --summary; I am wondering if we
> could clean up the --with-* stuff in a similar way.  We
> currently do "if DIFF_FORMAT_XYZ or with_xyz then do this" which
> is quite honestly disgusting (my fault).

I do not think the --with-* stuff can be done in a similar way. If I do 
"git log --summary -p", I do not get a summary. The only way to "clean it 
up" would be to add a linked list of diff_formats (to preserve the order). 

But frankly, I think that is overkill. After all, how often have you 
dreamt about showing first the patch, then the summary, and maybe a 
diffstat, and after that the patch again, for each commit?

Ciao,
Dscho
