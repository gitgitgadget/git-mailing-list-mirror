From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: fast-import and core.autocrlf option
Date: Mon, 23 Jul 2007 00:41:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707230039560.14781@racer.site>
References: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 01:41:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICl3T-0000Wp-5b
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 01:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933126AbXGVXlR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 19:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933115AbXGVXlQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 19:41:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:49065 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933098AbXGVXlP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 19:41:15 -0400
Received: (qmail invoked by alias); 22 Jul 2007 23:41:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp057) with SMTP; 23 Jul 2007 01:41:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/EWCE8jLzERDUs+2Mir8eTpaAoPom7Nl9vwN680D
	1AW0gncbbxmALP
X-X-Sender: gene099@racer.site
In-Reply-To: <a1bbc6950707221559m63fb1295jc26b1327e71687e3@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53369>

Hi,

On Sun, 22 Jul 2007, Dmitry Kakurin wrote:

> It looks to me that CR/LF conversion does not happen during
> fast-import even if I have core.autocrlf set to 'input'.
> Is this a bug or is there a reason for that?

fast-import works on blobs only.  So it is expected.  Besides, it would 
slow down fast-import tremendously if you wanted to introduce that 
behaviour.  Therefore I suggest just rolling your own dos2unix instead of 
trying to play cute games with fast-import.

Ciao,
Dscho
