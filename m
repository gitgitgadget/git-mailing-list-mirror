From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 33/40] When installing, be prepared that template_dir may be relative.
Date: Thu, 28 Feb 2008 22:12:02 +0100
Message-ID: <200802282212.02683.johannes.sixt@telecom.at>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281542000.22527@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 28 22:13:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUq3Z-0003Ij-TZ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 22:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757939AbYB1VMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 16:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759851AbYB1VMF
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 16:12:05 -0500
Received: from smtp3.srv.eunet.at ([193.154.160.89]:49438 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761504AbYB1VME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 16:12:04 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 222B010ACD9;
	Thu, 28 Feb 2008 22:12:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E61215B9E3;
	Thu, 28 Feb 2008 22:12:02 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LSU.1.00.0802281542000.22527@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75459>

On Thursday 28 February 2008 16:45, Johannes Schindelin wrote:
> Hi,
>
> On Wed, 27 Feb 2008, Johannes Sixt wrote:
> > @@ -1094,6 +1094,13 @@ remove-dashes:
> >
> >  ### Installation rules
> >
> > +ifeq ($(firstword $(subst /, ,$(template_dir))),..)
>
> How portable is "firstword"?  Would it not be better to use

How portable is "patsubst"? ;)

> ifneq ($(patsubst ../%,,$(template_dir)),)

This programming language is sort of write-only, so I don't know because I 
can't read it ;) If you have tested your version and it works and you have 
thought through all consequences (like how does it work if 
template_dir=/a/../b), why not?

-- Hannes
