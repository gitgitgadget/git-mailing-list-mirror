From: Andreas Ericsson <ae@op5.se>
Subject: Re: the war on trailing whitespace
Date: Mon, 27 Feb 2006 12:41:33 +0100
Message-ID: <4402E56D.4010606@op5.se>
References: <20060225174047.0e9a6d29.akpm@osdl.org>	 <7v1wxq7psj.fsf@assigned-by-dhcp.cox.net>	 <20060225210712.29b30f59.akpm@osdl.org>	 <Pine.LNX.4.64.0602260925170.22647@g5.osdl.org>	 <20060226103604.2d97696c.akpm@osdl.org>	 <Pine.LNX.4.64.0602261213340.22647@g5.osdl.org>	 <20060226202617.GH7851@redhat.com> <1141008633.7593.13.camel@homer>	 <Pine.LNX.4.63.0602271004130.5937@wbgn013.biozentrum.uni-wuerzburg.de> <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	MIke Galbraith <efault@gmx.de>, Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Andrew Morton <akpm@osdl.org>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 12:41:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDgl2-00064l-Po
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 12:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbWB0Llg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 06:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWB0Llg
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 06:41:36 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:63405 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750849AbWB0Llf
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 06:41:35 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 02D646BD10; Mon, 27 Feb 2006 12:41:33 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Adrien Beau <adrienbeau@gmail.com>
In-Reply-To: <94fc236b0602270326s3079d737l102d5728d59f0c98@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16835>

Adrien Beau wrote:
> On 2/27/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
>>there is a good reason not to enable the no-whitespace-at-eol checking in
>>pre-commit by default (at least for *all* files) for git development:
>>
>>        Python.
>>
>>Just do a "/ $" in git-merge-recursive.py. These whitespaces are not an
>>error, but a syntactic *requirement*.
> 
> 
> No, they aren't.
> 
> A logical line that contains only spaces and tabs is ignored by
> Python. (All the "dirty" lines in git-merge-recursive.py are such
> lines.)
> 

I think the question is whether completely empty lines are also ignored 
by Python, or if they start a new block of code. Whatever the case, it 
must hold true for both 2.3 and 2.4.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
