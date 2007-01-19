From: Andreas Ericsson <ae@op5.se>
Subject: Re: git ls-files -o under .git/ prints all repository files
Date: Fri, 19 Jan 2007 14:30:14 +0100
Message-ID: <45B0C7E6.4020509@op5.se>
References: <87r6trsu7n.wl@mail2.atmark-techno.com>	 <7vwt3jjywc.fsf@assigned-by-dhcp.cox.net>	 <45B07875.9030506@fs.ei.tum.de> <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>,
	Junio C Hamano <junkio@cox.net>,
	Yasushi SHOJI <yashi@atmark-techno.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 19 14:30:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7toz-0004QB-QN
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 14:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbXASNaS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 08:30:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbXASNaS
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 08:30:18 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59222 "EHLO
	smtp-gw1.op5.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965129AbXASNaR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 08:30:17 -0500
Received: from [192.168.1.20] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 0DC286BCC1; Fri, 19 Jan 2007 14:30:15 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (X11/20070102)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701182357l3a6d44fel58da50c7895fb6b4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37182>

Alex Riesen wrote:
> On 1/19/07, Simon 'corecode' Schubert <corecode@fs.ei.tum.de> wrote:
>> >
>>
>> % cd .hg && hg status -A .
>> abort: path contains illegal component: .hg
>>
>> I think this is a sensible thing to do.
> 
> No, it isn't. It is not unlikely to have repo in repo
> (and some people already have them).
> Mercurial is wrong here.

For managing repos inside repos (onion repos?) I think it should
be safe to abort if we're not at top-level.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
