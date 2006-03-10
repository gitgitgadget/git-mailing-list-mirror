From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Fri, 10 Mar 2006 12:17:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603101215100.25810@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wxg82r3.fsf@assigned-by-dhcp.cox.net>
 <46a038f90603060105m29595745ke64d4a623506c0b0@mail.gmail.com>
 <20060310104443.GA4491@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 12:18:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHfdF-0003J4-0R
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 12:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWCJLSA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 06:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWCJLSA
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 06:18:00 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:28365 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1752230AbWCJLR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 06:17:59 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id A015612D9;
	Fri, 10 Mar 2006 12:17:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 93A565EFE;
	Fri, 10 Mar 2006 12:17:58 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 4944CA81;
	Fri, 10 Mar 2006 12:17:58 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060310104443.GA4491@c165.ib.student.liu.se>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17471>

Hi,

On Fri, 10 Mar 2006, Fredrik Kuivinen wrote:

> On Mon, Mar 06, 2006 at 10:05:41PM +1300, Martin Langhoff wrote:
> > On 3/6/06, Junio C Hamano <junkio@cox.net> wrote:
> > > - The deathmatch between annotate/blame (Ryan Anderson, Fredrik
> > >   Kuivinen, me cheerleading)
> > 
> > Add fuel to the fire  ;-) Can git-blame take cached git-rev-list
> > output like annotate does with -S?
> > 
> 
> Currently it cannot do that. How is that option used?

The history is linearized, and the commits are ordered accordingly, then 
to be passed to git-annotate/-blame.

> If you want to make annotate/blame faster for certain files you might as 
> well cache the output of annotate/blame instead of the git-rev-list 
> output, no?
> 
> What am I missing?

Two things:

- the history is growing, and
- it would be inefficient/error-prone to save the annotates for files 

Hth,
Dscho
  
