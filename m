From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] submodule: print graph output next to submodule log
Date: Fri, 5 Apr 2013 18:22:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1304051822100.1863@s15462909.onlinehome-server.info>
References: <a6f8377623599ef8f31cc63f7e038b5e8d04aa01.1365177990.git.john@keeping.me.uk> <20130405161207.GQ2222@serenity.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWK4-0002u6-4v
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161969Ab3DEQWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 12:22:53 -0400
Received: from mout.gmx.net ([212.227.17.20]:52667 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161964Ab3DEQWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 12:22:52 -0400
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MFOSw-1URP4g1QaS-00EL72 for
 <git@vger.kernel.org>; Fri, 05 Apr 2013 18:22:50 +0200
Received: (qmail invoked by alias); 05 Apr 2013 16:22:50 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp004) with SMTP; 05 Apr 2013 18:22:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/3eE0VgUH3LK48SIu1sz8Yk1Mkr1b0iFTmmKhbzL
	I9r9PqIsaM654T
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20130405161207.GQ2222@serenity.lan>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220187>

Hi John,

On Fri, 5 Apr 2013, John Keeping wrote:

> When running "git log -p --submodule=log", the submodule log is not
> indented by the graph output, although all other lines are.  Fix this by
> prepending the current line prefix to each line of the submodule log.

Nice! I agree that submodules are an ugly child of Git; not even Git
itself uses them ;-)

Thanks for that fix!

Ciao,
Dscho
