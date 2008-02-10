From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Sun, 10 Feb 2008 00:35:17 -0500
Message-ID: <BAYC1-PASMTP059B375F7660D93F93647DAE290@CEZ.ICE>
References: <200802081828.43849.kendy@suse.cz>
	<m3ejbngtnn.fsf@localhost.localdomain>
	<200802091627.25913.kendy@suse.cz>
	<alpine.LFD.1.00.0802092200350.2732@xanadu.home>
	<BAYC1-PASMTP10AF630E8A5B3D6C255317AE290@CEZ.ICE>
	<alpine.LFD.1.00.0802100017380.2732@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jan Holesovsky <kendy@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sun Feb 10 06:35:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO4r5-0004bA-Sd
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 06:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751455AbYBJFfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 00:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbYBJFfV
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 00:35:21 -0500
Received: from bay0-omc2-s12.bay0.hotmail.com ([65.54.246.148]:31972 "EHLO
	bay0-omc2-s12.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751365AbYBJFfT (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 00:35:19 -0500
Received: from BAYC1-PASMTP05 ([65.54.191.165]) by bay0-omc2-s12.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 9 Feb 2008 21:35:19 -0800
X-Originating-IP: [74.14.66.77]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.14.66.77]) by BAYC1-PASMTP05.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Sat, 9 Feb 2008 21:35:18 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JO5mO-0002Ca-4l; Sun, 10 Feb 2008 01:35:08 -0500
In-Reply-To: <alpine.LFD.1.00.0802100017380.2732@xanadu.home>
X-Mailer: Sylpheed 2.4.8 (GTK+ 2.12.7; i686-pc-linux-gnu)
X-OriginalArrivalTime: 10 Feb 2008 05:35:18.0923 (UTC) FILETIME=[B8CCC5B0:01C86BA6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73316>

On Sun, 10 Feb 2008 00:22:09 -0500 (EST)
Nicolas Pitre <nico@cam.org> wrote:

> Well, I don't think so.  Anyway, with the above pack.windowMemory 
> setting, the window probably gets shrinked if those big objects are all 
> to be found in the same window.  So that would be the setting to 
> increase if you have lots of ram.

Sounds like it would be worthwhile then for Jan to try on that 8G machine
and see what comes out the other end.

> Finding out what those huge objects are, and if they actually need to be 
> there, would be a good thing to do to reduce any repository size.

Okay, i've sent the sha1's of the top 500 to Jan for inspection.  It appears
that many of the largest objects are automatically generated i18n files that
could be regenerated from source files when needed rather than being checked
in themselves; but that's for the OO folks to decide.

Thanks,
Sean
