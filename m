From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] rev-list: implement --bisect-all
Date: Mon, 8 Oct 2007 06:08:58 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710080607180.4174@racer.site>
References: <20071008053438.6a829b91.chriscool@tuxfamily.org>
 <Pine.LNX.4.64.0710080442420.4174@racer.site> <200710080708.46579.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio Hamano <junkio@cox.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 07:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iekrs-0003cc-Bo
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 07:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbXJHFJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 01:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbXJHFJP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 01:09:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:45882 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750862AbXJHFJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 01:09:14 -0400
Received: (qmail invoked by alias); 08 Oct 2007 05:09:12 -0000
Received: from unknown (EHLO [172.17.38.182]) [38.99.84.33]
  by mail.gmx.net (mp018) with SMTP; 08 Oct 2007 07:09:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18pQD5Rt9MpkEsVnIe/zgwjPPg69yIEuLhwQ6NJf7
	ja+M0LITbjFK17
X-X-Sender: gene099@racer.site
In-Reply-To: <200710080708.46579.chriscool@tuxfamily.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60290>

Hi,

On Mon, 8 Oct 2007, Christian Couder wrote:

> > IMHO such a logic does not belong into a shell script, but into the C 
> > core.
> 
> There is a lot of the bisect logic implemented in git-bisect.sh already. 
> The long term plan is to rewrite it in C,

Oh?  Did I miss something?

> but I am not sure that the "dunno" logic should be the first part of it 
> to be done in C.

The thing is, git-bisect is porcelain-ish.  And by having a lot of the 
functionality there, which is not really porcelain, but plumbing, you 
prevent other porcelains, such as git-gui or qgit, from using that 
function.

Which is bad.

Ciao,
Dscho
