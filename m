From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] --pretty=format: on-demand format expansion
Date: Fri, 9 Nov 2007 01:24:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711090122470.4362@racer.site>
References: <4733AEA6.1040802@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Git Mailing List <git@vger.kernel.org>,
	Pierre Habouzit <madcoder@debian.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIbi-0001DW-Qz
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:24:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753196AbXKIBYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752973AbXKIBYM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:24:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:36604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751461AbXKIBYL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:24:11 -0500
Received: (qmail invoked by alias); 09 Nov 2007 01:24:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 09 Nov 2007 02:24:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZPXxsrDQZsTkFe6GOaUryHm9zkqx5jqUcQ/omSi
	v/kGx4a+jSnD5s
X-X-Sender: gene099@racer.site
In-Reply-To: <4733AEA6.1040802@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64106>

Hi,

On Fri, 9 Nov 2007, Ren? Scharfe wrote:

>  strbuf.c |   24 ++++++
>  strbuf.h |    3 +
>  pretty.c |  276 ++++++++++++++++++++++++++++++++++----------------------------

I would be so grateful if you could (trivially) split up this patch into 
the addition of strbuf_expend() (with a small example in the commit 
message), and a patch that uses it in pretty.c.

Thanks,
Dscho
