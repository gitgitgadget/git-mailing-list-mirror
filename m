From: Miles Bader <miles.bader@necel.com>
Subject: Re: git diff woes
Date: Tue, 13 Nov 2007 11:53:44 +0900
Message-ID: <buomytin9dz.fsf@dhapc248.dev.necel.com>
References: <4738208D.1080003@op5.se>
	<Pine.LNX.4.64.0711120958500.4362@racer.site> <47382C84.50408@op5.se>
	<7vhcjr2lte.fsf@gitster.siamese.dyndns.org> <4738E9E6.2040001@op5.se>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Nov 13 03:54:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Irlv1-0003dQ-4s
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 03:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbXKMCyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 21:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753774AbXKMCyJ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 21:54:09 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:54513 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604AbXKMCyI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 21:54:08 -0500
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id lAD2riBl019376;
	Tue, 13 Nov 2007 11:53:45 +0900 (JST)
Received: from relay11.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Tue, 13 Nov 2007 11:53:45 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay11.aps.necel.com with ESMTP; Tue, 13 Nov 2007 11:53:45 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 4B1F6448; Tue, 13 Nov 2007 11:53:44 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <4738E9E6.2040001@op5.se> (Andreas Ericsson's message of "Tue\, 13 Nov 2007 01\:03\:50 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64743>

Andreas Ericsson <ae@op5.se> writes:
> I notice it, and I don't like it. I guess I'm just used to git being
> smarter than their GNU tool equivalents, especially since it only ever
> applies patches in full.

It's not at all obvious that this behavior is actually wrong -- it seems
perfectly reasonable to use either old or new text for the hunk headers.

It hardly matters really, since that particular output is just "useful
noise" to provide a bit of helpful context for human readers, and humans
(unlike programs) are notoriously good at not being bothered by such
things.  Er, well most humans anyway.

-Miles

-- 
Americans are broad-minded people.  They'll accept the fact that a person can
be an alcoholic, a dope fiend, a wife beater, and even a newspaperman, but if a
man doesn't drive, there is something wrong with him.  -- Art Buchwald
