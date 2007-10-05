From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about "git commit -a"
Date: Fri, 05 Oct 2007 14:17:16 +0200
Message-ID: <47062B4C.5090503@op5.se>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>	<545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>	<fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>	<Pine.LNX.4.64.0710042209410.4174@racer.site>	<4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>	<4705FB52.3030208@op5.se>	<4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>	<47060BB3.3030208@op5.se> <vpqy7ehj2g8.fsf@bauges.imag.fr>	<47060E98.2090601@op5.se> <vpqsl4piykb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:17:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idm7a-0000Cr-67
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbXJEMR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbXJEMR0
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:17:26 -0400
Received: from mail.op5.se ([193.201.96.20]:36700 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027AbXJEMRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:17:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BE7E61944C6;
	Fri,  5 Oct 2007 14:17:23 +0200 (CEST)
X-Spam-Score: -4.189
X-Spam-Level: 
X-Spam-Status: No, score=-4.189 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.210, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EjT6M5MbU54q; Fri,  5 Oct 2007 14:17:18 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BB4E2194465;
	Fri,  5 Oct 2007 14:17:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <vpqsl4piykb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60073>

Matthieu Moy wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
>>>> or check which merge- conflicts you've already resolved,
>>> At least bzr and baz have this kind of conflict management. It's just
>>> a separate file, containing the list of unresolved conflicts.
>> Can you check them against any revision you want? If so, I'm
>> impressed :)
> 
> If you mean s/check/diff/, not in a simple way, no. Otherwise, I don't
> understand what you mean by "check merge-conflicts you've already
> resolved against any revision".
> 

Actually, I meant "diff the staged area against any random commit". It's
really nice to do after a bisect, where you know what the bad commit looks
like, and how the code changed to introduce the bug.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
