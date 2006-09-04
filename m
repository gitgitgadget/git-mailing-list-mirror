From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] git-repack: create new packs inside $PACKDIR, not cwd
Date: Mon, 04 Sep 2006 22:46:55 +1200
Message-ID: <44FC041F.6010002@catalyst.net.nz>
References: <11573485523752-git-send-email-martin@catalyst.net.nz>	<20060904090833.GF17042@admingilde.org>	<7vveo4nfbg.fsf@assigned-by-dhcp.cox.net>	<7vr6ysneor.fsf@assigned-by-dhcp.cox.net>	<44FBF9E0.9050800@catalyst.net.nz> <7vlkp0ndmj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 12:47:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKByr-0005uq-Pv
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 12:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385AbWIDKq5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 06:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWIDKq5
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 06:46:57 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:52145 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751377AbWIDKq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 06:46:56 -0400
Received: from 121-73-4-156.cable.telstraclear.net ([121.73.4.156] helo=[192.168.0.5])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GKByf-0006Cr-HB; Mon, 04 Sep 2006 22:46:53 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkp0ndmj.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26414>

Junio C Hamano wrote:

> "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz> writes:
> 
> 
>>BTW, I think there's a small error.
>>
>>Your packtmp includes $$ which means that rm -f "$PACKTMP" will only
>>clear out old packs..
> 
> 
> That was deliberate.  I hate programs that clean things up
> behind user's back.  The first "rm" is to get rid of what would
> collide with what we are going to do (i.e. protecting ourselves)
> and "trap rm" is to make sure we do not leave the cruft we know
> we are going to create.  I'd rather leave other people's cruft
> around, unless the purpose of the command is to clean things up,
> and repack is hardly that.
> 

Ah, ok. I misunderstood the use of trap -- of course, re-reading the man 
pages, it makes sense.

A-ok with me, then, and sorry about the noise.



martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------

-- 
VGER BF report: H 0.0618878
