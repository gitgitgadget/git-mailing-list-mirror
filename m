From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [PATCH] cvsimport: introduce -L<imit> option to workaround memory
 leaks
Date: Tue, 23 May 2006 15:15:43 +1200
Message-ID: <44727E5F.5070309@catalyst.net.nz>
References: <11482978883713-git-send-email-martin@catalyst.net.nz> <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, Johannes.Schindelin@gmx.de,
	spyderous@gentoo.org, smurf@smurf.noris.de
X-From: git-owner@vger.kernel.org Tue May 23 05:15:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiNMv-0004H3-5h
	for gcvg-git@gmane.org; Tue, 23 May 2006 05:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWEWDPc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 23:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWEWDPc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 23:15:32 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:15749 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751266AbWEWDPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 23:15:31 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FiNMm-0002jB-A2; Tue, 23 May 2006 15:15:28 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605221926270.3697@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20562>

Linus Torvalds wrote:

> 
> This stupid patch on top of yours seems to make git happier. It's 
> disgusting, I know, but it just repacks things every kilo-commit.
> 
> I actually think that I found a real ext3 performance bug from trying to 
> determine why git sometimes slows down ridiculously when the tree has been 
> allowed to go too long without a repack.
> 

Acked (in case anyone cares for such an obvious one), and thanks! I 
thought of doing that last night together with that exact patch, but I 
was focussing on the leak.

cheers,


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
