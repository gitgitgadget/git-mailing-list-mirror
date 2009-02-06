From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 05:32:01 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902060530450.10279@pacific.mpi-cbg.de>
References: <loom.20090206T035001-370@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 05:32:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVIOa-0002dy-Nh
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 05:32:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZBFEb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 23:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752368AbZBFEb0
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 23:31:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:34211 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752115AbZBFEbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 23:31:25 -0500
Received: (qmail invoked by alias); 06 Feb 2009 04:31:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 06 Feb 2009 05:31:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fE/wf9q/fGyWSslXb3d2Q9Ct2nq0Ia0o2Mrh2/W
	v2RwT8BEKMhxgR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <loom.20090206T035001-370@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108651>

Hi,

On Fri, 6 Feb 2009, Joi Ellis wrote:

> "make all" fails becuase my libaries are old:
> 
>     LINK git-fast-import
> fast-import.o: In function `store_object':
> /usr/local/src/git/git/fast-import.c:1086: undefined reference to `deflateBound'
> /usr/local/src/git/git/fast-import.c:1109: undefined reference to `deflateBound'

You need to install a newer libz.  (And this is not a chicken & egg 
problem.)

Ciao,
Dscho
