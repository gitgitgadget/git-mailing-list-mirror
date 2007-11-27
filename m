From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 27 Nov 2007 16:18:02 +0100
Message-ID: <474C352A.2080708@op5.se>
References: <200711270622.lAR6MFXQ010010@mi0.bluebottle.com> <Pine.LNX.4.64.0711271109130.27959@racer.site> <474C1F80.5060404@op5.se> <Pine.LNX.4.64.0711271352050.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 16:18:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix2Ck-0005lc-JG
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 16:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755636AbXK0PSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 10:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbXK0PSK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 10:18:10 -0500
Received: from mail.op5.se ([193.201.96.20]:33512 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755616AbXK0PSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 10:18:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id F22061F0803C;
	Tue, 27 Nov 2007 16:18:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YGRtFpiq9CFQ; Tue, 27 Nov 2007 16:18:07 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id D75E21F08037;
	Tue, 27 Nov 2007 16:18:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0711271352050.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66227>

Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 27 Nov 2007, Andreas Ericsson wrote:
> 
>> Johannes Schindelin wrote:
>>
>>>  One thing that could go possibly wrong, for example, is to rebase 
>>> commits that you already published.
>> For the vast majority of git users, that's a non-issue as "published" is 
>> usually defined as "pushed to the publicly advertised watering hole".
> 
> No.  This is only the "vast majority of git users told by their peers to 
> use a central repository".
> 


Let me rephrase.
For any project large enough to want to attract random hackers, there
will always be a single repository considered the public "master repo".
For such projects code is most likely considered "published" when the
code hits that repository (or some middle-stage on its way to it).

It has to do with communication and convenience. When the code reaches
that master repo it's no longer easy to communicate the fact that it
has been rebased to everyone it's been published to.


> Just because you use git like cvs does not mean that you "use git".
> 

I suppose Junio and Linus don't "use git" either then, as they're both
in control of at least one such "master repo" each. Ah well. At least
I'm in good company.


>> Yes, I'm aware that git is distributed. That doesn't mean that it's not 
>> convenient to have one single place where all code meant to be released 
>> eventually ends up.
> 
> It may be convenient for you.  I do not like it.


It's not only convenient for me. It's convenient for the tens of thousands
of people working on the Linux kernel to have a single place to go to for
that one repository that somehow fathers all the tarballs.

So long as it's a small group of developers working on something, it's
obviously not necessary to provide such a place, but when you want to
attract the huge anonymous coders that you've never spoken to, you need
a single place to post the latest and greatest.


>  Yes, I even made the 
> mistake with msysGit.  In the end, it would have been much more 
> intelligent to set up a repository which others would have had to fork 
> from.
> 

So? Any new developer wanting to work on it will still try to locate
the public copy of the "master repo" to start their fork from.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
