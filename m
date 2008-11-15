From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 12:52:50 +0100
Message-ID: <491EB812.7040808@op5.se>
References: <491DE6CC.6060201@op5.se>	 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>	 <491EA1CC.9020605@op5.se>	 <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>	 <491EACFA.9040604@op5.se> <3af572ac0811150333p28546975m9cf3ad73e62eb97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 12:54:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1JjO-0002tl-C8
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 12:54:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754495AbYKOLxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 06:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754592AbYKOLxG
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 06:53:06 -0500
Received: from mail.op5.se ([193.201.96.20]:35682 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754359AbYKOLxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 06:53:05 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 448A6520005;
	Sat, 15 Nov 2008 12:47:37 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUyMriAYdXDT; Sat, 15 Nov 2008 12:47:31 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 683E01B80062;
	Sat, 15 Nov 2008 12:47:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <3af572ac0811150333p28546975m9cf3ad73e62eb97@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101060>

Pau Garcia i Quiles wrote:
> On Sat, Nov 15, 2008 at 12:05 PM, Andreas Ericsson <ae@op5.se> wrote:
> 
>>> Do you mean if I write a patch to libgit2, send it upstream and make
>>> it public on my website but it is not accepted upstream, I cannot link
>>> my modified libgit2 version (i. e. libgit2 + my patch) to my non-GPL
>>> software?
>> I think that's the case, yes.
>>
>>> It looks insane to me: I wrote the patch and made it public
>>> but you guys did not accept it!
>>>
>> Well, if you wrote a patch that uses a closed-source database library
>> to store git objects in, how would that benefit the community even if
>> you published the patch?
> 
> The case I had in mind is not that but this: say I write a patch which
> is totally open-source and uses only open-source software to add some
> feature to libgit2 but I want to link that libgit2 + mypatch to a
> closed source application (say, for instance, software for military
> use, which I'm not allowed to open source). To state it clearly:
> - My contribution is 100% open source
> - My contribution is 100% towards libgit2
> - In fact, I could add that very feature to my application instead of
> libgit2 but as I'm open-source-friendly, I decide to contribute that
> patch to libgit2.
> 
> For some reason, that patch:
> - Is not accepted for some time (for instance, I'm thinking in that
> tcl/tk limitation which is preventing Junio from merging a patch, it's
> been in the "what's cooking" for some weeks now)
> - Or is not accepted at all
> 
> According to what you said, I only have two options:
> - Either I fork libgit2, or
> - I keep my feature in my application and do not contribute my feature
> to libgit2
> 
> It looks even more insane now!
> 

No, it's still sane. You can keep the code in your application until
that patch is applied upstream. Besides, given the nature of shared
libraries you'd probably have to fall back to the version in your
app for quite some time anyways.

> What about rephrasing the libgcc exception to something like: "if you
> have a patch, and sent us that patch, but we put the patch in stand-by
> or declided the patch, you are still allowed to combine libgit2 with
> your closed-source application". After all, the fault is not in the
> closed-source part (I contributed the patch, it is 100% open-source
> and only uses 100% open-source) but in the libgit2 part (patch is on
> hold or not accepted at all).
> 

Rephrasing an existing license is really, really stupid, as it means
companies that want to build stuff on top of it will have to do the
legal procedure all over again.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
