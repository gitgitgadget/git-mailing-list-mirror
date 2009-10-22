From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH v5 0/8] imap-send: Windows support
Date: Thu, 22 Oct 2009 19:42:42 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910221942150.1263@felix-maschine>
References: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 19:42:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N11gK-00056H-JF
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 19:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbZJVRm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 13:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752615AbZJVRm0
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 13:42:26 -0400
Received: from mail.gmx.net ([213.165.64.20]:55775 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750857AbZJVRm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 13:42:26 -0400
Received: (qmail invoked by alias); 22 Oct 2009 17:42:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO felix-maschine.local) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 22 Oct 2009 19:42:29 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19//mkk6F5//gFJwMRZd+NZfj+wqIaAgTt2Y1JY3O
	egUphPno9y9l+G
X-X-Sender: johannes@felix-maschine
In-Reply-To: <1256144691-2908-1-git-send-email-kusmabite@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131035>

Hi,

On Wed, 21 Oct 2009, Erik Faye-Lund wrote:

> Here's the 5th iteration of my patches for Windows-compatibility in 
> imap-send.
> 
>  - Patch 1-3 is about getting rid of or rewriting
>    code with portability issues.
>  - Patch 4 fixes a compilation error on Windows
>  - Patch 5 enables compilation of imap-send
>  - Patch 6-7 enables SSL-suport for mingw
>  - Patch 8 enables imap-send and SSL for msvc
> 
> The only change compared to the previous iteration
> is that patch 7 and 8 enables NEEDS_CRYPTO_WITH_SSL.
> 
> Please note that I haven't tested Patch 8 with
> NEEDS_CRYPTO_WITH_SSL under MSVC, as I don't have a
> working setup with both msysgit and MSVC installed.
> 
> I'd love it if someone with such a working setup
> could verify that it works, preferrably also with
> BLK_SHA1 enabled.

If there are no objections, I will apply them tomorrow.

Ciao,
Dscho
