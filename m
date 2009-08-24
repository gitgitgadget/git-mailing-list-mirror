From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove ARM and Mozilla SHA1 implementations
Date: Mon, 24 Aug 2009 18:52:32 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908241849160.8306@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0908171940540.6044@xanadu.home> <alpine.DEB.1.00.0908180208160.8306@pacific.mpi-cbg.de> <alpine.LFD.2.00.0908240011010.6044@xanadu.home> <alpine.DEB.1.00.0908241333130.11375@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 18:52:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfcmB-0004ma-If
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbZHXQvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 12:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752826AbZHXQvc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 12:51:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:34584 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752456AbZHXQvb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 12:51:31 -0400
Received: (qmail invoked by alias); 24 Aug 2009 16:51:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp049) with SMTP; 24 Aug 2009 18:51:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IEC0gAy9IZGKXG+gL4YypyaRhBMSySECC+oeU/+
	PeTboBztnfpjWA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0908241333130.11375@intel-tinevez-2-302>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126943>

Hi,

On Mon, 24 Aug 2009, Johannes Schindelin wrote:

> On Mon, 24 Aug 2009, Nicolas Pitre wrote:
> 
> > On Tue, 18 Aug 2009, Johannes Schindelin wrote:
> > 
> > > On Mon, 17 Aug 2009, Nicolas Pitre wrote:
> > > 
> > > > They are both slower than the new BLK_SHA1 implementation, so it is 
> > > > pointless to keep them around.
> > > > 
> > > > Signed-off-by: Nicolas Pitre <nico@cam.org> ---
> > > > 
> > > > Someone else would need to make the call for the PPC version.
> > > 
> > > If I don't forget, I can test tomorrow on 2 different 32-bit PPCs and 
> > > possibly one 64-bit PPC.
> > 
> > Did you forget?  ;-)
> 
> Yes.

At long last (XTools took a real long time to install here; it is an old 
PowerPC running MacOSX):

Best of 10 "git rev-list --all" runs on a full Git repository (including 
my own tree):

before 30ae47b4

	1.85 real, 1.52 user, 0.28 sys

after 30ae47b4

	1.86 real, 1.52 user, 0.28 sys

To be frank, the 1.85 looks like an outlier, so I think there is exactly 0 
difference between the two.

If you want me to perform other tests, please let me know; I'll be back at 
this computer tomorrow.

Ciao,
Dscho
