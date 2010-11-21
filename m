From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: First/oldest entry in reflog dropped
Date: Sun, 21 Nov 2010 12:36:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1011211233570.2948@bonsai2>
References: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com> <20101121053545.GA10520@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 21 12:36:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK8Dw-0002Yq-Ix
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 12:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473Ab0KULg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Nov 2010 06:36:27 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:34077 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752067Ab0KULg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Nov 2010 06:36:26 -0500
Received: (qmail invoked by alias); 21 Nov 2010 11:36:23 -0000
Received: from pD9EB2DCE.dip0.t-ipconnect.de (EHLO noname) [217.235.45.206]
  by mail.gmx.net (mp021) with SMTP; 21 Nov 2010 12:36:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3FZMAwoa3tWxeTwMNItEuFyHP9GxjbrtUdMOdyP
	DpFyzs28BLMsbo
X-X-Sender: gene099@bonsai2
In-Reply-To: <20101121053545.GA10520@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161861>

Hi,

On Sun, 21 Nov 2010, Jeff King wrote:

> This patch clears up your bug, and doesn't break any tests. But I'd 
> really like to get a second opinion on the significance of those other 
> flags, or why the flag clearing was at the bottom of the function in the 
> first place.

The flag clearing was at the bottom because I had the impression that 
something function one might want to call in that function in the future 
could set the flags again. Maybe a goto would be appropriate here instead 
of the early returns?

Ciao,
Dscho
