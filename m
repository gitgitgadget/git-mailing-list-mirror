From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Thu, 19 Oct 2006 01:38:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610190134040.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45349162.90001@op5.se> <453536AE.6060601@utoronto.ca> <200610172301.27101.jnareb@gmail.com>
 <45354AD0.1020107@utoronto.ca> <BAYC1-PASMTP07AB11A64250AAF683424DAE0E0@CEZ.ICE>
 <45355CBB.80108@utoronto.ca> <BAYC1-PASMTP01369CD694D75CB61ACCC7AE0E0@CEZ.ICE>
 <eh64tk$rug$2@sea.gmane.org> <20061018172945.c0c58c38.seanlkml@sympatico.ca>
 <20061018213703.GE19194@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 01:40:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaL19-0006cw-KR
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 01:40:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423158AbWJRXi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 19:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423151AbWJRXi6
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 19:38:58 -0400
Received: from mail.gmx.de ([213.165.64.20]:62437 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423158AbWJRXis (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 19:38:48 -0400
Received: (qmail invoked by alias); 18 Oct 2006 23:38:46 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 19 Oct 2006 01:38:46 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018213703.GE19194@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29299>

Hi,

On Wed, 18 Oct 2006, Shawn Pearce wrote:

> Today Git doesn't run natively on Windows.

As I mentioned some time ago, I started a branch on MinGW. It works quite 
well for the moment, but it lacks fork() emulation, and glob() emulation. 
And I lack the time to continue working on it.

> Today Git is typically extended (at least initially in prototyping
> mode) through Perl, Python, TCL or Bourne shell scripts.  Although
> the first three are available natively on Windows the last requires
> Cygwin... and we've had some issues with ActiveState Perl on Windows
> in the past too.

Those are not the only problems with scripting. Scripting is fine for 
prototyping, but _anything_ remotely serious should be implemented using a 
portable (!) and safe (!) API.

Ciao,
Dscho
