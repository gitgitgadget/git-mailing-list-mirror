From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/9] Enable wt-status output to a given FILE pointer.
Date: Thu, 6 Sep 2007 17:27:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709061726010.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-653703240-1189096079=:28586"
Cc: git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 18:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITKDL-0002PY-T0
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 18:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752803AbXIFQ2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 12:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbXIFQ2P
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 12:28:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:48374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752014AbXIFQ2O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 12:28:14 -0400
Received: (qmail invoked by alias); 06 Sep 2007 16:28:12 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp010) with SMTP; 06 Sep 2007 18:28:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/4nFgxK9j4MLDonNhvU6sx/v5fPNl137sGq5333D
	VOgsHYkL2YrCpL
X-X-Sender: gene099@racer.site
In-Reply-To: <11890382183913-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57899>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-653703240-1189096079=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 5 Sep 2007, Kristian Høgsberg wrote:

> Still defaults to stdout, but you can now override wt_status.fp after 
> calling wt_status_prepare().

Would it not be easier to freopen(filename, "a", stdout)?

Ciao,
Dscho

--8323584-653703240-1189096079=:28586--
