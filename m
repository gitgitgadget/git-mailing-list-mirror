From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 20 Sep 2007 16:56:16 +0200
Message-ID: <46F28A10.8040803@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org> <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <a1bbc6950709061808q85cf75co75f2331dc2bdbcbe@mail.gmail.com> <alpine.LFD.0.999.0709070212300.5626@evo.linux-foundation.org> <a1bbc6950709062009x59a41cb7re6051739c11e370c@mail.gmail.com> <20070907061554.GB30161@thunk.org> <fctuo4$t93$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Burns <royalstream@hotmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 16:56:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYNS5-00045C-8u
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 16:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755963AbXITO4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 10:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbXITO4T
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 10:56:19 -0400
Received: from mail.op5.se ([193.201.96.20]:41788 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752344AbXITO4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 10:56:18 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6C81B194467;
	Thu, 20 Sep 2007 16:56:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hS9YIslnIqxK; Thu, 20 Sep 2007 16:56:16 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id CB9DB19446C;
	Thu, 20 Sep 2007 16:56:16 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <fctuo4$t93$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58783>

Steven Burns wrote:
>> a = b + "/share/" + c + serial_num;
>>
>> where you can have absolutely no idea how many memory allocations are
>> done, due to type coercions, overloaded operators
> 
> You are assuming (incorrectly) everybody will use dumb string classes like 
> that.
> 

Not really. He said "It's way to easy for idiots to do something like this:"
just prior to the line you quoted. I wholeheartedly agree, but in no way
does anyone assume that everybody will use dumb string classes.

I'm sure it's perfectly possible to write properly functioning programs in
C++. I know I use a few of them myself. That doesn't change the fact that
it's an idiot-friendly language to write code in that's extremely annoying
for competent programmers to fix up later.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
