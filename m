From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/5] pretty describe: move library functions to the new
 file describe.c
Date: Sun, 4 Nov 2007 14:36:44 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711041435540.4362@racer.site>
References: <472DB199.2040305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iogbk-0002WT-0Z
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 15:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755614AbXKDOhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 09:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755143AbXKDOhd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 09:37:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:60015 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754498AbXKDOhd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 09:37:33 -0500
Received: (qmail invoked by alias); 04 Nov 2007 14:37:31 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 04 Nov 2007 15:37:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pEyYPRkfpL/DQ7vGjhxDxjaszlNaTueiVbHvbTA
	o+jFvUWnv1LKDe
X-X-Sender: gene099@racer.site
In-Reply-To: <472DB199.2040305@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63411>

Hi,

On Sun, 4 Nov 2007, Ren? Scharfe wrote:

>  Makefile           |    2 +-
>  builtin-describe.c |  202 ---------------------------------------------------
>  cache.h            |    5 ++
>  describe.c         |  204 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 210 insertions(+), 203 deletions(-)
>  create mode 100644 describe.c

Would not "format-patch -C -C" have given a nicer output?

Ciao,
Dscho
