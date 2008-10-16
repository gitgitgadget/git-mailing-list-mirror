From: Pedro Melo <melo@simplicidade.org>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 10:49:45 +0100
Message-ID: <EF4CC05B-894C-40FB-B803-E30F07284C1C@simplicidade.org>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net> <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl> <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net> <DE453BEE-6749-4892-BFAA-3B37CFAADD3E@cs.chalmers.se> <c84d2f2498509bfb916c060317892998.squirrel@webmail.highteq.net>
Mime-Version: 1.0 (Apple Message framework v928.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Richard Bubel" <bubel@cs.chalmers.se>,
	"Pieter de Bie" <pdebie@ai.rug.nl>, "Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: Lars Hoss <lars@woeye.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 11:51:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqPVV-0006U2-JK
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 11:51:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbYJPJtt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 05:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbYJPJtt
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 05:49:49 -0400
Received: from speed.simplicidade.org ([81.92.204.129]:44416 "HELO
	speed.simplicidade.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753085AbYJPJts (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 05:49:48 -0400
Received: (qmail 1648 invoked from network); 16 Oct 2008 09:49:53 -0000
Received: from bl4-247-138.dsl.telepac.pt (HELO [192.168.0.201]) (81.193.247.138)
  (smtp-auth username melo@simplicidade.org, mechanism cram-md5)
  by speed.simplicidade.org (qpsmtpd/0.43rc1) with (AES256-SHA encrypted) ESMTPSA; Thu, 16 Oct 2008 10:49:53 +0100
In-Reply-To: <c84d2f2498509bfb916c060317892998.squirrel@webmail.highteq.net>
X-Priority: 3 (Normal)
Jabber-Id: melo@simplicidade.org
X-Mailer: Apple Mail (2.928.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98358>

Hi,

On Oct 15, 2008, at 4:21 PM, Lars Hoss wrote:

> Ok, this might be the difference. I am pretty sure my
> filesystem is not case-sensitive (default?).
> At least "mkdir Foo" fails when "foo" exists.

My filesystem is Mac OS Extended (Journaled) case-insensitive like  
yours, and submodules work.

Best regards,


>
>
> Yours,
> Lars
>
>> Hi,
>>
>> On Oct 15, 2008, at 16:51 , Lars Hoss wrote:
>>
>>>> Works for me on Leopard
>>>> [...]
>>>> Vienna:a pieter$ git --version
>>>> git version 1.6.0.2.415.gf9137
>>>
>>> My git version "1.6.0.2" says:
>>>
>>> # On branch master
>>> [...]
>>> git --version
>>> git version 1.6.0.2
>>>
>>> Git was build from macports.
>>
>>
>> works for me too on OS X 10.5.5 with git 1.6.0.2 from MacPorts. As it
>> deviates from the default, it might be worth mentioning that the
>> filesystem in use here is the case-sensitive version of HFS+.
>>
>> Best Regards,
>>   Richard
>>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
