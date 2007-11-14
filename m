From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Fix Solaris Workshop Compiler issues
Date: Thu, 15 Nov 2007 00:28:09 +0100
Message-ID: <20071114232809.GH3973@steel.home>
References: <Pine.LNX.4.64.0711142125460.17530@bianca.dialin.t-online.de> <20071114204732.GE3973@steel.home> <7vprycfrk6.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu Nov 15 00:28:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsReo-0005kl-ST
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 00:28:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762316AbXKNX2P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 18:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761821AbXKNX2O
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 18:28:14 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:53289 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760470AbXKNX2N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 18:28:13 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (mrclete mo27) (RZmta 14.0)
	with ESMTP id k026c3jAEKhHSs ; Thu, 15 Nov 2007 00:28:09 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5D509277AE;
	Thu, 15 Nov 2007 00:28:09 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 40B4156D22; Thu, 15 Nov 2007 00:28:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711150011020.4135@bianca.dialin.t-online.de>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65025>

Guido Ostkamp, Thu, Nov 15, 2007 00:21:55 +0100:
> The main difference is that the 'struct delta_index' is opaque in delta.h 
> and non-opaque in diff-delta.c; the patch clearly shows it solves the 
> error. So we've got a solution.

It is not the solution. How do you think the rest of Git compiles?

> If you feel we could try something else, please let me know and I'll check 
> it out.

Yes. Read the mail I sent before:

    Try removing the "const". Looks like that compiler is too stupid
    to understand it.
