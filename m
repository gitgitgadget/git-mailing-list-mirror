From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] format-patch: autonumber by default
Date: Thu, 02 Oct 2008 15:43:09 +0200
Message-ID: <48E4CFED.3060903@op5.se>
References: <1222946860-15518-1-git-send-email-giuseppe.bilotta@gmail.com>	 <alpine.DEB.1.00.0810021433130.22125@pacific.mpi-cbg.de.mpi-cbg.de> <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 15:44:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlOTl-0001Ve-48
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 15:44:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754141AbYJBNnO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbYJBNnO
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 09:43:14 -0400
Received: from mail.op5.se ([193.201.96.20]:33392 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753942AbYJBNnO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 09:43:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5F5F31B8004F;
	Thu,  2 Oct 2008 15:34:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwNp7ZJn+5ya; Thu,  2 Oct 2008 15:34:42 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.14])
	by mail.op5.se (Postfix) with ESMTP id 4E2871B80048;
	Thu,  2 Oct 2008 15:34:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <cb7bb73a0810020610q657dec7clf85b4ef3575b751f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97327>

Giuseppe Bilotta wrote:
> On Thu, Oct 2, 2008 at 2:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Thu, 2 Oct 2008, Giuseppe Bilotta wrote:
>>
>>> Set auto-number true by default, allowing the format.number key to be
>>> set to 'noauto' to override this.
>>> ---
>>>  builtin-log.c |    6 +++++-
>>>  1 files changed, 5 insertions(+), 1 deletions(-)
>> Interesting.  No sign-off, no defense why this is actually desirable,
>> after we lived for so long without this behavior... Care to elaborate?
> 
> Doh, sorry about the Sign-off, I'll resend with.
> 
> Now, about the reason for this patch: I would say that the most common
> use-case of format-patch being used to prepare multiple patches is
> when one plans on sending a patchset. When format.numbering is set to
> auto, single-patches will still be extracted without numbers, but
> patchset will be properly numbered.
> 

I like it. It hasn't bitten me since I moved to imap-send, but when I
used send-email I sometimes forgot and ended up sending patch-series
without numbers.

I sent a patch for it once, but changed the default instead of making
it configurable so it got turned down.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
