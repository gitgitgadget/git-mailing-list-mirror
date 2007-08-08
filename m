From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Mod. gitk to support REBASE (with stash support).
Date: Wed, 8 Aug 2007 21:42:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708082141170.21916@wbgn129.biozentrum.uni-wuerzburg.de>
References: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, paulus@samba.org
To: Alexandre Bourget <alexandre.bourget@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:42:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrQK-0003s2-JB
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763685AbXHHTmW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765486AbXHHTmW
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:42:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:46590 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1763061AbXHHTmV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:42:21 -0400
Received: (qmail invoked by alias); 08 Aug 2007 19:42:20 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp017) with SMTP; 08 Aug 2007 21:42:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/IfdhpK/LITS6485dOfU/XOFKL8uxIgESlCc1e+X
	LAzIVvrEcvfhkh
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <1186598028457-git-send-email-alexandre.bourget@savoirfairelinux.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55348>

Hi,

On Wed, 8 Aug 2007, Alexandre Bourget wrote:

> ---
> Adds a context menu for commits, so that a 'rebase' can be done.
> 
> Optionally, it will ask if you want to 'stash' current work before doing so.
> 

You want something like this as a commit message, _not_ between "---" and 
diffstat.

General question: should this not be in git-gui rather than gitk?  Gitk as 
of now is really more a viewing tool.

Ciao,
Dscho
