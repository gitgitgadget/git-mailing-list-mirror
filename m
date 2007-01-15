From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit signing
Date: Mon, 15 Jan 2007 14:45:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701151443440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701151301.l0FD1vPg007623@laptop13.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 20:03:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6W2T-0000UT-LH
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:54:33 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAH-0003eK-LM
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbXAONpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 08:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbXAONpy
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 08:45:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:44899 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932378AbXAONpx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 08:45:53 -0500
Received: (qmail invoked by alias); 15 Jan 2007 13:45:51 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 15 Jan 2007 14:45:51 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
In-Reply-To: <200701151301.l0FD1vPg007623@laptop13.inf.utfsm.cl>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36856>

Hi,

On Mon, 15 Jan 2007, Horst H. von Brand wrote:

> Andy Parkins <andyparkins@gmail.com> wrote:
> 
> >     It is certainly true that signed commits /is/ a feature.  And it's a 
> > feature that some people might want.  If there isn't a technical argument 
> > against it, what does it matter?
> 
> It needs to be accomodated in the commit object format, so it means
> an(other) incompatible change there.

No. A signature can be appended to any text (which a raw commit buffer 
is), and git allows for appending that signature before writing the object 
(which also gives it the final object name). So, no commit object format 
change necessary.

Ciao,
Dscho
