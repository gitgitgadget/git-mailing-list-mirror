From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Revamping the git protocol
Date: Fri, 21 Oct 2005 01:35:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210133060.10503@wbgn013.biozentrum.uni-wuerzburg.de>
References: <43571DA1.6030907@zytor.com> <7vwtk8pvju.fsf@assigned-by-dhcp.cox.net>
 <20051020091245.GY30889@pasky.or.cz> <Pine.LNX.4.64.0510200924110.3369@g5.osdl.org>
 <4357CB57.3070802@zytor.com> <Pine.LNX.4.64.0510201001460.3369@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, Petr Baudis <pasky@suse.cz>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:36:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESjwf-0000IO-N8
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbVJTXfb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964807AbVJTXfb
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:35:31 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48785 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S964806AbVJTXfa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 19:35:30 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D60F13EA55; Fri, 21 Oct 2005 01:35:29 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 7DC25B4E35; Fri, 21 Oct 2005 01:35:29 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54DF9B4DCC; Fri, 21 Oct 2005 01:35:29 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A7BEB13EA55; Fri, 21 Oct 2005 01:35:28 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510201001460.3369@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10385>

Hi,

On Thu, 20 Oct 2005, Linus Torvalds wrote:

> On Thu, 20 Oct 2005, H. Peter Anvin wrote:
> > 
> > git over ssh seems to be the obvious choice.
> 
> Yes, but Petr is right that there might be room for some lighter-weight 
> "gits" secure protocol. One that doesn't necessarily require a whole user 
> ID thing.
> 
> For example, let's say that you're not the maintainer of your machine, but 
> you're in an environment where you are allowed to run daemons as yourself 
> (at a university, for example). And you have a group of people who want to 
> work together at a project, but they don't want to give write permissions 
> to the world or their bigger group (group "student").

If you are not maintainer, you could still start an SSH daemon which 
listens on a port>1024 and gets its password data from a file different 
from /etc/shadow (You could even use PAM...).

Ciao,
Dscho
