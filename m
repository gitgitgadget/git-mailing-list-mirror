From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make gitk work reasonably well on Cygwin.
Date: Thu, 1 Feb 2007 10:20:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011016430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAY13-F213DF79906B3889D42369D0A50@phx.gbl>
 <Pine.LNX.4.63.0701311612420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C14563.8060707@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Thu Feb 01 10:20:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCY7F-0005k1-KW
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 10:20:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422702AbXBAJUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 04:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422703AbXBAJUW
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 04:20:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:40304 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422702AbXBAJUV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 04:20:21 -0500
Received: (qmail invoked by alias); 01 Feb 2007 09:20:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 01 Feb 2007 10:20:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45C14563.8060707@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38335>

Hi,

On Wed, 31 Jan 2007, Mark Levedahl wrote:

> 1) Regarding the size of the patch. I tried many different approaches to 
> getting the layout to work on Cgywin as well as Linux, ultimately the 
> only approach that worked required changing the very top level structure 
> containing the Tk widgets. As the style used names all widgets using 
> their parents, every widget's name is changed. This makes the patch seem 
> more complex than it is, many changes are just changing names.

Well, I don't like the size mainly because it makes it absolutely 
impossible for me to review it. After 20 lines of just renamed widget 
paths I really lose all my concentration.

And then I find that you also fixed whitespace breakage, which does not 
belong in this patch.

Ciao,
Dscho
