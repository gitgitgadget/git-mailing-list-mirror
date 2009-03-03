From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Tue, 3 Mar 2009 12:11:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903031141330.6399@intel-tinevez-2-302>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 12:13:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeSYY-0005pM-Cm
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 12:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223AbZCCLLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 06:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZCCLLM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 06:11:12 -0500
Received: from mail.gmx.net ([213.165.64.20]:47525 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754223AbZCCLLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 06:11:11 -0500
Received: (qmail invoked by alias); 03 Mar 2009 11:11:08 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 03 Mar 2009 12:11:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1909/4Gm310y/4A6YvPRPo+Qg3jTjH8dMindqNE01
	Ad6Q5t0xNUZijP
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112051>

Hi,

On Tue, 3 Mar 2009, Junio C Hamano wrote:

> * js/clone-depth-local (Fri Feb 27 00:04:06 2009 -0800) 3 commits
>  . parse_options(): do not "increment" boolean
>  . clone: ignore --depth when cloning locally (implicitly --local)
>  . clone: do not ignore --no-local option
> 
> Jeff had a good suggestion for this series but it was tripped by
> a misfeature in parse_options().

If the issue is that you cannot discern between implicit --no-local and 
--no-local, maybe the solution is to start with option_local = 1.

> * ns/stash-keep (Thu Feb 12 06:25:14 2009 +0900) 1 commit
>  - stash: --keep option just saves
> 
> Do we want to keep this one?

AFAIAC no.

I'd like a shorter way to say "git stash save --keep-index".  But that's 
OT.

Ciao,
Dscho
