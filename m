From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Sat, 5 Jun 2010 18:11:40 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1006051810300.1732@bonsai2>
References: <20100605005116.GA8774@progeny.tock>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1927776969-1275754301=:1732"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 18:11:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKvyP-0004TD-QN
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 18:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933637Ab0FEQLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 12:11:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:60644 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933622Ab0FEQLn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 12:11:43 -0400
Received: (qmail invoked by alias); 05 Jun 2010 16:11:41 -0000
Received: from pD9EB26E0.dip0.t-ipconnect.de (EHLO noname) [217.235.38.224]
  by mail.gmx.net (mp046) with SMTP; 05 Jun 2010 18:11:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/E7nlvAELE0k1ErCz/KWmlVTpKJseKbvyOkcqHNR
	nccYbZqA7XmILb
X-X-Sender: gene099@bonsai2
In-Reply-To: <20100605005116.GA8774@progeny.tock>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148477>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1927776969-1275754301=:1732
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 4 Jun 2010, Jonathan Nieder wrote:

> This series teaches ‘git grep’ to accept
> 
> 	git grep -Ovi some_function_name
> 
> to find all the call sites for some_function_name so they can be
> adjusted.  Dscho’s cover letter[1] explains it better.
> 
> And in fact, Dscho did all the work here; this iteration just rebases it
> on master and adds some tests.
> 
> Happy hacking,
> Jonathan
> 
> Johannes Schindelin (2):
>   grep: Add the option '--open-files-in-pager'
>   grep -O: allow optional argument specifying the pager (or editor)

Last time I tried, it also needed the patch "Unify code paths of threaded 
greps". Don't know if that one made it in already.

Ciao,
Dscho
--8323329-1927776969-1275754301=:1732--
