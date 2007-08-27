From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git and OpenDocument (OpenOffice.org) files
Date: Mon, 27 Aug 2007 14:41:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708271440500.28586@racer.site>
References: <vpqk5rh5mp5.fsf@bauges.imag.fr> <7vps19jnm1.fsf@gitster.siamese.dyndns.org>
 <vpqtzql17gd.fsf@bauges.imag.fr> <20070827130346.GA8821@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Aug 27 15:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPeoE-0007Q7-CR
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 15:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbXH0NjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Aug 2007 09:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXH0NjJ
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Aug 2007 09:39:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:60025 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751804AbXH0NjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2007 09:39:06 -0400
Received: (qmail invoked by alias); 27 Aug 2007 13:39:05 -0000
Received: from ppp-82-135-74-69.dynamic.mnet-online.de (EHLO [192.168.1.4]) [82.135.74.69]
  by mail.gmx.net (mp035) with SMTP; 27 Aug 2007 15:39:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19TqgV/7OJTjqEHiDpKuvjG9IH0IXjc+ZDoglb+Co
	GNhAc2onWIe8PS
X-X-Sender: gene099@racer.site
In-Reply-To: <20070827130346.GA8821@glandium.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56835>

Hi,

On Mon, 27 Aug 2007, Mike Hommey wrote:

> On Mon, Aug 27, 2007 at 02:35:14PM +0200, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> > 
> > > Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> > >
> > >> Remarks are welcome (I'll post some remarks about Git's custom diff
> > >> driver in a separate thread).
> > >
> > > Good.
> > >
> > > I think creation/deletion will get /dev/null as the temporary
> > > file name, so as long as odt2txt knows how to deal with
> > > /dev/null you would not have to worry much about them.
> > 
> > But odt2txt doesn't know how to deal with /dev/null. New version of
> > git-oodiff that manages it correctly online and below.
> 
> BTW, wouldn't it be more efficient to store the odf files unzipped ?

Efficient how?  Speed-wise: no.  Space-wise: yes.

Ciao,
Dscho
