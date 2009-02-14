From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH v2] Teach rebase to rebase even if upstream is up to
 date
Date: Sat, 14 Feb 2009 07:07:04 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902140703540.10279@pacific.mpi-cbg.de>
References: <1234565281-20960-1-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailinglist <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 07:10:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYDjk-0008Lj-4o
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 07:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbZBNGGO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 01:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbZBNGGO
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 01:06:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:44740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751273AbZBNGGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 01:06:13 -0500
Received: (qmail invoked by alias); 14 Feb 2009 06:06:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp005) with SMTP; 14 Feb 2009 07:06:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dn0E0joHdJyiDUaNYgqTzIpR145aQVFhNPu/+RR
	7E++K8YTU+YRt5
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234565281-20960-1-git-send-email-srabbelier@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109825>



On Fri, 13 Feb 2009, Sverre Rabbelier wrote:

> +    case "$1" in
> +    --whitespace=fix|--whitespace=strip)

	--whitespace=*?

I know that you can turn it off with --whitespace=nowarn, but that's 
such an outlier that we do not have to care about it, right?

Or if we really want to:

	--whitespace=nowarn) ;;
	--whitespace=*) force_rebase=t ;;

Hm?

Ciao,
Dscho
