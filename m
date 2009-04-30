From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Thu, 30 Apr 2009 08:07:31 +0200
Message-ID: <20090430060731.GA4106@pvv.org>
References: <7v4ow8my1u.fsf@gitster.siamese.dyndns.org> <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost> <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org> <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org> <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com> <alpine.DEB.1.00.0904300011140.10279@pacific.mpi-cbg.de> <81b0412b0904291519m41035200n408b6ab409eed127@mail.gmail.com> <alpine.DEB.1.00.0904300037300.10279@pacific.mpi-cbg.de> <81b0412b0904292247tdcf515bs67f809b559ac2504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 08:07:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzPR4-0007Uk-FZ
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 08:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbZD3GHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 02:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbZD3GHq
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 02:07:46 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:46056 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985AbZD3GHq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 02:07:46 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LzPQh-0007ol-4E; Thu, 30 Apr 2009 08:07:31 +0200
Content-Disposition: inline
In-Reply-To: <81b0412b0904292247tdcf515bs67f809b559ac2504@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117992>

On Thu, Apr 30, 2009 at 07:47:57AM +0200, Alex Riesen wrote:
> 2009/4/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > On Thu, 30 Apr 2009, Alex Riesen wrote:
> >> http://www.google.com/search?q=snprintf+negative+return+value
> >>
> >> First link: http://bytes.com/groups/c/590845-snprintf-return-value
> >>
> >> Look for "(Windows, mingw)"
> >
> > No, I will not.
> >
> 
> "The following are the results from different systems:
> gcc 3.3 (Mac OS X): 10
> gcc 3.4.5 (Windows, mingw): -1
> BC++ 5.5.1 (Windows): 10
> MS VC++ 6.0 and 2005 (Windows, _snprintf() used): -1
> DigitalMars 8.42n (Windows): -1"

snprintf always (on all these arechitectures) returns the number of
characters written if the buffer is large enough. In the code we are
discussing here the buffer is always large enough, so this is not a
problem.

- Finn Arne
