From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] clone: support cloning full bundles
Date: Wed, 12 Dec 2007 14:50:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712121449310.27959@racer.site>
References: <1197456485-22909-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-1479828053-1197471015=:27959"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 15:51:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Sv9-00014i-Fu
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 15:50:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbXLLOuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 09:50:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbXLLOuU
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 09:50:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:40894 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751682AbXLLOuS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 09:50:18 -0500
Received: (qmail invoked by alias); 12 Dec 2007 14:50:15 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp046) with SMTP; 12 Dec 2007 15:50:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/wfXE7ciDwyUBGHfS52ElMK5RS3HqXhKX4WCaHIF
	3H6oRuoRMLWiw6
X-X-Sender: gene099@racer.site
In-Reply-To: <1197456485-22909-1-git-send-email-sbejar@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68041>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-1479828053-1197471015=:27959
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 12 Dec 2007, Santi Béjar wrote:

> It still fails for incremental bundles.

Of course it does.  The whole point of incremental bundles is that they do 
_not_ contain all objects, but rely on some objects being present on the 
"fetch" side.

Hth,
Dscho
---1463811741-1479828053-1197471015=:27959--
