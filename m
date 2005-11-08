From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 00:04:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511090003280.27861@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 00:06:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZcW1-0000eq-Fw
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 00:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbVKHXEa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 Nov 2005 18:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbVKHXEa
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Nov 2005 18:04:30 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:50846 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1030388AbVKHXEa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2005 18:04:30 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0175F13F147; Wed,  9 Nov 2005 00:04:27 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D07CB9F1EC; Wed,  9 Nov 2005 00:04:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BA7E79F1DC; Wed,  9 Nov 2005 00:04:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 936A113F147; Wed,  9 Nov 2005 00:04:26 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051108210211.GA23265@c165.ib.student.liu.se>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11365>

Hi,

On Tue, 8 Nov 2005, Fredrik Kuivinen wrote:

> On Tue, Nov 08, 2005 at 12:58:50PM +0100, Johannes Schindelin wrote:
> > 
> > We already have a fallback list: after really-trivial, try automatic, ...,
> > try resolve. Why not just add recursive? So, if even resolve failed, just 
> > try once more, with recursive.
> > 
> 
> I don't think this is a very good idea for two reasons. The first one
> is that there are some merge scenarios involving renames which should
> be conflicts but are cleanly merged by git-resolve.
> 
> The second reason is that with the fall back list the recursive
> strategy will only be used in the strange corner cases and will thus
> not get nearly the same amount of testing it would get if it was the
> first choice (or directly after the really-trivial merge).

Two very valid points. You convinced me.

Ciao,
Dscho
