From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 0/4] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 12 Jun 2010 23:36:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006122335190.2689@bonsai2>
References: <20100605005116.GA8774@progeny.tock> <alpine.DEB.1.00.1006051810300.1732@bonsai2> <20100612075542.GB2918@burratino> <alpine.DEB.1.00.1006121139290.2689@bonsai2> <20100612162945.GB1406@burratino>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 12 23:36:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONYND-0004yf-Ha
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 23:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752587Ab0FLVgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 17:36:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:49894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752518Ab0FLVgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 17:36:08 -0400
Received: (qmail invoked by alias); 12 Jun 2010 21:36:04 -0000
Received: from pD9EB0BD4.dip0.t-ipconnect.de (EHLO noname) [217.235.11.212]
  by mail.gmx.net (mp056) with SMTP; 12 Jun 2010 23:36:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182/MJWc4M2CMUYt4JdDdBMZOISQlTnRP1JeiLuEo
	/npiX2FTtVmX4B
X-X-Sender: gene099@bonsai2
In-Reply-To: <20100612162945.GB1406@burratino>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149030>

Hi,

On Sat, 12 Jun 2010, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> 
> > Nope, the patch is still there, even after a rebase.
> 
> Ah, I see.  Looks like a good patch (d00d655, Unify code paths of 
> threaded greps, 2010-02-07) though in principle a separate topic, since 
> grep -O already sets use_threads = 0.

No. It applies without the patch. But in my tests, it just does not work 
on multi-core machines without the patch.

Ciao,
Dscho
