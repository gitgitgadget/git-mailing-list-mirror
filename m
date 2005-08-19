From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC] Allow file removal when "git commit --all" is used.
Date: Fri, 19 Aug 2005 10:06:25 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508191005450.11916@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <7v64u3k74m.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0508181248110.30218@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vll2yenyv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 10:09:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E61tZ-0004Zl-HC
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 10:06:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVHSIGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 04:06:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932239AbVHSIGa
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 04:06:30 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:3815 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932171AbVHSIG3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 04:06:29 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D2D013C938; Fri, 19 Aug 2005 10:06:26 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2FDF599D3B; Fri, 19 Aug 2005 10:06:26 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E3D4199D01; Fri, 19 Aug 2005 10:06:25 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C93D013C938; Fri, 19 Aug 2005 10:06:25 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll2yenyv.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 18 Aug 2005, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> The patch is for people who thinks the user who uses the "--all"
> >> flag deserves the danger that comes with the convenience.
> >> 
> >> Comments?
> >
> > This is a sane default behaviour. Maybe introduce yet another flag 
> > "--no-remove", which says that removes should not be performed? But then, 
> > "--all" is mostly used by lazy people, who probably expect the removes to 
> > take place.
> 
> Well, let's refrain from using that word; I am one of the "lazy"
> people, but I do that on purpose and from principle, not from
> lazyness.  http://members.cox.net/junkio/per-file-commit.txt.

Sorry, when I say "lazy people" I mean "yours truly".

Ciao,
Dscho
