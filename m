From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 11:17:48 +0100
Message-ID: <491EA1CC.9020605@op5.se>
References: <491DE6CC.6060201@op5.se> <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 11:20:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1IGm-0004hv-Fp
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 11:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbYKOKR4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 05:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbYKOKR4
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 05:17:56 -0500
Received: from mail.op5.se ([193.201.96.20]:53783 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbYKOKRz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 05:17:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 42B07520006;
	Sat, 15 Nov 2008 11:12:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t1EyohS+nGjR; Sat, 15 Nov 2008 11:12:25 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 7F729520005;
	Sat, 15 Nov 2008 11:12:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101056>

Linus Torvalds wrote:
> 
> On Fri, 14 Nov 2008, Andreas Ericsson wrote:
>> The license decided for libgit2 is "GPL with gcc exception".
> 
> What's the exact language? 
> 
> I'm likely ok with GPLv2 + libgcc-like exception, but I'd like to see the 
> exact one. I haven't followed the discussions much..
> 

Shawn posted the exact text. The spirit of that license is that anyone can
use an unmodified version of the library for whatever they want, but it's
illegal to link non-GPL software to an altered version of the library. That
is, the git community will get all changes back while other projects can
use the official version of the library without having to worry about
licensing issues. EvilCompany cannot make changes to the library and then
link non-GPL'd software to their changed version. They can do that if they
send their library changes upstream and then only use them once they're
considered "official" though.

As the original author, you sort of have veto here since everything core-ish
is derived from what you wrote. Iow, if you say nay, libgit2 with a non-GPL
license will only fly if index, tree, commit, ref, etc... manipulation is
rewritten from scratch. That will be hard, given that it can fairly easily
be claimed that the people most likely to do it are so heavily influenced by
the current code that it's impossible for them not to make a derivative work.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
