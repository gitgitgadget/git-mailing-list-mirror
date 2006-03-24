From: Andreas Ericsson <ae@op5.se>
Subject: Re: Errors GITtifying GCC and Binutils
Date: Fri, 24 Mar 2006 12:29:12 +0100
Message-ID: <4423D808.7070800@op5.se>
References: <20060322133337.GU20746@lug-owl.de> <Pine.LNX.4.64.0603221517210.26286@g5.osdl.org> <Pine.LNX.4.64.0603221607580.26286@g5.osdl.org> <44223B90.3040500@zytor.com> <1143128751.6850.35.camel@neko.keithp.com> <Pine.LNX.4.64.0603230758260.26286@g5.osdl.org> <BAYC1-PASMTP0912D2287AB923F3338969AEDE0@CEZ.ICE> <Pine.LNX.4.64.0603231134160.26286@g5.osdl.org> <20060323204825.GE30176@spearce.org> <slrne27kv8.cp6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Mar 24 12:29:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMkTq-0001aH-Lg
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 12:29:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932492AbWCXL3P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 06:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWCXL3P
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 06:29:15 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:50909 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1422683AbWCXL3N
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 06:29:13 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 7B3206BCFE
	for <git@vger.kernel.org>; Fri, 24 Mar 2006 12:29:12 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <slrne27kv8.cp6.mdw@metalzone.distorted.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17913>

Mark Wooding wrote:
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> 
>>But your definately right; once the blame/annotate war settles out
>>GIT will have pretty much everything one might need - except a good
>>distributed bug/issue tracking type system.  :-)
> 
> 
> There ought to be such a thing.  And I hope it gets called `bugger'.
> 

I'm working (slowly) on integrating it with Mantis (www.mantisbt.org), 
which we use at work. It shouldn't be difficult to reuse that code with 
Bugzilla and other similar trackers.

The recognition thing is done in the update-script, looking for a hash 
followed by a number (the bug-id) and then sending that commit to 
another program, so it's simply a matter of including the bug-id, 
prefixed with a hash, and the bug-topic somewhere in the commit message, 
which is a fairly good practice anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
