From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere: remove duplicated functions
Date: Sat, 14 Feb 2009 23:28:30 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142327520.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141944030.10279@pacific.mpi-cbg.de> <1234650064-639-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-535710314-1234650510=:10279"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sat Feb 14 23:29:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYT0U-0007G9-BS
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 23:29:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZBNW1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbZBNW1i
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 17:27:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:33711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751357AbZBNW1h (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 17:27:37 -0500
Received: (qmail invoked by alias); 14 Feb 2009 22:27:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp019) with SMTP; 14 Feb 2009 23:27:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19frTZNYhJfIUHAY/UNKNDDg2nA/AAL6rtWovmo81
	LqVxl0POn2xDkk
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1234650064-639-1-git-send-email-szeder@ira.uka.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109942>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-535710314-1234650510=:10279
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 14 Feb 2009, SZEDER Gábor wrote:

> Both rerere.c and builtin-rerere.c define the static functions
> rr_path() and has_resolution() the exact same way.  To eliminate this
> code duplication this patch turns the functions in rerere.c
> non-static, and makes builtin-rerere.c use them.  Also, since this
> puts these two functions into the global namespace, rename them to
> rerere_path() and has_rerere_resolution(), respectively, and rename
> their "name" parameter to "hex", because it better reflects what that
> parameter actually is.

Thanks.  As I started that code in C, I dare say "ACK" here :-)

Ciao,
Dscho
--8323328-535710314-1234650510=:10279--
