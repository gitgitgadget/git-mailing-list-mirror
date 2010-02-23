From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GITK PATCH 3/3] gitk: strip prefix from filenames in 
 subdirectories
Date: Tue, 23 Feb 2010 21:50:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232148470.3980@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>  <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>  <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>  <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>  <alpine.DEB.1.00.1002231811021.3980@intel-tinevez-2-302> <f579dd581002231142v6a937ac0xdc9618f2a468989d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Kirill <kirillathome@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1qz-0000ir-Hv
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:59:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400Ab0BWU7d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:59:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:45213 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750953Ab0BWU7c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:59:32 -0500
Received: (qmail invoked by alias); 23 Feb 2010 20:50:40 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 23 Feb 2010 21:50:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19egyoH/6NeO80EZpFQ5M5Vux3OyjFzOAIB77w7Lj
	jB7119COmQ5Rzq
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <f579dd581002231142v6a937ac0xdc9618f2a468989d@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: -0.070000000000000007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140832>

Hi,

On Tue, 23 Feb 2010, Kirill wrote:

> Unfortunately, it seems to be too aggressive, leading to a misleading 
> display. When gitk is invoked from a subdirectory but without the 
> filter, the lower right panel displays some paths, relative to the root 
> of the work tree, and some, relative to the wd:

Right. I fixed it in 2/3: pathprefix is set to "" when no cmdline_files 
were specified (i.e. when there is no filter). An when pathprefix is "", 
nothing changes to the situation before.

Good?

Ciao,
Dscho
