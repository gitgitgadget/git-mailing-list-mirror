From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow '+', '-' and '.' in remote helper names
Date: Tue, 23 Feb 2010 14:03:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002231402350.3980@intel-tinevez-2-302>
References: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Feb 23 14:03:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjuQY-0000pm-Ie
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 14:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264Ab0BWNDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 08:03:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:35057 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751881Ab0BWNDp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 08:03:45 -0500
Received: (qmail invoked by alias); 23 Feb 2010 13:03:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp044) with SMTP; 23 Feb 2010 14:03:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18H4ulrZYoHehfkrWcAQaYblu574mrZdbYXMA09Ew
	tAStb2adR80Ze9
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1266928428-19075-1-git-send-email-ilari.liusvaara@elisanet.fi>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140796>

Hi,

On Tue, 23 Feb 2010, Ilari Liusvaara wrote:

> According to relevant RFCs, in addition to alphanumerics, the following
> characters are valid in URL scheme parts: '+', '-' and '.', but
> currently only alphanumerics are allowed in remote helper names.

May I caution against allowing "+" as part of filenames? On Windows, 
thanks to the DOS garb^Wheritage, "+" is not really allowed...

Or maybe I misunderstood the intent of the patch?

Ciao,
Dscho
