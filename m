From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git config not expanding user home directories
Date: Wed, 01 Oct 2008 09:52:36 +0200
Message-ID: <48E32C44.40708@op5.se>
References: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au> <48E2043A.4000501@op5.se> <m33ajhsw24.fsf@localhost.localdomain> <20081001032246.GB24513@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, Tom Lanyon <tom@netspot.com.au>,
	Karl Chen <quarl@quarl.org>,
	Git Mailinglist <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 01 09:54:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkwX2-0001Pb-Ps
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 09:54:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYJAHwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 03:52:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbYJAHwq
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 03:52:46 -0400
Received: from mail.op5.se ([193.201.96.20]:51843 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752540AbYJAHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 03:52:45 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CE6B824B0008;
	Wed,  1 Oct 2008 09:44:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.561
X-Spam-Level: 
X-Spam-Status: No, score=-3.561 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.838, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zNXmcmthGqKz; Wed,  1 Oct 2008 09:44:02 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 765431B8005F;
	Wed,  1 Oct 2008 09:44:00 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001032246.GB24513@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97210>

Jeff King wrote:
> On Tue, Sep 30, 2008 at 04:38:46AM -0700, Jakub Narebski wrote:
> 
>> There was a patch send to git mailing list adding basic '~' support
>> (I think via $ENV{HOME}), and IIRC even ~user support. I don't know
>> what happened to those patches (check mailing list archive), but
>> most probably it was not accepted because it didn't provide a way
>> for scripts to use this functionality, for example via --path option.
> 
> There were several rounds, and I thought it was shaping up, but then
> no more rounds came. I assume that Karl lost interest (or perhaps we
> nitpicked him to death), but I thought at the end of the thread Junio
> laid out a plan for the next revision. I guess nobody cared enough about
> the feature to implement it after that (though I think I found the final
> version acceptable with a minor documentation tweak, I think Junio laid
> out a cleaner approach).
> 
> The last patch is here, with one of the replies from Junio giving the
> aforementioned plan:
> 
>   http://mid.gmane.org/quack.20080829T0229.lthhc94rwyr_-_@roar.cs.berkeley.edu
> 

That looks roughly like the way I'd have done it. I'll see if I can find
the time to polish it up a bit.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
