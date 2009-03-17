From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] MinGW: a helper function that translates Win32 API
 error codes
Date: Tue, 17 Mar 2009 11:10:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903171109510.6393@intel-tinevez-2-302>
References: <49BF53C2.6020707@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Kodl <petrkodl@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Mar 17 11:12:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjWH7-00034v-RR
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 11:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbZCQKK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 06:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbZCQKK2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 06:10:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:37192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752965AbZCQKK1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 06:10:27 -0400
Received: (qmail invoked by alias); 17 Mar 2009 10:10:24 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp015) with SMTP; 17 Mar 2009 11:10:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+jjcQyLxajiVMZ/Mx1g7nb3B3JtAawUiAgjgq6Bx
	CuvX9a8+/q69Ft
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49BF53C2.6020707@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113448>

Hi,

On Tue, 17 Mar 2009, Johannes Sixt wrote:

> From: Petr Kodl <petrkodl@gmail.com>
> Date: Sat, 24 Jan 2009 15:04:39 +0100
> 
> This function translates many possible Win32 error codes to suitable
> errno numbers.  We will use it in our wrapper functions that need to call
> into Win32.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Dscho,
> 
>  I've split this [error code translation from Win32 to POSIX] off from 
>  the Petr's hard-link patch and moved the function to the top or mingw.c 
>  because we should reuse it in our other wrappers to convert error 
>  codes.

I fully agree.

Ciao,
Dscho
