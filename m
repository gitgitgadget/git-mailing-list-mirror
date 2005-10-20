From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rsync update appears broken now
Date: Fri, 21 Oct 2005 01:41:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510210140400.12723@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86vezs9wy9.fsf@blue.stonehenge.com>
 <81b0412b0510200608l61c00ed0yd4dbc00c313665fe@mail.gmail.com>
 <Pine.LNX.4.64.0510201038320.3369@g5.osdl.org> <loom.20051020T220751-355@post.gmane.org>
 <Pine.LNX.4.64.0510201432260.10477@g5.osdl.org> <7vek6f220h.fsf@arte.twinsun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 01:42:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESk2i-0001be-VU
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 01:41:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbVJTXlu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Oct 2005 19:41:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932555AbVJTXlu
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Oct 2005 19:41:50 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3986 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932554AbVJTXlt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2005 19:41:49 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D992813ECA4; Fri, 21 Oct 2005 01:41:48 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BCA41B4E35; Fri, 21 Oct 2005 01:41:48 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A349EB4DCC; Fri, 21 Oct 2005 01:41:48 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 54AE613ECA4; Fri, 21 Oct 2005 01:41:48 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio Hamano <junio@twinsun.com>
In-Reply-To: <7vek6f220h.fsf@arte.twinsun.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10387>

Hi,

On Thu, 20 Oct 2005, Junio Hamano wrote:

> > At that point:
> >
> >>                -----(A) head merlyn and everybody
> >>              /          pulled from kernel.org previously
> >>   --- common ------------------------------------(B) head rebased and pushed
> >>                                                      out by mistake
> 
> Mind telling me the (A) commit ID if you know it?

ea5a65a59916503d2a14369c46b1023384d51645

Also, people having merged with (A) would not have to undo that merge as 
was suggested. The new (C) commit would contain the revert of (A).

Ciao,
Dscho
