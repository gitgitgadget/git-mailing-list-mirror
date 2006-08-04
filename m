From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [RFC] Introduce git-xxdiff to invoke xxdiff for manual conflict
 resolution
Date: Fri, 04 Aug 2006 15:48:35 +1200
Message-ID: <44D2C393.8090508@catalyst.net.nz>
References: <11546492331601-git-send-email-martin@catalyst.net.nz> <7v64h9pdx4.fsf@assigned-by-dhcp.cox.net> <44D296D8.4030200@catalyst.net.nz> <20060804033144.GB24818@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 04 05:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8qg0-0008IX-NB
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 05:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbWHDDsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 23:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751078AbWHDDsl
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 23:48:41 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:44715 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751059AbWHDDsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 23:48:41 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1G8qfr-00043B-3j; Fri, 04 Aug 2006 15:48:35 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Jeff King <peff@peff.net>
In-Reply-To: <20060804033144.GB24818@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24768>

Jeff King wrote:

> On Fri, Aug 04, 2006 at 12:37:44PM +1200, Martin Langhoff (CatalystIT) wrote:
> 
> 
>>>instead check for stage 2 ("ours") for the path.
>>
>>Reading Documentation/git-read-tree.txt it seems to mean that stage 1 is 
>>merge base, 1 is ours and 2 is the branch being merged in.
>>
>>I am confused...
>>
>>Quote:
>>
>>>When performing a merge of another
>>>branch into the current branch, we use the common ancestor tree
>>>as <tree1>, the current branch head as <tree2>, and the other
>>>branch head as <tree3>.
> 
> 
> Look further down:
>    OK, this all sounds like a collection of totally nonsensical rules,
>    but it's actually exactly what you want in order to do a  fast
>    merge.  The different stages  represent the "result tree" (stage 0,
>    aka "merged"), the original tree (stage 1, aka "orig"), and the two
>    trees you are trying to merge (stage 2 and 3 respectively).

Grr. I just re-read my own email, and I can't believe how stupid my 
question was. Still, git-xxdiff is doing the right thing, stage 2 is 
"ours" and stage 3 is "branch we are merging in".

cheers,


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
