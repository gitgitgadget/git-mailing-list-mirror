From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC PATCH 2/2] MSVC: Fix an "incompatible pointer types" compiler
 warning
Date: Fri, 04 Dec 2009 22:58:13 +0000
Message-ID: <4B199405.8040607@ramsay1.demon.co.uk>
References: <4B1806FB.2050401@ramsay1.demon.co.uk> <alpine.DEB.1.00.0912041144470.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 05 00:16:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGhNk-0004S8-EE
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 00:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbZLDXPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 18:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbZLDXPt
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 18:15:49 -0500
Received: from lon1-post-1.mail.demon.net ([195.173.77.148]:45950 "EHLO
	lon1-post-1.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932483AbZLDXPs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2009 18:15:48 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-1.mail.demon.net with esmtp (Exim 4.69)
	id 1NGhNS-00078x-Y4; Fri, 04 Dec 2009 23:15:55 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <alpine.DEB.1.00.0912041144470.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134586>

Johannes Schindelin wrote:
> On Thu, 3 Dec 2009, Ramsay Jones wrote:
> 
>>  compat/mingw.h |   27 ++++++++++++++++++++++++++-
>>  compat/msvc.h  |   25 +------------------------
>>  2 files changed, 27 insertions(+), 25 deletions(-)
> 
> I'd prefer to have the MSVC-specific definitions in msvc.h, along with a 
> definition of, say, ALREADY_DEFINED_STATI64 or some such (which tells 
> mingw.h not to do anything about those types).  There is no need to 
> clutter mingw.h with stuff for MSVC.

Ah, yeah, I did think about this. As I said, the original patch was much
simpler and I thought the change to mingw.h was just this side of being
objectionable ;-) However, as the patch continued to gain weight I should
have re-evaluated that... my bad.

New version of the patch coming soon.

ATB,
Ramsay Jones
