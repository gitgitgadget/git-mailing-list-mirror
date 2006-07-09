From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: [BUGFIX][RESEND]git-cvsexportcommit can't handle merge commits
 correctly
Date: Mon, 10 Jul 2006 11:12:36 +1200
Message-ID: <44B18D64.9090409@catalyst.net.nz>
References: <20060707105541.GA17004@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jul 10 01:13:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FziSF-0002z8-D6
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 01:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWGIXMg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 19:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbWGIXMf
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 19:12:35 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:46041 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S932521AbWGIXMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jul 2006 19:12:33 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1FziRv-0004zv-Bl; Mon, 10 Jul 2006 11:12:27 +1200
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>
In-Reply-To: <20060707105541.GA17004@xp.machine.xx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23576>

Peter Baumann wrote:
> git-cvsexportcommit should check if the parent (supplied on the cmdline) to use
> for a merge commit is one of the real parents of the merge.
> 
> But it errors out if the _first_ parent doesn't match and never checks
> the other parents.
> 

Ack. Thanks for spotting this!


m
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
