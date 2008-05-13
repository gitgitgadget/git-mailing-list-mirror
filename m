From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 0/4] freebsd portability fixes
Date: Tue, 13 May 2008 22:39:31 +0200
Message-ID: <20080513203931.GA3981@steel.home>
References: <20080513084338.GA23729@sigill.intra.peff.net> <20080513090424.GA26181@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 13 22:41:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw1Io-0001pm-Ve
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 22:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759856AbYEMUjh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 16:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759284AbYEMUjg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 16:39:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:61584 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757985AbYEMUjf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 16:39:35 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnareO8OVwvA==
Received: from tigra.home (Fafac.f.strato-dslnet.de [195.4.175.172])
	by post.webmailer.de (klopstock mo62) (RZmta 16.34)
	with ESMTP id v0452fk4DGL7QX ; Tue, 13 May 2008 22:39:32 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8F19C277BD;
	Tue, 13 May 2008 22:39:32 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 0DAA556D28; Tue, 13 May 2008 22:39:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080513090424.GA26181@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82041>

Jeff King, Tue, May 13, 2008 11:04:24 +0200:
> On Tue, May 13, 2008 at 04:43:39AM -0400, Jeff King wrote:
> 
> > With these patches, I can successfully run all test scripts from the
> > current 'master' on FreeBSD 6.1 (some of them probably affect OS X, too
> > -- I recall somebody complaining about the '! foo | bar' construct
> > recently).
> 
> Ah, nevermind about OS X. It was 97ad535b from Alex, and he specifically
> mentioned FreeBSD 4.
> 
> Alex, you might want to try re-running the tests with these patches.
> 

Very good! GnuPG is missing on the system, so t7004 was skipped,
but everything besides that ran fine. My config.mak:

NO_STRTOUMAX=Yes
NO_C99_FORMAT=Yes
SHELL_PATH=/usr/local/bin/bash

perl 5.8.6

I also have the test-tr patches I sent some time ago in that tree.
