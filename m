From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 20:02:28 +0200
Message-ID: <op.utxlqej91e62zd@balu>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <81b0412b0905140516k4bc84606scb71981936966caf@mail.gmail.com>
 <op.utw7buoi1e62zd@balu>
 <81b0412b0905140616h69ac2919j26734f02455a5f5c@mail.gmail.com>
 <op.utw9khqa1e62zd@balu>
 <fabb9a1e0905140642x26bf5e2ala604a36d0fe520a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Erik Faye-Lund" <kusmabite@gmail.com>
To: "Sverre Rabbelier" <srabbelier@gmail.com>,
	"Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4fGU-0004m2-CI
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbZENSCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbZENSCb
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:02:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:32896 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751456AbZENSCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:02:30 -0400
Received: (qmail invoked by alias); 14 May 2009 18:02:30 -0000
Received: from balu.cs.uni-paderborn.de (EHLO balu.cs.uni-paderborn.de) [131.234.21.37]
  by mail.gmx.net (mp039) with SMTP; 14 May 2009 20:02:30 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX1+1fndkjVy1Wmvl5BIpaJQa9QuzHYTAD/7NINGNeJ
	BYkP/QXnYC62CX
Received: from [127.0.0.1] (helo=balu)
	by balu.cs.uni-paderborn.de with esmtp (Exim 4.69)
	(envelope-from <matthias.andree@gmx.de>)
	id KJNBG5-0003JW-B7; Thu, 14 May 2009 20:02:29 +0200
In-Reply-To: <fabb9a1e0905140642x26bf5e2ala604a36d0fe520a6@mail.gmail.com>
User-Agent: Opera Mail/9.64 (Win32)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119206>

Am 14.05.2009, 15:42 Uhr, schrieb Sverre Rabbelier <srabbelier@gmail.com>:

> Heya,
>
> On Thu, May 14, 2009 at 15:39, Matthias Andree <matthias.andree@gmx.de>  
> wrote:
>> The bug itself (references to 'deleted' or 'replaced' tag objects remain
>> reachable rather than becoming dangling) is still there without a  
>> suggestion
>> to the solution, and you're uselessly the bug.
>
> I believe Alex is saying that this is not a bug, but intended
> behavior, and Matthias is saying that we should change that behavior
> so that users are at least aware that they are creating such a
> situation, is that correct?

I think my statements are:

1- git tag -d and git tag -f do not work as advertised for tag objects (as
opposed to lightweight tags); evidence in the longish mail

2- I presume that the bug cannot be really fixed (signed tags created by
somebody else), we then have several solutions:
  2a- warn the user and refuse
  2b- warn the user and continue nonetheless
  2c- warn the user and add options to force the user should at least be
warned that he may be doing something which doesn't work as intended, or
  2d- give the user a possibility to force git to do stupid things.

-- 
Matthias Andree
