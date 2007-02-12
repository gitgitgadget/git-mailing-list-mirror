From: Bruno Haible <bruno@clisp.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 12:27:15 +0100
Message-ID: <200702121227.15757.bruno@clisp.org>
References: <200702111252.28393.bruno@clisp.org> <200702120041.27419.bruno@clisp.org> <Pine.LNX.4.64.0702112009440.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 12:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGZFd-0008Vv-Hg
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 12:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbXBLLVM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 06:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbXBLLVM
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 06:21:12 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:49688 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964858AbXBLLVL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 06:21:11 -0500
Received: from linuix.haible.de (cable-137-244.iesy.net [81.210.137.244])
	by post.webmailer.de (klopstock mo56) (RZmta 4.5)
	with ESMTP id H0103bj1C9PddG ; Mon, 12 Feb 2007 12:21:08 +0100 (MET)
User-Agent: KMail/1.5.4
In-Reply-To: <Pine.LNX.4.64.0702112009440.8424@woody.linux-foundation.org>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY4JDyuz6KRYg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39393>

Linus,

> >   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
> >   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)
> 
> That's an interesting fact in itself.

Sorry, these measurements happened to be done in different conditions:
repo fully cached in RAM vs. repo not yet in buffer cache / page cache.

When measured under the same conditions, no speed difference is visible
between git-1.4.4 and git-1.5.0-rc4.

Bruno
