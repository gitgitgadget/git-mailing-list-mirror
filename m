From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix warning about bitfield in struct ref
Date: Tue, 20 Nov 2007 00:58:58 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711200058270.16728@wbgn129.biozentrum.uni-wuerzburg.de>
References: <20071118093137.GA2196@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 00:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuGWP-0002P4-6H
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 00:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751985AbXKSX7E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 18:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751976AbXKSX7D
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 18:59:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:58394 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751624AbXKSX7B (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 18:59:01 -0500
Received: (qmail invoked by alias); 19 Nov 2007 23:58:59 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp055) with SMTP; 20 Nov 2007 00:58:59 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19jYpZrPkpjUlISMBhi7wZzfFsAhkeM/9r8qpabUD
	FYSEKoqtMqg3HI
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <20071118093137.GA2196@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65519>

Hi,

On Sun, 18 Nov 2007, Shawn O. Pearce wrote:

> +	unsigned int force:1,

Isn't this "unsigned force:1" everywhere else in git's source?

Ciao,
Dscho
