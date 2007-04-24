From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] plumber's puzzle
Date: Tue, 24 Apr 2007 10:36:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704241034220.6954@racer.site>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
 <7vps5wkph5.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
 <462D5487.2000601@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:36:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGVV-000521-LW
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031053AbXDXIgM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 04:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031060AbXDXIgM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:36:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:36919 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1031053AbXDXIgL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 04:36:11 -0400
Received: (qmail invoked by alias); 24 Apr 2007 08:36:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 24 Apr 2007 10:36:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Ky+NTtxEKVwMpkLCCz65Cj+mpMk8lBDDHkxnvV2
	ylRbrppDzTSXeD
X-X-Sender: gene099@racer.site
In-Reply-To: <462D5487.2000601@zytor.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45430>

Hi,

On Mon, 23 Apr 2007, H. Peter Anvin wrote:

> It might be worthwhile to have a wrapper function for fork() which adds 
> fflush(NULL); before forking?

It might be worthwhile to have wrapper functions which do much more than 
that. If only to help portability. FWIW, the MinGW port has some nice code 
which I'd like to see back in git.git.

Ciao,
Dscho
