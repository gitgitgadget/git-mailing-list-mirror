From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String Library.
Date: Thu, 06 Sep 2007 11:12:48 +0200
Message-ID: <46DFC490.3060200@op5.se>
References: <vpq642pkoln.fsf@bauges.imag.fr> <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com> <20070906045942.GR18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 11:13:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITDQ0-0000HR-EH
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 11:12:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885AbXIFJMw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 05:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753206AbXIFJMw
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 05:12:52 -0400
Received: from mail.op5.se ([193.201.96.20]:52925 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753839AbXIFJMv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 05:12:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id EC55A194465;
	Thu,  6 Sep 2007 11:12:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oCsHIs36kcIM; Thu,  6 Sep 2007 11:12:49 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 2C509194421;
	Thu,  6 Sep 2007 11:12:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070906045942.GR18160@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57846>

Shawn O. Pearce wrote:
> Dmitry Kakurin <dmitry.kakurin@gmail.com> wrote:
>> When I first looked at Git source code two things struck me as odd:
>> 1. Pure C as opposed to C++. No idea why. Please don't talk about 
>> portability, it's BS.
> 
> It is also a relatively simple language that
> a large number of open source programmers know.  This makes it easy
> for them to get involved in the project.


This is important. Git contains code from more than 300 people. I'm
guessing you could cut that number by 2/3 if it had been written in C++.

Git is cheating a bit though. Its primary audience was (and is) the
various integrators working on the Linux kernel, all of whom are fairly
competent C programmers.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
