From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Sun, 09 Sep 2007 01:50:34 +0200
Message-ID: <46E3354A.7030407@op5.se>
References: <46DDC500.5000606@etek.chalmers.se> <1189004090.20311.12.camel@hinata.boston.redhat.com> <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>      =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0709061839510.5?=
	=?ISO-8859-1?Q?626@evo.linux-fo?= =?ISO-8859-1?Q?undation.or=04g>?= <a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com> <alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org> <alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org> <fbqmdu$udg$1@sea.gmane.org> <85k5r27wkv.fsf@lola.goethe.zz>      =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?f=04br1a2$qm7$1@se?= =?ISO-8859-1?Q?a.gmane.org>?= <851wda7ufz.fsf@lola.goethe.zz> <fbr4oi$5ko$1@sea.gmane.org> <85wsv26cv8.fsf@lola.goethe.zz> <fbsbul$dg0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:52:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOn-00046X-Dq
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:09 +0200
Received: from mail-mx2.uio.no ([129.240.10.30])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUA4k-0006MX-R9
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:50:54 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx2.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUA4d-0006Ap-7f
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755212AbXIHXuk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 19:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208AbXIHXuk
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 19:50:40 -0400
Received: from mail.op5.se ([193.201.96.20]:42785 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753115AbXIHXuj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 19:50:39 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 8696519443B;
	Sun,  9 Sep 2007 01:50:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UE0QGBtZa8Ad; Sun,  9 Sep 2007 01:50:36 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id CA4D9194414;
	Sun,  9 Sep 2007 01:50:35 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <fbsbul$dg0$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: EF88270898128662EFCD1F0EF316A23502696107
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 29 total 517786 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58149>

Walter Bright wrote:
> David Kastrup wrote:
>> Again, C won't keep you from shooting yourself in the foot.
> 
> Right, it won't. A good systems language should do what it can to 
> prevent the programmer from *inadvertently* shooting himself in the 
> foot, while allowing him to *deliberately* shoot himself in the foot.
> 

No, a good systems language should do exactly what it's told. Supporting
tools should tell the programmer if he's risking shooting himself in the
foot.

> 
>> You can tell C compilers to
>> check all array accesses, but that is a performance issue.
> 
> Runtime checking of arrays in D is a performance issue too, so it is 
> selectable via a command line switch.

Same as in C then.

> But more importantly,
> 
> 2) For dynamically sized arrays, the dimension of the array is carried 
> with the array, so loops automatically loop the correct number of times. 
> No runtime check is necessary, and it's easier for the code reviewer to 
> visually check the code for correctness.
> 

But this introduces handy but, strictly speaking, unnecessary overhead as
well, meaning, in short; 'D is slower than C, but easier to write code in'.

So in essence, it's a bit like Python, but a teensy bit faster and a lot
easier to shoot yourself in the foot with.

What was the niche you were going for when you thought up D? It can't have
been systems programming, because *any* extra baggage is baggage one would
like to get rid of. If it was application programming I fail to see how one
more language would help, as there will be portability problems galore and
it's still considerably slower to develop in than fe Python, while at the
same time being considerably easier to mess up in.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
