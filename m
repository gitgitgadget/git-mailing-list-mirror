From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: sparse support in pu
Date: Mon, 17 Aug 2009 14:29:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908171425410.4991@intel-tinevez-2-302>
References: <2729632a0908162309ma6e7d41kc3bafe4575120630@mail.gmail.com>  <fcaeb9bf0908170117v67e9f8b1ga56edcda14821e91@mail.gmail.com>  <2729632a0908170149o425544dcw52aeb6ac6ee1437d@mail.gmail.com>  <fcaeb9bf0908170321o43fa4a6bv95dd78ff7889686f@mail.gmail.com>
  <4A8932BB.7030002@viscovery.net> <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>, skillzero@gmail.com,
	git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 14:31:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md1Mr-0001su-2O
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 14:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbZHQM3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 08:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbZHQM3Q
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 08:29:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:36012 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750926AbZHQM3P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 08:29:15 -0400
Received: (qmail invoked by alias); 17 Aug 2009 12:29:15 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp062) with SMTP; 17 Aug 2009 14:29:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mkG599n/mVEBjwnvFm3xvTl8l7l79aY5D1TZGnA
	rP3j7tm3kEwdfa
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <fcaeb9bf0908170441o30005085nb0d4e08f333b6146@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126163>

Hi,

On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:

> On Mon, Aug 17, 2009 at 5:36 PM, Johannes Sixt<j.sixt@viscovery.net> wrote:
>
> > In order to advocate my earlier proposal: Name the file 
> > .git/info/phantoms, then it's clear: "The files mentioned here are 
> > phantoms" - they exist in the index, but not in the worktree; no 
> > phantoms means that everything is checked out.
> 
> OK. Phantom checkout, must be unique in VCS world ;-) If no one objects 
> my next series will use this name as it's better than "sparse" and 
> "assume-unchanged" is just too vague. Would option names to 
> enable/disable this be --with[out]-phantoms?

The term 'phantom' is not specified at all.  At least interested people on 
the mailing list know 'sparse'.  But I agree that the naming is a major 
problem, hence my earlier (unanswered) call.

However, I would find specifying what you do _not_ want in that file 
rather unintuitive, in the same leage as receive.denyNonFastForwards = no.

If I want to have a sparse checkout, I know which files I _want_.

Ciao,
Dscho
