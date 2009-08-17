From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 02/11] Fix declare variable at mid of function
Date: Mon, 17 Aug 2009 18:29:03 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171827040.4991@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com> <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:29:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md55C-0001pO-UB
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755764AbZHQQ3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 12:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752564AbZHQQ3F
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:29:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:57667 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754862AbZHQQ3F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 12:29:05 -0400
Received: (qmail invoked by alias); 17 Aug 2009 16:29:04 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 17 Aug 2009 18:29:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182VMRwbyk2cAyKPxF5PvxtFViDT1SA/T3dCnvRZ9
	i+feaNFQNp6AMt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1250524872-5148-2-git-send-email-lznuaa@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126220>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> Some compiler such as MSVC can't support declear variable at mid of funtion at c file.

Please wrap your commit messages after 76 characters.

> 
> Signed-off-by: Frank Li <lznuaa@gmail.com>
> ---

How about this instead?

	Avoid declaration after instruction

	Microsoft Visual C++ does not understand this C99 style.

?

The patch itself is good.

Ciao,
Dscho
