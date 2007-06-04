From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH 1/6] Refactor git tag objects; make "tag" header optional; introduce new optional "keywords" header
Date: Mon, 4 Jun 2007 08:08:12 +0200
Message-ID: <20070604060812.GC15148@moooo.ath.cx>
References: <200706040251.05286.johan@herland.net> <200706040251.52613.johan@herland.net> <200706040252.55152.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 08:08:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv5jp-0001Im-Fp
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 08:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbXFDGIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 02:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002AbXFDGIP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 02:08:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:40807 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751994AbXFDGIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 02:08:14 -0400
Received: (qmail invoked by alias); 04 Jun 2007 06:08:13 -0000
Received: from pd9ebb5ac.dip0.t-ipconnect.de (EHLO moooo.ath.cx) [217.235.181.172]
  by mail.gmx.net (mp031) with SMTP; 04 Jun 2007 08:08:13 +0200
X-Authenticated: #5358227
X-Provags-ID: V01U2FsdGVkX1+ee+x3UIaePxYe2kgiPHrM/ajnlnsxkwJ9z9znnl
	Lsu2aP8KLrfFeR
Content-Disposition: inline
In-Reply-To: <200706040252.55152.johan@herland.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49067>

Johan Herland <johan@herland.net> wrote:
> 1. Make the "tag" header optional. The "tag" header contains the tag name,
>    which is optional for 'notes'. The new semantics for the "tag" header
>    are as follows: The tag header _must_ be given for signed tags (this
>    is already enforced by git-tag.sh). When the tag header is not given,
>    its value defaults to the empty string.

Why must signed tags have a tag header?  Will notes optionally have a
tag header?
