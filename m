From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] This exports the update() function from builtin-add.c
 as
Date: Thu, 27 Sep 2007 12:47:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709271245570.28395@racer.site>
References: <1190868632-29287-1-git-send-email-krh@redhat.com>
 <1190868632-29287-2-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-374614805-1190893629=:28395"
Cc: gitster@pobox.com, git@vger.kernel.org
To: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:48:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iarqx-0005mO-Qd
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 13:48:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbXI0LsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 07:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbXI0LsQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 07:48:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:49711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1749667AbXI0LsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 07:48:16 -0400
Received: (qmail invoked by alias); 27 Sep 2007 11:48:14 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 27 Sep 2007 13:48:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pFKoQ9YBpEGJy8WRp6mOwJz4nEfwtm1L6fF7rLv
	YfYjCb/CJ5jf0s
X-X-Sender: gene099@racer.site
In-Reply-To: <1190868632-29287-2-git-send-email-krh@redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59290>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-374614805-1190893629=:28395
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 27 Sep 2007, Kristian Høgsberg wrote:

>  builtin-add.c |    8 ++++----
>  commit.h      |    2 ++

Maybe move it to read-cache.c, just after "add_file_to_index()"?  And 
expose it via cache.h, not commit.h?

Ciao,
Dscho

--8323584-374614805-1190893629=:28395--
