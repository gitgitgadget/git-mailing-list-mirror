From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Fix buffer overflow in config parser
Date: Tue, 14 Apr 2009 23:41:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904142340350.10279@pacific.mpi-cbg.de>
References: <49E50003.2040907@intra2net.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, markus.heidelberg@web.de
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 23:40:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtqMS-0001Ao-4u
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 23:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499AbZDNVia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 17:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbZDNVia
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 17:38:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:39563 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752538AbZDNVi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 17:38:29 -0400
Received: (qmail invoked by alias); 14 Apr 2009 21:38:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 14 Apr 2009 23:38:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18q1pJGjsAqtlRpyng5KZPgqkLXVGgzJcAXGW9GuT
	zJ9fFvf7LHeGfi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49E50003.2040907@intra2net.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116578>

Hi,

On Tue, 14 Apr 2009, Thomas Jarosch wrote:

>  t/t1303-wacky-config.sh |    9 ++++++++-

I like the name!

> +LONG_VALUE=`perl -e 'print "x" x 1023," a"'`

But should it not be guarded against NO_PERL?

Ciao,
Dscho
