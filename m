From: Timur Tabi <timur@freescale.com>
Subject: Re: git-apply versus git-am
Date: Mon, 23 Jul 2007 12:20:40 -0500
Organization: Freescale
Message-ID: <46A4E368.7080909@freescale.com>
References: <a2e879e50707230054m60d45293ua1d57887367914c1@mail.gmail.com> <7vsl7flctg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean Kelley <svk.sweng@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 19:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID1by-0006v4-0H
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 19:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756994AbXGWRWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 13:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757500AbXGWRWS
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 13:22:18 -0400
Received: from de01egw02.freescale.net ([192.88.165.103]:45461 "EHLO
	de01egw02.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756503AbXGWRWR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 13:22:17 -0400
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id l6NHKfUT016825;
	Mon, 23 Jul 2007 10:20:42 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6NHKfcB021212;
	Mon, 23 Jul 2007 12:20:41 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8.1.2pre) Gecko/20070111 SeaMonkey/1.1
In-Reply-To: <7vsl7flctg.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53448>

Junio C Hamano wrote:

> applymbox is going away.

That sucks!  I like git-am.  Is there a replacement command that applies a patch and 
commits it at the same time?  If I use git-apply on a patch that adds new files, I need to 
use git-add on the files before I can commit it.  That's a real pain.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
