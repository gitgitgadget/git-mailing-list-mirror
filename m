From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: non-ascii filenames issue
Date: Mon, 6 Apr 2009 11:12:35 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904061109330.10279@pacific.mpi-cbg.de>
References: <20090405093640.GA9803@home> <87ab6v2zor.fsf@iki.fi>  <20090405100127.GA12126@home> <43d8ce650904050351p72590d52l8861b3901f95201a@mail.gmail.com> <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Apr 06 11:12:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqks1-0005Ra-Ud
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 11:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530AbZDFJKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 05:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755517AbZDFJKM
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 05:10:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:58880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755457AbZDFJKL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 05:10:11 -0400
Received: (qmail invoked by alias); 06 Apr 2009 09:10:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 06 Apr 2009 11:10:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19G734fjw9G74q/cEDReAFs9ry5Vr/p6WFbD1vabi
	MEgPO5DT3gOgNA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0904060823400.21376@ds9.cixit.se>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115796>

Hi,

On Mon, 6 Apr 2009, Peter Krefting wrote:

> It comes from the Unix tradition, unfortunately, that file names are 
> just a stream of bytes, instead of a stream of characters mapped to a 
> byte sequence.

How is that different from .txt not having a defined locale?

Really, please, do not add to the non-information.

> Since most people on Linux nowadays probably are running in a 
> UTF-8-based locale, I tried introducing some (very incomplete) patches 
> for the Windows port to make this assumption, to allow Windows users to 
> make use of non-ASCII file names (Windows uses Unicode strings for file 
> names). Mac OS uses (semi-decomposed) UTF-8 strings, so it should also 
> be able to make use of this.

Most Russian programmers I know do not run in a UTF-8 locale.

> Unfortunately, there seems to be quite some resistance towards deciding 
> on a platform- and language-independent way of storing file names in 
> Git, but rather just going the "Unix" way and making it someone elses 
> problem. I find this a bit sad.

I find it a bit unfair that you say that, after many people participated 
in that very informative thread, and after I tried to work with you 
personally on getting the stuff into 4msysgit.git.

Actually, not just only a bit.

Ciao,
Dscho
