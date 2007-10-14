From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] add get_sha1_with_real_ref() returning full name of
 ref on demand
Date: Sun, 14 Oct 2007 18:21:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710141819490.25221@racer.site>
References: <11923520851713-git-send-email-prohaska@zib.de>
 <1192352085653-git-send-email-prohaska@zib.de> <11923520852991-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 14 19:21:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih79Z-0001KY-9K
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 19:21:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753866AbXJNRVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 13:21:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755080AbXJNRVP
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 13:21:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:57297 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751666AbXJNRVO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 13:21:14 -0400
Received: (qmail invoked by alias); 14 Oct 2007 17:21:13 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 14 Oct 2007 19:21:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18i2lhyPFoi7sZoNt/EIUJpx2vxb9/i67KcQ3227u
	jj47z8Y3Atexr/
X-X-Sender: gene099@racer.site
In-Reply-To: <11923520852991-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60876>

Hi,

On Sun, 14 Oct 2007, Steffen Prohaska wrote:

> Deep inside get_sha1() the name of the requested ref is matched
> according to the rules documented in git-rev-parse. This patch
> introduces a function that returns the full name of the matched
> ref to the outside.
> 
> For example 'master' is typically returned as 'refs/heads/master'.
> 
> The new function can be used by "git rev-parse" to print the full
> name of the matched ref and can be used by "git send-pack" to expand
> a local ref to its full name.

I have not really studies your patch, but from your description it sounds 
as if dwim_ref() does what you want.

Ciao,
Dscho
