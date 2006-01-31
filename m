From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Tue, 31 Jan 2006 19:06:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 19:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3ztg-0007Mq-KT
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 19:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWAaSGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 13:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbWAaSGa
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 13:06:30 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:45712 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751309AbWAaSG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 13:06:29 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 671AD1464BA; Tue, 31 Jan 2006 19:06:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 59BADA6A;
	Tue, 31 Jan 2006 19:06:28 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3DD731464BA; Tue, 31 Jan 2006 19:06:28 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15329>

Hi,

On Tue, 31 Jan 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > apart from my thinking this is not backward-compatible (you are supposed 
> > to be able to pull from a complete repo, even if it has a 
> > non-shallow-capable upload-pack), here are my comments:
> 
> It cannot do a shallow clone against older servers, no.

Worse, you cannot pull from older servers into shallow repos.

> > - The custom_graft issue could be handled in a more elegant manner if 
> > 	git was lib'ified (no temporary file). Since that is already the 
> > 	plan, why not do that first, and come back later?
> 
> That is why it does not write any temporary files.  It
> introduces a way to read graft information from an environment
> variable.

Ooops. I only saw that you setup_custom_grafts and assumed wrongly.

Ciao,
Dscho
