From: Andreas Ericsson <ae@op5.se>
Subject: Re: git to libgit2 code relicensing
Date: Sat, 15 Nov 2008 12:05:30 +0100
Message-ID: <491EACFA.9040604@op5.se>
References: <491DE6CC.6060201@op5.se>	 <alpine.LFD.2.00.0811141512480.3468@nehalem.linux-foundation.org>	 <491EA1CC.9020605@op5.se> <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Sat Nov 15 12:08:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1J0t-0008Bl-5T
	for gcvg-git-2@gmane.org; Sat, 15 Nov 2008 12:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYKOLFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Nov 2008 06:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754110AbYKOLFo
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Nov 2008 06:05:44 -0500
Received: from mail.op5.se ([193.201.96.20]:33745 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754054AbYKOLFn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2008 06:05:43 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id ED7A0520009;
	Sat, 15 Nov 2008 12:00:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bBWvEC+xUZzC; Sat, 15 Nov 2008 12:00:07 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 56E69520005;
	Sat, 15 Nov 2008 12:00:07 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <3af572ac0811150228k291b8850idc34cb474f455aa7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101058>

Pau Garcia i Quiles wrote:
>> Shawn posted the exact text. The spirit of that license is that anyone can
>> use an unmodified version of the library for whatever they want, but it's
>> illegal to link non-GPL software to an altered version of the library. That
>> is, the git community will get all changes back while other projects can
>> use the official version of the library without having to worry about
>> licensing issues. EvilCompany cannot make changes to the library and then
>> link non-GPL'd software to their changed version. They can do that if they
>> send their library changes upstream and then only use them once they're
>> considered "official" though.
> 
> Do you mean if I write a patch to libgit2, send it upstream and make
> it public on my website but it is not accepted upstream, I cannot link
> my modified libgit2 version (i. e. libgit2 + my patch) to my non-GPL
> software?

I think that's the case, yes.

> It looks insane to me: I wrote the patch and made it public
> but you guys did not accept it!
> 

Well, if you wrote a patch that uses a closed-source database library
to store git objects in, how would that benefit the community even if
you published the patch?

You could ofcourse fork the library, but then you'd have to take care
of namespace conflicts and such things. The fork would naturally have
to be licensed GPL + gcc-exception too, since it's a derivative work.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
