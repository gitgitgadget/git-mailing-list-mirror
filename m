From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Recover a stash
Date: Wed, 24 Oct 2007 18:42:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710241841080.25221@racer.site>
References: <598D5675D34BE349929AF5EDE9B03E27016E5841@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 19:43:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkkG3-0002x6-5O
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 19:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbXJXRmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 13:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752908AbXJXRmx
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 13:42:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:49600 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752564AbXJXRmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 13:42:52 -0400
Received: (qmail invoked by alias); 24 Oct 2007 17:42:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp024) with SMTP; 24 Oct 2007 19:42:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18B0nYMQaYBljEppqea73wQC+sOBvrtfecJVxoivt
	ZVc07ql5b61ERv
X-X-Sender: gene099@racer.site
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27016E5841@az33exm24.fsl.freescale.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62223>

Hi,

On Wed, 24 Oct 2007, Medve Emilian-EMMEDVE1 wrote:

> Is there any way to recover a stash as a... stash? I accidently removed 
> a stash I still need and I'd like to recover it as a stash. I can see 
> the dangling commit objects in the database with git lost-found and I 
> can have a branch/head point at them, but it's not understood as stash 
> anymore.

You should be able to recover it with

	git update-ref refs/stash <commit>

Where the <commit> points to the merge commit of the stashed index and the 
stashed working directory.

Hth,
Dscho
