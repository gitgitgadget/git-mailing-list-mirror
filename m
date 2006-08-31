From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Compiling git-snapshot-20069831
Date: Thu, 31 Aug 2006 17:28:37 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608311727010.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44F6D016.4050007@users.sourceforge.net>
 <Pine.LNX.4.63.0608311408350.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <44F6F478.1070708@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 31 17:31:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GIoTD-0004vH-GV
	for gcvg-git@gmane.org; Thu, 31 Aug 2006 17:28:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWHaP2k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 Aug 2006 11:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751649AbWHaP2j
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Aug 2006 11:28:39 -0400
Received: from mail.gmx.de ([213.165.64.20]:15490 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751647AbWHaP2j (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Aug 2006 11:28:39 -0400
Received: (qmail invoked by alias); 31 Aug 2006 15:28:37 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp013) with SMTP; 31 Aug 2006 17:28:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jorma Karvonen <karvjorm@users.sourceforge.net>
In-Reply-To: <44F6F478.1070708@users.sourceforge.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26266>

Hi,

On Thu, 31 Aug 2006, Jorma Karvonen wrote:

> Johannes Schindelin wrote:
> > Hi,
> > 
> > since you do have a recent snapshot, why not try ./configure, as Pasky
> > suggested?
> > 
> > BTW I cannot read Finnish, but it probably says that you do not have curl
> > installed. configure would detect that, and automatically set NO_CURL=1.
> > 
> > Ciao,
> > Dscho
> > 
> > 
> >   
> Sorry,
> 
> but I have not any git installed and there is no configure file in installing
> directory.

Ooops. As mentioned elsewhere, try "make configure" first.

> When I tested 
> make NEEDS_LIBICONV=1 NO_CURL=1
> 
> the make succeeded but when trying make install I got error messages shown in
> the enclosed file.

You forgot to say "NEEDS_LIBICONV=1 NO_CURL=1" with the "make install":

	make NEEDS_LIBICONV=1 NO_CURL=1 install

This would not be necessary with ./configure, since it writes these 
settings into a file, which is read by "make".

Ciao,
Dscho
