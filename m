From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GITK PATCH 2/3] gitk: support path filters even in 
 subdirectories
Date: Tue, 23 Feb 2010 21:22:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002232122110.3980@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>  <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>  <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>  <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302> <f579dd581002231137t71bb034fl429fd03a2c0d681c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@googlemail.com>,
	Paul Mackerras <paulus@samba.org>, msysgit@googlegroups.com,
	git@vger.kernel.org
To: Kirill <kirillathome@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 21:29:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nk1O4-00047K-JJ
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 21:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925Ab0BWU3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 15:29:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:50678 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752649Ab0BWU3j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 15:29:39 -0500
Received: (qmail invoked by alias); 23 Feb 2010 20:22:47 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 23 Feb 2010 21:22:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+o9bd3ImmohV5rdtDM0Jkro/CFe/lVx/NX3RmzIS
	c7b1Z8I1JfPIBz
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <f579dd581002231137t71bb034fl429fd03a2c0d681c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140831>

Hi,

On Tue, 23 Feb 2010, Kirill wrote:

> I believe the fact that pathprefix is set only under several conditions, 
> the invocation without arguments is broken.

You are absolutely correct!

Will fix and push to work/gitk-dashdash-dot,
Dscho
