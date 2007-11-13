From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/11] Close files opened by lock_file() before unlinking.
Date: Tue, 13 Nov 2007 21:05:32 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132104060.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is2y0-00086S-P7
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbXKMVGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756781AbXKMVGY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:06:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:60328 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752428AbXKMVGX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:06:23 -0500
Received: (qmail invoked by alias); 13 Nov 2007 21:06:20 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp056) with SMTP; 13 Nov 2007 22:06:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/A6NFOG43AWIzuhueur0pSBCLU/knDRz9NIaX5h8
	d/t4P+Pw9fFbkL
X-X-Sender: gene099@racer.site
In-Reply-To: <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64865>

Hi,

On Tue, 13 Nov 2007, Johannes Sixt wrote:

> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> 
> This is needed on Windows since open files cannot be unlinked.
> 
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> 
> 	This was authored by Dscho, but carries only my sign-off.
> 	Is this ok?

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

BTW: Hannes, many thanks for your efforts.  Much appreciated.

Ciao,
Dscho
