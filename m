From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use diff3 instead of merge in merge-recursive.
Date: Sat, 21 Oct 2006 02:06:44 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610210203390.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061018085949.GA26501@cepheus.pub>
 <Pine.LNX.4.63.0610181135120.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061020211121.GB3024@cepheus.pub>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 02:07:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb4OI-0007MO-UM
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 02:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992741AbWJUAGq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 20:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992527AbWJUAGq
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 20:06:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:44704 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423251AbWJUAGq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 20:06:46 -0400
Received: (qmail invoked by alias); 21 Oct 2006 00:06:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 21 Oct 2006 02:06:44 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20061020211121.GB3024@cepheus.pub>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29561>

Hi,

On Fri, 20 Oct 2006, Uwe Zeisberger wrote:

> Johannes Schindelin wrote:
>
> > I have to dig a little where I have it, but I think I can give it a try in 
> > a few hours (imagine this lyrics to the melody of the day job blues).
>
> Seems to be a long blues because you didn't sent any results. :-(

Yes. It was a long blues, and now instead of going to sleep I tested it. 
In the long run, it was negligible, with a high local variability (which 
stems from the fact that I had to run this test while the machine was 
under high load, which it will be for another 48 hours minimum).

It makes sense that performance-wise, it will not make a great difference. 
After all, the expensive operation is not the file-writing, but the 
merging pass.

Ciao,
Dscho
