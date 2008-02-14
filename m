From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] RFC: git lazy clone proof-of-concept
Date: Thu, 14 Feb 2008 15:08:13 -0600
Message-ID: <47B4ADBD.9030409@nrlssc.navy.mil>
References: <200802081828.43849.kendy@suse.cz>	<m3ejbngtnn.fsf@localhost.localdomain>	<200802091627.25913.kendy@suse.cz>	<alpine.LFD.1.00.0802092200350.2732@xanadu.home>	<alpine.LSU.1.00.0802101640570.11591@racer.site>	<alpine.LSU.1.00.0802101845320.11591@racer.site>	<alpine.LSU.1.00.0802122036150.3870@racer.site>	<alpine.LSU.1.00.0802141917420.30505@racer.site> <m3y79nb8xk.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>, Jan Holesovsky <kendy@suse.cz>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 14 22:12:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPlNr-0003P1-9z
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 22:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760952AbYBNVMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 16:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763046AbYBNVMA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 16:12:00 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:53136 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758335AbYBNVL7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 16:11:59 -0500
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m1EL8Dw1003887;
	Thu, 14 Feb 2008 15:08:13 -0600
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 14 Feb 2008 15:08:13 -0600
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <m3y79nb8xk.fsf@localhost.localdomain>
X-OriginalArrivalTime: 14 Feb 2008 21:08:13.0387 (UTC) FILETIME=[B5D529B0:01C86F4D]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15722001
X-TM-AS-Result: : Yes--9.097900-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzA4OTMyLTcwMTQ1NS03MDc0MTAtNzA3Mzk1LTcwNDkyNy03?=
	=?us-ascii?B?MDE1MTMtNzAzNTg4LTcwMDI2NC03MDE1ODMtMTQ4MDM5LTE0ODA1?=
	=?us-ascii?B?MS0yMDA0MA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73916>

Jakub Narebski wrote:
> Brandon Casey wrote:

>> The smallest attained pack was about 1.45G (1556569742B).
> 
> Do you perchance know why OOo needs so large pack? Perhaps you could
> try running contrib/stats/packinfo.pl on this pack to examine it to
> get to know what takes most space.

Earlier in this thread Sean did some analysis and found lots of large
objects, and he mentioned that he sent a listing to Jan for inspection.
I haven't heard anything more.

> What is the size of checkout, by the way?

2.4G

-brandon
