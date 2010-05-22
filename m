From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: What's the best way to make my company migrate to Git?
Date: Sat, 22 May 2010 11:52:01 +0100
Message-ID: <4BF7B751.7050704@pileofstuff.org>
References: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 22 13:11:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFmbo-00019t-GP
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 13:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753907Ab0EVLLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 May 2010 07:11:04 -0400
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:14187 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752481Ab0EVLLA (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 May 2010 07:11:00 -0400
X-Greylist: delayed 1133 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 May 2010 07:10:59 EDT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100522105204.QELJ14666.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Sat, 22 May 2010 11:52:04 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout02-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100522105203.HSNG1586.aamtaout02-winn.ispmail.ntl.com@[192.168.1.5]>;
          Sat, 22 May 2010 11:52:03 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <AANLkTikwpjtJnR856CHr_O3856JoMrFBgOQGODXNBbeI@mail.gmail.com>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=BxPs6DqL8UcA:10 a=UBIxAjGgU1YA:10 a=IkcTkHD0fZMA:10 a=v9beyyg-DFlU8wgCEF0A:9 a=GwwvMkx9x3TezHxo4a76cozRIXkA:4 a=QEXdDO2ut3YA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147514>

Hi Daniele,

I'm a developer getting towards the end of introducing my company to 
Git.  Here are some thoughts based on the (mis)steps I took.


I found that advocating specific steps wasn't that effective - I just 
came across as being pushy and hard to work with.  It was more effective 
to politely show off what I could do with git-svn, and let people get 
jealous enough to work the "how" out for themselves.  Here are some 
examples:

I would quietly bisect a hard-to-fix bug, then say "if it's any help, 
git tells me it was introduced by so-and-so in revision N".  Sometimes 
it was no help, but sometimes it was enough to provoke the appropriate 
"aha!" for the bug.

I would nonchalantly use as many git features as I could while showing 
people my work.  So "here's the diff for my work... grr whitespace ... 
hang on I'll add `-w`... anyway, these are the REAL differences...". The 
fact it was all in glorious technicolour went without mention.

When we had a big merge that nobody was looking forward to, I said "let 
me do it!  It'll give me a chance to practice my git-fu".

When I used svn on somebody else's command-line, I'd blame the mistakes 
I made on being spoiled by Git.  So "I'll just do an `svn log`... argh 
no!  Control-C!  Control-C!  Right, `svn log | less`... my bad, git 
pipes to less automatically."


Over the course of a few months, people became convinced that Git was 
something that makes you more productive.  Our lead developer had a go 
with git-svn for a while, before our boss decided we should all make the 
switch.

I tried to make git-svn as painless as possible with some svn-like 
aliases and a cheatsheet, which I'd be happy to upload if the list could 
suggest a good place to put a PDF and some text.

The move worked for a while, but it turned out that one-and-a-half git 
experts supporting the rest of the team wasn't enough to stop people 
from making rookie mistakes like `git merge`ing into an SVN branch with 
unpushed changes.  We had to accelerate our move to git on the server, 
and I got a lot of exercise and not much work done that month as I 
dashed from desk to desk.

Things gradually calmed down as people got more comfortable with git. 
But I expect to be occasionally called over for a long time as people 
learn new tricks - "how do I, like, cherry-unpick a single commit?"

	- Andrew Sayers
