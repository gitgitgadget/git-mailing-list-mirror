From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 23:18:38 +0200
Message-ID: <20070905211838.GB3770@steel.home>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <20070905074206.GA31750@artemis.corp> <87odgh0zn6.fsf@hades.wkstn.nix> <46DEF1FA.4050500@midwinter.com> <877in50y7p.fsf@hades.wkstn.nix> <alpine.LFD.0.9999.0709051438460.21186@xanadu.home> <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Nix <nix@esperi.org.uk>,
	Steven Grimm <koreth@midwinter.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 23:18:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT2Gr-0003WW-VJ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 23:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbXIEVSl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 17:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753772AbXIEVSl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 17:18:41 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:35092 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752966AbXIEVSk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 17:18:40 -0400
Received: from tigra.home (Facc5.f.strato-dslnet.de [195.4.172.197])
	by post.webmailer.de (mrclete mo48) (RZmta 12.6)
	with ESMTP id R044a9j85J6Zyw ; Wed, 5 Sep 2007 23:18:38 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 478E1277BD;
	Wed,  5 Sep 2007 23:18:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 2E513BEAC; Wed,  5 Sep 2007 23:18:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr6lcj2zi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFz4AZk=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57765>

Junio C Hamano, Wed, Sep 05, 2007 22:01:37 +0200:
> +	/*
> +	 * Quickly check if a "gc" is needed, by estimating how
> +	 * many loose objects there are.  Because SHA-1 is evenly
> +	 * distributed, we can check only one and get a reasonable
> +	 * estimate.
> +	 */

:))

> +	if (sizeof(path) <= snprintf(path, sizeof(path), "%s/17", objdir)) {
> +		warning("insanely long object directory %.*s", 50, objdir);

or a non-POSIX snprintf returning "negative value" (Microsoft)
