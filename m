From: Andreas Ericsson <ae@op5.se>
Subject: Re: Make "git clone" less of a deathly quiet experience
Date: Sun, 12 Feb 2006 12:02:41 +0100
Message-ID: <43EF15D1.1050609@op5.se>
References: <Pine.LNX.4.64.0602102018250.3691@g5.osdl.org>	 <7vwtg2o37c.fsf@assigned-by-dhcp.cox.net>	 <Pine.LNX.4.64.0602110943170.3691@g5.osdl.org>	 <1139685031.4183.31.camel@evo.keithp.com>  <43EEAEF3.7040202@op5.se> <1139717510.4183.34.camel@evo.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Feb 12 12:02:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8F0C-0006jw-MX
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 12:02:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWBLLCn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 06:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbWBLLCn
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 06:02:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:20678 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750836AbWBLLCn
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 06:02:43 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 1BF416BD01; Sun, 12 Feb 2006 12:02:42 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Keith Packard <keithp@keithp.com>
In-Reply-To: <1139717510.4183.34.camel@evo.keithp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15990>

Keith Packard wrote:
> On Sun, 2006-02-12 at 04:43 +0100, Andreas Ericsson wrote:
> 
> 
>>A weird oddity; Cloning is faster over rsync, day-to-day pulling is not.
> 
> 
> Precisely. If the protocol could deliver existing packs instead of
> unpacking and repacking them, then git would be as fast as rsync and I
> wouldn't have to worry about supporting two protocols.
> 

Caching features have been discussed, but that means the daemon needs to 
have write-access to some directory within the repository. It would also 
work poorly for projects that see very rapid development unless the 
cached pack-files can be amended to. A sort of "create packs on demand". 
It shouldn't be too difficult, really.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
