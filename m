From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Thu, 27 Nov 2008 23:49:40 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 27 23:42:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5pZO-0007wE-9Z
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 23:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbYK0Wl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 17:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751585AbYK0Wl3
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 17:41:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:38607 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449AbYK0Wl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 17:41:28 -0500
Received: (qmail invoked by alias); 27 Nov 2008 22:41:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 27 Nov 2008 23:41:26 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18de4IHbWkdpypneo+oW7RtCwbT6uBKaP6ijhTBf2
	gQ4OMiF1LZBvlK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101843>

Hi,

On Wed, 26 Nov 2008, Junio C Hamano wrote:

> ----------------------------------------------------------------
> [Will merge to "master" soon]
>
> [...]
> 
> * nd/narrow (Tue Nov 18 06:33:16 2008 -0500) 10 commits
>  + t2104: touch portability fix
>  + grep: skip files outside sparse checkout area
>  + checkout_entry(): CE_NO_CHECKOUT on checked out entries.
>  + Prevent diff machinery from examining worktree outside sparse
>    checkout
>  + ls-files: Add tests for --sparse and friends
>  + update-index: add --checkout/--no-checkout to update
>    CE_NO_CHECKOUT bit
>  + update-index: refactor mark_valid() in preparation for new options
>  + ls-files: add options to support sparse checkout
>  + Introduce CE_NO_CHECKOUT bit
>  + Extend index to save more flags

I have a strong suspicion that the narrow stuff will make the worktree 
mess pale in comparison.

Note that I do not have time to review this myself (which is not helped at 
all by it being no longer a trivial single patch, but a full 10 patches!), 
but I really have a bad feeling about this.  IMO it is substantially 
under-reviewed.

Ciao,
Dscho
