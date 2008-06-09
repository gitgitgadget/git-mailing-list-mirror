From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] git-add--interactive: manual hunk editing mode
Date: Mon, 9 Jun 2008 17:13:08 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806091709350.1783@racer>
References: <200805232221.45406.trast@student.ethz.ch> <200806090032.27516.trast@student.ethz.ch> <alpine.DEB.1.00.0806090018350.1783@racer> <200806090746.22512.johan@herland.net> <20080609122938.GA12210@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:15:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5k1o-0004as-QL
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbYFIQOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbYFIQOe
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:14:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:34505 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750794AbYFIQOe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:14:34 -0400
Received: (qmail invoked by alias); 09 Jun 2008 16:14:31 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp043) with SMTP; 09 Jun 2008 18:14:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PJChxMj1PgMuDPF32EIlC2v7RNGmvZCHP/1lJpx
	NXSvJMqwFRW6t+
X-X-Sender: gene099@racer
In-Reply-To: <20080609122938.GA12210@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84397>

Hi,

On Mon, 9 Jun 2008, Jeff King wrote:

> On Mon, Jun 09, 2008 at 07:46:22AM +0200, Johan Herland wrote:
> 
> And I was hoping the right way to do it was to simply build the 
> interactive "e" command on top of Johannes' git-apply work. But I don't 
> think that quite makes sense. His work is about fixing up the hunk 
> header as we apply the patch, but a working "e" command in the hunk 
> selection should probably not actually apply, but simply split into two 
> hunks for the loop.

Well, maybe I am silly, but I thought that the idea with add -i (e) was 
to split off the first part, ask the user if that should be applied, and 
then go on with the rest.

But like I said, Junio convinced me that it makes not much sense to split 
somewhere else than common lines, and you have that already with the "s" 
command in add -i.

In any case, I am happy with "add -e", even more so than I though I would 
be, and therefore I do not need add -i (e).  Thus, I will just shut up and 
let you guys work it out.

Ciao,
Dscho
