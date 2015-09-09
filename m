From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Git's inconsistent command line options
Date: Wed, 9 Sep 2015 11:42:41 +0200
Message-ID: <55EFFF11.8000500@drmicha.warpmail.net>
References: <mrh7ck$r0g$1@ger.gmane.org>
 <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
 <CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
 <20150831102558.1514e5f7@anarchist.wooz.org>
 <20150901092834.GA10706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: David Aguilar <davvid@gmail.com>, Barry Warsaw <barry@python.org>
X-From: git-owner@vger.kernel.org Wed Sep 09 11:42:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZbtx-0000eS-J7
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 11:42:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbbIIJmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 05:42:46 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34331 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751886AbbIIJmo (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 05:42:44 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 0899620C28
	for <git@vger.kernel.org>; Wed,  9 Sep 2015 05:42:44 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute1.internal (MEProxy); Wed, 09 Sep 2015 05:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=fJYH0+q9ArXc18l3+OCnGuEzOuM=; b=cJD+K7
	KRqi+LJatlGTqziyjakTFz2Jh6xoeOaPzRo5PsoVWu5dXvu2osZyUvGF6v4+LXap
	ShwvEEftHigzyeTGoC8vs4Uo3EJTqer2VIZzLuoglGdWwAPg1A/h44uNCVj56q4W
	ZKkDZkZ6QHhsrSw4lEToaCGu7NOkWkqESZrn4=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=fJYH0+q9ArXc18l
	3+OCnGuEzOuM=; b=cZ1+w3P30u+QN3gNlmMnoEQWTJArpl4AoHTlVDO9drSOsvz
	ZwMD+XRrSlMEzhgWN3gklnavTj1kmKlAW4q5RMt1hHyO1jPNnMDngURYrPvlpu4S
	CoWyHHRztfqlqsu1Hznfcd6EIsbCS0wKT2F0bVCoeSikZEIbiV+XQc8YlGjU=
X-Sasl-enc: KforORhD1uDY4CW7si5Cxe4fQKLiSr5lMGMMTUno44KF 1441791763
Received: from localhost.localdomain (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C70B9680119;
	Wed,  9 Sep 2015 05:42:42 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
In-Reply-To: <20150901092834.GA10706@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277544>

David Aguilar venit, vidit, dixit 01.09.2015 11:28:
> On Mon, Aug 31, 2015 at 10:25:58AM -0400, Barry Warsaw wrote:
>> On Aug 31, 2015, at 05:10 PM, Duy Nguyen wrote:
>>
>>> I'm probably shot down for this. But could we go with a clean plate
>>> and create a new command prefix (something like git-next, git2, or
>>> gt...)? We could then redesign the entire UI without worrying about
>>> backward compatibility. At some point we can start to deprecate "git"
>>> and encourage to use the new command prefix only. Of course somebody
>>> has to go over all the commands and options to propose some consistent
>>> UI, then more discussions and coding so it could likely follow the
>>> path of pack v4..
>>
>> `git` itself could also be a thin wrapper which consulted a configuration
>> variable to see which version of the ui to expose.
>>
>> "All problems in computer science can be solved by another level of
>> indirection"
> 
> Except for poor performance, simplicity, and bad ideas.
> 
> The Git project does not break backwards compatibility.
> Let's let Python3 serve as a good lesson on why not to do that! ;-p
> 
> While a script writer could write, "git -c core.cliversion=1 ...",
> no one does that, no one wants to do that, and it just seems
> like a bad idea that's best left unexplored.
> 
> The only idea in this thread that's user-friendly would be a new
> Git that still supported the entirety of the existing,
> perfectly-good CLI interface and *also* accepted some new
> "consistent" user interface.

Give it a break. If Git had a perfectly-good CLI interface we didn't
have any complaints. But we have many well-founded complaints about
inconsistencies, such as short-options (-n), subsubcommands etc.

> Otherwise, this entire thread seems like a big non-issue.
> The existing CLI hasn't hurt adoption, and tossing a config
> option at it only makes it worse.  The best config is no config.

I certainly agree with you on that. Unfortunately, we've seen quite an
increase of config options whose sole purpose is changing default
options for some commands.

> There really are ony a few corner cases that would need to be
> tweaked to support --named-subcommands style, and after that is
> done, is Git really that much easier to use?
> 
> Maybe a little bit, but not enough that warrants breaking
> existing scripts IMO.
> ---
> David

Well, it may actually hurt to reach some substantial improvements. It
may actually be worth it if it ends constant suffering from how it is
now. Those are the points that we have to weigh carefully. Simply
resisting change won't take us anywhere.

Michael
