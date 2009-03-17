From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: test for --replace-all with one argument and
 fix documentation.
Date: Tue, 17 Mar 2009 11:24:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171123530.6393@intel-tinevez-2-302>
References: <1237283197.10001.9.camel@equipo-loli>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: felipe.contreras@gmail.com, gitster@pobox.com, git@vger.kernel.org
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:26:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWUz-0007TQ-8y
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756934AbZCQKYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755988AbZCQKYm
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:24:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:34141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754141AbZCQKYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:24:42 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:24:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp064) with SMTP; 17 Mar 2009 11:24:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+U1cgHslaUrQY40Jw4HDgzp+lcw3lXbvFvqwZV0P
	xjBm5JM0hvBRu7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1237283197.10001.9.camel@equipo-loli>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113451>

Hi,

On Tue, 17 Mar 2009, Carlos Rica wrote:

> Option --replace-all only allows at least two arguments, so
> documentation was needing to be updated accordingly. A test showing
> that the command fails with only one parameter is also provided.
> 
> Signed-off-by: Carlos Rica <jasampler@gmail.com>

Looks obviously correct to me.  I am actually unsure if I can ACK this 
patch, as most of builtin-config.c does not look all that familiar to me 
anymore ;-)

Ciao,
Dscho
