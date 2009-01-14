From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 20:40:42 +0100
Message-ID: <20090114194042.GB15129@m62s10.vlinux.de>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com> <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com> <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com> <496D9572.2090303@viscovery.net> <2729632a0901140008r59e429aeq3ce367e1bc7df71@mail.gmail.com> <496DA3B2.1070807@viscovery.net> <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 20:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBcL-0005Wy-DC
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 20:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756582AbZANTj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 14:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbZANTj6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 14:39:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:45408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756231AbZANTj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 14:39:57 -0500
Received: (qmail invoked by alias); 14 Jan 2009 19:39:48 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp006) with SMTP; 14 Jan 2009 20:39:48 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18QRDd2MwAQjJQTwyIUzbYxAmOkJ3B0SxIL39qMAe
	GyDJg0Bk4mx7IG
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id B7A5B18146; Wed, 14 Jan 2009 20:40:42 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <2729632a0901141033p47b4d8dah46f5bac27307d306@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105687>

On Wed, Jan 14, 2009 at 10:33:02AM -0800, skillzero@gmail.com wrote:
> On Wed, Jan 14, 2009 at 12:34 AM, Johannes Sixt <j.sixt@viscovery.net>
> wrote:
> 
[ ... ]
  
> Related to this, is there a way to easily find the common merge base
> given a bunch of a branches? When I want to fix a bug, I want to say
> "Given branches A, B, C, D, and E, where should I fork my bug fix
> branch from so that I can merge this branch into all those branches
> without getting duplicate commits?".

You should have a look at 'git help merge-base'

-Peter
