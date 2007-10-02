From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 2 Oct 2007 13:52:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710021350510.28395@racer.site>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org> <7vfy11yyxk.fsf@gitster.siamese.dyndns.org>
 <7v3awunjup.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 14:53:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IchFf-0006qf-Bi
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 14:53:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532AbXJBMxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2007 08:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753373AbXJBMxT
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 08:53:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:53763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752576AbXJBMxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 08:53:18 -0400
Received: (qmail invoked by alias); 02 Oct 2007 12:53:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 02 Oct 2007 14:53:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WKhd6S+1WYn53a6jaeEnQGCLjaEIyTDXZhfe2j5
	tL87kKxDX2yw9V
X-X-Sender: gene099@racer.site
In-Reply-To: <7v3awunjup.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59690>

Hi,

On Mon, 1 Oct 2007, Junio C Hamano wrote:

> I am not sure the quality of "rsync" transport near the tip, either, but 
> at least the change should not affect other transports.  Nobody should 
> using about rsync transport these days anyway.  Perhaps we should put a 
> deprecation notice in the release notes to 1.5.4, and remove it three 
> months later.

Why not keep it?  It's not like it hurts somebody, and in some 
circumstances (lacking git on the remote side, where it was served via 
http) I found it really convenient.

Ciao,
Dscho
