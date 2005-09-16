From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add uninstall target to Makefile
Date: Sat, 17 Sep 2005 01:37:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0509170135110.13233@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050916125814.GA8084@igloo.ds.co.ug> <7vfys5ndor.fsf@assigned-by-dhcp.cox.net>
 <20050916175402.GC22825@tuxdriver.com> <20050916180810.GK8041@shell0.pdx.osdl.net>
 <20050916191953.GD22825@tuxdriver.com> <7vu0gkfwak.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "John W. Linville" <linville@tuxdriver.com>,
	Martin Atukunda <matlads@dsmagic.com>,
	Chris Wright <chrisw@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 01:37:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGPla-0000Ry-AM
	for gcvg-git@gmane.org; Sat, 17 Sep 2005 01:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbVIPXhK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 19:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750738AbVIPXhK
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 19:37:10 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:55257 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750732AbVIPXhI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2005 19:37:08 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0100013C578; Sat, 17 Sep 2005 01:37:05 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D55E89F1F0; Sat, 17 Sep 2005 01:37:04 +0200 (CEST)
Received: from wrzx35.rz.uni-wuerzburg.de (wrzx35.rz.uni-wuerzburg.de [132.187.3.35])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BC0015966A; Sat, 17 Sep 2005 01:37:04 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx35.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 40337E2703; Sat, 17 Sep 2005 01:37:03 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0gkfwak.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8744>

Hi,

On Fri, 16 Sep 2005, Junio C Hamano wrote:

> "John W. Linville" <linville@tuxdriver.com> writes:
> 
> > On Fri, Sep 16, 2005 at 11:08:10AM -0700, Chris Wright wrote:
> >
> >> Of course package manager will do better at this, but it is useful to be
> >> able to uninstall.  However, I don't think Martin's external script with
> >> all the filenames hardcoded is the right approach.  There are $(PROG)
> >> and $(SCRIPTS) which already know all these filenames.
> >
> > I would agree with that.  Definitely better to use the same Makefile
> > vars used for install to do the uninstall.
> 
> True.  That is something I could live with.

Well, IMHO a package manager beats an uninstall target any time of a 
second. I know that I chose to checkinstall all projects I compiled myself 
so that I can be sure that no old version keeps lying around taking space 
for nothin'.

Ciao,
Dscho
