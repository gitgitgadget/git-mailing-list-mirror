From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: support single-letter abbreviations for the
 actions
Date: Sat, 29 Sep 2007 21:58:09 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292156090.28395@racer.site>
References: <Pine.LNX.4.64.0709290231300.28395@racer.site> <46FE7D0B.4060806@qumranet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Sat Sep 29 22:59:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbjPN-0004hl-5k
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 22:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752322AbXI2U7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 16:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752270AbXI2U7W
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 16:59:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:49626 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751646AbXI2U7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 16:59:21 -0400
Received: (qmail invoked by alias); 29 Sep 2007 20:59:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 29 Sep 2007 22:59:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181Bb4B8i01iQEQn5+3pkxa2S2htBOpOjWfbLvJwd
	HlTw2gcD0GkDQ2
X-X-Sender: gene099@racer.site
In-Reply-To: <46FE7D0B.4060806@qumranet.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59489>

Hi,

On Sat, 29 Sep 2007, Avi Kivity wrote:

> Johannes Schindelin wrote:
> > When you do many rebases, you can get annoyed by having to type out 
> > the actions "edit" or "squash" in total.
> > 
> > This commit helps that, by allowing you to enter "e" instead of 
> > "edit", or "s" instead of "squash", and it also plays nice with 
> > "merge" or "amend" as synonyms to "squash".
> 
> Can we make "amend" like squash, except that it keeps the first commit's 
> authorship instead of the second?  I often merge a commit with some 
> minor fix that comes later, and usually want to keep the original author 
> record.

I do not necessarily think it is not doable, but I have different 
suggestion to you:

If you amend the commit with a minor fix that comes later, why not do 
"rebase -i" _before_ applying the fix, and then using "edit" on the 
respective commit?

That way you can even test the result easily, which you cannot do with 
"squash".

Ciao,
Dscho
