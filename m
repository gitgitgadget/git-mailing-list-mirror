From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if cur/
 is empty
Date: Tue, 6 Nov 2007 11:01:03 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711061100150.4362@racer.site>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org>
 <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
 <20071105225258.GC4208@steel.home> <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com>
 <20071106072831.GA3021@steel.home> <20071106075150.GA21694@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Michael Cohen <michaeljosephcohen@mac.com>,
	Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 12:02:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpMCD-0000IE-Ua
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 12:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbXKFLB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 06:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbXKFLB7
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 06:01:59 -0500
Received: from mail.gmx.net ([213.165.64.20]:59406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755004AbXKFLB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 06:01:58 -0500
Received: (qmail invoked by alias); 06 Nov 2007 11:01:57 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 06 Nov 2007 12:01:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Oh90JiGXO5+gBpVaZE22BLQOZ8q87ErSuFtFF1O
	V2HPQHuxwNyhk1
X-X-Sender: gene099@racer.site
In-Reply-To: <20071106075150.GA21694@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63659>

Hi,

On Tue, 6 Nov 2007, Jeff King wrote:

> On Tue, Nov 06, 2007 at 08:28:31AM +0100, Alex Riesen wrote:
> 
> > > In Maildir format, cur and new hold the mails. :P
> > 
> > So? Why *STOP* reading the mails if just one of the directories could 
> > not be opened? IOW, I suggest:
> 
> Because you are then trying to apply a patch series with some patches 
> potentially missing? Continuing only on errno == ENOENT seems prudent.

I fail to see how the absence of one of cur/ or new/ can lead to the 
absence of patches.  You could forget to save some patches, yes, but the 
presence of cur/ and new/ is no indicator for that.

Ciao,
Dscho
