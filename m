From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make verify-tag a builtin.
Date: Mon, 23 Jul 2007 23:32:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707232332000.14781@racer.site>
References: <46A3F43C.3030101@gmail.com>  <Pine.LNX.4.64.0707230141080.14781@racer.site>
  <1b46aba20707231421k54ad2796i5c2f21cf11b4bea5@mail.gmail.com> 
 <Pine.LNX.4.64.0707232242430.14781@racer.site>
 <1b46aba20707231531i4e05858foef3ee81479e559de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Carlos Rica <jasampler@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 00:32:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID6SU-0007J8-Ms
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 00:32:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbXGWWcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 18:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755044AbXGWWcv
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 18:32:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:37398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756534AbXGWWcu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 18:32:50 -0400
Received: (qmail invoked by alias); 23 Jul 2007 22:32:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 24 Jul 2007 00:32:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19UseAQZCZUKe+9bPT0pbFDVuJVwDmw5g5WlKDl9B
	UEsxHtXH/gRiYn
X-X-Sender: gene099@racer.site
In-Reply-To: <1b46aba20707231531i4e05858foef3ee81479e559de@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53495>

Hi,

On Tue, 24 Jul 2007, Carlos Rica wrote:

> 2007/7/23, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Just one request: please use lock_file, to prevent multiple instances from
> > getting confused...  Even if that cannot be 100% secure: if you write to
> > the file, and only then start gpg, there is still the odd chance for an
> > attacker.  Even if you created the file with 0600 (very wise, BTW).
> 
> Why not using also a random name for the temporary file?
> Something like "VTAG_TMP30946".

Yes, makes sense.  One call to mkstemp() away.

Ciao,
Dscho
