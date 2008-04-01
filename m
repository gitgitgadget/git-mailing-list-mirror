From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: "make test" fails if /path/to/git.git contains spaces
Date: Tue, 01 Apr 2008 08:29:58 +0200
Message-ID: <47F1D666.9060402@viscovery.net>
References: <47F15CDB.60109@apple.com> <3e8340490803311604v52ab9e03nd101ccadd4973760@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Adam Roben <aroben@apple.com>, git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 08:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jga1B-0000hX-74
	for gcvg-git-2@gmane.org; Tue, 01 Apr 2008 08:30:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755292AbYDAGaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 02:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755229AbYDAGaF
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 02:30:05 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:52998 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754587AbYDAGaE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2008 02:30:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JgZzQ-0001i8-P1; Tue, 01 Apr 2008 08:29:00 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8FCFD4E4; Tue,  1 Apr 2008 08:29:58 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <3e8340490803311604v52ab9e03nd101ccadd4973760@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78635>

Bryan Donlan schrieb:
> On Mon, Mar 31, 2008 at 5:51 PM, Adam Roben <aroben@apple.com> wrote:
>>  Do we want to support having spaces in your path? It doesn't seem hard
>>  to fix, but it does seem like the kind of problem that will come up over
>>  and over again if only a very small set of people have this configuration.
> 
> Turns out that while trying to fix the tests, I've found that
> git-rebase doesn't like a $VISUAL having spaces, so perhaps this
> should be tested more often :) Or should we just require $VISUAL have
> no spaces?
> 
> I'll send a patch once I've got everything passing.

There was an attempt in the past to make this working. Please look at this
(rather lengthy) thread, in particular, my critique on the patches that
were submitted:

http://thread.gmane.org/gmane.comp.version-control.git/60544

I really would not like to see the same issues that I took the time to
comment on to show up again.

-- Hannes
