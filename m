From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [GITK PATCH 2/3] gitk: support path filters even in 
 subdirectories
Date: Thu, 25 Feb 2010 15:22:17 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002251427110.3869@intel-tinevez-2-302>
References: <f579dd581002200847o340a3eb9l50d0f1329d4e2c23@mail.gmail.com>  <alpine.DEB.1.00.1002201847290.20986@pacific.mpi-cbg.de>  <a5b261831002200948v3c01708dv3e42d08d42e3119@mail.gmail.com>  <alpine.DEB.1.00.1002201920350.20986@pacific.mpi-cbg.de> 
 <alpine.DEB.1.00.1002231748320.3980@intel-tinevez-2-302>  <alpine.DEB.1.00.1002231810020.3980@intel-tinevez-2-302>  <f579dd581002231137t71bb034fl429fd03a2c0d681c@mail.gmail.com>  <alpine.DEB.1.00.1002232122110.3980@intel-tinevez-2-302>
 <a5b261831002241751v5294af48rac8b5f52ba6cb045@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kirill <kirillathome@gmail.com>, Paul Mackerras <paulus@samba.org>,
	msysgit@googlegroups.com, git@vger.kernel.org
To: Pat Thoyts <patthoyts@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 15:22:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkebh-0007s2-Je
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 15:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704Ab0BYOWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 09:22:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:39387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932680Ab0BYOWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 09:22:20 -0500
Received: (qmail invoked by alias); 25 Feb 2010 14:22:18 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp048) with SMTP; 25 Feb 2010 15:22:18 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pQkwLwR/pDntVOFYho38/sPeEMoiKGLvJs7oExs
	9rCB1gj6v0098T
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <a5b261831002241751v5294af48rac8b5f52ba6cb045@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141050>

Hi,

On Thu, 25 Feb 2010, Pat Thoyts wrote:

> proc path_filter {filter name} {
>     set name [file normalize $name]

I am unconvinced that [file normalize] is what we want. It expands to an 
absolute path, which is almost certainly unnecessary code churn.

I will have a look at your test cases and try to fix later.

Ciao,
Johannes
