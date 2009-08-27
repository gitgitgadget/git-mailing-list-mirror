From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git clone http://git.savannah.gnu.org/cgit/xboard.git
 segfaults
Date: Thu, 27 Aug 2009 09:39:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908270938480.7562@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0908171620160.4991@intel-tinevez-2-302> <20090817135651.GA4570@harikalardiyari> <20090826202053.6e6442a6.rctay89@gmail.com> <20090826131235.GF16486@harikalardiyari>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1669151199-1251358796=:7562"
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Ali Polatel <polatel@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 09:40:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgZaY-0005ov-CP
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 09:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbZH0Hjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 03:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbZH0Hjz
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 03:39:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:46643 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751244AbZH0Hjz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 03:39:55 -0400
Received: (qmail invoked by alias); 27 Aug 2009 07:39:56 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp071) with SMTP; 27 Aug 2009 09:39:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+tuVVem8WtMRE6WVYzPyDoA1jy9nAT1uyyNuw0iD
	oYkF5eR9NvHGcs
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090826131235.GF16486@harikalardiyari>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127147>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1669151199-1251358796=:7562
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 26 Aug 2009, Ali Polatel wrote:

> Tay Ray Chuan yazmış:
> 
> > On Mon, Aug 17, 2009 at 10:22 PM, Johannes Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > > Seems that an object request is aborted, but the slot, and therefore 
> > > the callback, is called nevertheless.  Tay, does that ring a bell?
> > 
> > thanks Johannes, your diagnosis was a vital clue.
> > 
> > Ali, could you see if this patch fixes it for you? On my side, I had
> > some difficulty reproducing your problem reliably (it happened
> > sometimes but not on other times).
> > 
> 
> It works, I don't get any segfaults after applying this patch.

Great!

But why did you drop me from the Cc: list?  It's not every day that I can 
pay that close attention to the mails I get; mails which are not addressed 
to me directly fall off the plate on other days...

Ciao,
Dscho

--8323329-1669151199-1251358796=:7562--
