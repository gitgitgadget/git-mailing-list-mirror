From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] grep: don't support "grep.color"-like config options
Date: Tue, 21 Apr 2009 01:45:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de>
References: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Markus Heidelberg <markus.heidelberg@web.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 01:45:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw3B1-00086N-Ro
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 01:45:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZDTXnx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 19:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbZDTXnw
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 19:43:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:42911 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752807AbZDTXnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 19:43:52 -0400
Received: (qmail invoked by alias); 20 Apr 2009 23:43:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 21 Apr 2009 01:43:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/e+oFVjfjePr/6l5hMfJfyXs77HH569yxLScNV6A
	GFATF5Emi3X/H+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117048>

Hi,

On Tue, 21 Apr 2009, Markus Heidelberg wrote:

> color.grep and color.grep.* is the official and documented way to 
> highlight grep matches. Comparable options like diff.color.* and 
> status.color.* exist for backward compatibility reasons only and are not 
> documented any more.

But is it really so bad that we have to possibly break existing setups?

The cost of keeping them is really small IMHO.

Ciao,
Dscho
