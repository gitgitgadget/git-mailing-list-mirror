From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Wrap RUNTIME_PREFIX warning in a compile-time
 condition
Date: Tue, 23 Feb 2010 12:07:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231201260.3980@intel-tinevez-2-302>
References: <4B839282.1020605@viscovery.net> <alpine.DEB.1.00.1002231041230.20986@pacific.mpi-cbg.de> <4B83A330.5080403@viscovery.net> <alpine.DEB.1.00.1002231103170.20986@pacific.mpi-cbg.de> <4B83A9A2.5080500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Feb 23 12:07:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjscF-000216-Hh
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 12:07:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0BWLHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 06:07:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:41494 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751903Ab0BWLHl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 06:07:41 -0500
Received: (qmail invoked by alias); 23 Feb 2010 11:07:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp014) with SMTP; 23 Feb 2010 12:07:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18TLncfVtsTnoiTJF/4G/1P5jgxztxuLeyZHRIvia
	PZCtlXl1LRBJa1
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <4B83A9A2.5080500@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.70999999999999996
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140786>

Hi,

On Tue, 23 Feb 2010, Johannes Sixt wrote:

> [*] As I said, nobody else seems to complain.

If it is so annoying (and I agree that it hit me, too), maybe just remove 
it altogether. It is not really a helpful warning, either.

Maybe the best would be to replace it with a trace_printf().

Ciao,
Dscho

P.S.: I cannot recall defending the warning, but I might have thought it a 
good idea at some stage. This is no longer so.
