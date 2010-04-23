From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/2] wt-status: take advice.statusHints seriously
Date: Fri, 23 Apr 2010 11:31:55 -0700 (PDT)
Message-ID: <m3aasudnzy.fsf@localhost.localdomain>
References: <c7003ec93f4ea01be80fbba08d2ed5544fa0df4d.1271968072.git.git@drmicha.warpmail.net>
	<7v39yo53mt.fsf@alter.siamese.dyndns.org>
	<86a4d8e5df80008c5c2b3ff4f2a5842ad1f58dc4.1271968072.git.git@drmicha.warpmail.net>
	<q2ibe6fef0d1004222115gcdd8fd81xce8993508bfa9f5d@mail.gmail.com>
	<4BD155D0.5080402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 23 20:32:09 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Nfc-0006VL-Lu
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 20:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753589Ab0DWScD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 14:32:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:64164 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753476Ab0DWSb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 14:31:58 -0400
Received: by fg-out-1718.google.com with SMTP id 19so327727fgg.1
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=gLC3Pup1n6HaUGuZmym7P6veAoVNCrIBsF8kIMiEgdM=;
        b=PiCK5j/SiXiKq5LNSjCkdul9BqIqytC3gsHkeW/L73TsQs4Ay6fQswi15M3qB7iM1h
         +9DqLwW3Y4UhR+oH5x8etsFDgipsO4TCRld1yLxhoH8Hh2/Zye6wFCdQfUEcneR0YXj8
         9a2/lZ20Qvm3k2meTL/b5qyNhk5AV18Oxfws8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=iun8e4GXYoFvCyHWHMJPi3hkKsFJS4hXCpBDh9mUGr0XgP2BvXqk0oHFiY+R1ilOF9
         FPLWX34tTm5pG+3ILMM2H4awsVcGaJhgFQvWZDJHZdvfVzGEBMXQnW+xBV79AY7UKc2/
         ggHZLXH4OJBQaPRc92tm44I/lLGTcIAUjLh40=
Received: by 10.86.6.37 with SMTP id 37mr1009464fgf.7.1272047516562;
        Fri, 23 Apr 2010 11:31:56 -0700 (PDT)
Received: from localhost.localdomain (abwm94.neoplus.adsl.tpnet.pl [83.8.236.94])
        by mx.google.com with ESMTPS id 4sm2188848fge.13.2010.04.23.11.31.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 23 Apr 2010 11:31:55 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3NITgow009918;
	Fri, 23 Apr 2010 20:29:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3NIQAMG009871;
	Fri, 23 Apr 2010 20:26:10 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4BD155D0.5080402@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145633>

Michael J Gruber <git@drmicha.warpmail.net> writes:
> Tay Ray Chuan venit, vidit, dixit 23.04.2010 06:15:
>> 
>> On Fri, Apr 23, 2010 at 4:30 AM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>>                else if (s->untracked.nr)
>>> -                       printf("nothing added to commit but untracked files present (use \"git add\" to track)\n");
>>> +                       printf("nothing added to commit but untracked files present%s\n",
>>> +                               advice_status_hints
>>> +                               ? " (use \"git add\" to track)" : "");
>> 
>> while we're at it, perhaps we could put the hints on its own line,
> 
> I don't think I'm the only one to turn sour at every encounter with the
> phrase "while we're at it". I did fix one extraneous space in code
> "while I was at it", yes, but:

I agre that it might be a good idea, but it is not something to do
"while we're at it".
 
Tay Ray Chuan probably meant that he "while at it" (while reviewing
this patch) had this idea...

>> with a "hint: " prefix:
>> 
>>   nothing added to commit but untracked files present
>>   hint: use "git add" to track
>> 
>> This way, we give future git usability hackers the space to elaborate
>> further on why a certain flag or command was recommended.
>> 
> 
> I'm suggesting a change in (output) behaviour (hint vs. no hint), which
> one may even consider to be a bug fix in terms of matching the obvious
> expections related to advice.statusHints false.
> 
> You're suggesting a different presentation of the output. In fact, I
> noticed inconsistent capitalisation in the hints which should be
> adjusted, maybe together with the presentation.
> 
> But I deem both changes (overlapping though) unrelated.

Perhaps git should introduce helper commands, similar to 'die', 'warn'
and 'error', but for hints and advices, e.g. hint(bool, "<string>")
which would print advice on its own line (like 'die' and 'warn') with
appropriate prefix if advices, and e.g. 'advice', which would return
either empty string or string with advice (a bit like 'error').

-- 
Jakub Narebski
Poland
ShadeHawk on #git
