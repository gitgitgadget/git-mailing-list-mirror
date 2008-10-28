From: Andreas Ericsson <ae@op5.se>
Subject: Re: [VOTE] git versus mercurial (for DragonflyBSD)
Date: Tue, 28 Oct 2008 18:48:28 +0100
Message-ID: <4907506C.8090609@op5.se>
References: <ge0rla$mce$1@ger.gmane.org> <200810272149.13542.arne_bab@web.de> <20081027210716.GS2273@genesis.frugalware.org> <200810272230.51683.arne_bab@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	mercurial@selenic.com, SLONIK.AZ@gmail.com
To: Arne Babenhauserheide <arne_bab@web.de>
X-From: git-owner@vger.kernel.org Tue Oct 28 18:50:17 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kushl-0002ix-Em
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 18:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754331AbYJ1Rsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 13:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752504AbYJ1Rsg
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 13:48:36 -0400
Received: from mail.op5.se ([193.201.96.20]:32955 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331AbYJ1Rsg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 13:48:36 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 697C324B001C;
	Tue, 28 Oct 2008 18:42:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wk9sWD2DGwzY; Tue, 28 Oct 2008 18:42:52 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id D501324B001B;
	Tue, 28 Oct 2008 18:42:51 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <200810272230.51683.arne_bab@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99309>

Arne Babenhauserheide wrote:
> Am Montag 27 Oktober 2008 22:07:16 schrieb Miklos Vajna:
>> IIRC the main reason git aliases can't overwrite git commands is because
>> that would break scripts relying on the output of existing git commands.
>> Given that I install such an extension, won't my script break?
> 
> Since that "script" will likely be an extension which will use the core 
> function instead of the UI command, it won't break. 
> 
> Stuff which does command line parsing can naturally break when I change the 
> output. But it can also directly use the advanced features. 
> 

But then you're back with a single language, taking valuable freedom
away from the addon author. How many perl gurus have skipped writing
stuff for hg because it's a "python-or-bust" thing?

And please don't give me that rubbish of "but Python is obviously better
than C". Which one's true (if any) depends only on how you define "better".

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
