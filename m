From: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>
Subject: Re: perhaps time to remove git_blame from gitweb, and git-annotate?
Date: Sat, 07 Oct 2006 18:37:26 +1300
Message-ID: <45273D16.7050205@catalyst.net.nz>
References: <20061006175234.41182.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>, Jakub Narebski <jnareb@gmail.com>,
	Ryan Anderson <ryan@michonline.com>,
	Martyn Smith <martyn@catalyst.net.nz>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sat Oct 07 07:38:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW4sc-0001Nc-Gh
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 07:37:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751761AbWJGFhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 01:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751762AbWJGFhn
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 01:37:43 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:53191 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751761AbWJGFhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 01:37:42 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=[192.168.2.69])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1GW4sI-0001Vf-FW; Sat, 07 Oct 2006 18:37:26 +1300
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
To: ltuikov@yahoo.com
In-Reply-To: <20061006175234.41182.qmail@web31810.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28455>

Luben Tuikov wrote:
>>>Do people have reason to favor annotate over blame?  To keep
>>>existing people's scripts working I think we should add a small
>>>amount of code to blame.c to default to compatibility mode when
>>>the command is called as git-annotate at least for a while, but
>>>other than that I do not see much issue against scheduling for
>>>annotate's removal.
>>
>>+1. Although I would leave git-annotate in git, if only to meet 
>>expectations of new git users.
> 
> 
> I agree with Junio's assessment of the situation.

+1 -- I need to test that the switch to git-blame for git-cvsserver 
works well for Eclipse end users. Will try and fit that next week 
somehow ;-)


martin
-- 
-----------------------------------------------------------------------
Martin @ Catalyst .Net .NZ  Ltd, PO Box 11-053, Manners St,  Wellington
WEB: http://catalyst.net.nz/           PHYS: Level 2, 150-154 Willis St
OFFICE: +64(4)916-7224                              MOB: +64(21)364-017
       Make things as simple as possible, but no simpler - Einstein
-----------------------------------------------------------------------
