From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Wed, 15 Oct 2008 17:21:14 +0200 (CEST)
Message-ID: <c84d2f2498509bfb916c060317892998.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <DE453BEE-6749-4892-BFAA-3B37CFAADD3E@cs.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Richard Bubel" <bubel@cs.chalmers.se>
X-From: git-owner@vger.kernel.org Wed Oct 15 17:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq89m-0004tz-SL
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 17:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751716AbYJOPSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbYJOPSP
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 11:18:15 -0400
Received: from mail.codewut.de ([78.47.135.140]:53438 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751461AbYJOPSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 11:18:14 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 9B0F37BEF1; Wed, 15 Oct 2008 17:21:17 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id D0A317BE67;
	Wed, 15 Oct 2008 17:21:14 +0200 (CEST)
Received: from 194.127.8.18
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Wed, 15 Oct 2008 17:21:14 +0200 (CEST)
In-Reply-To: <DE453BEE-6749-4892-BFAA-3B37CFAADD3E@cs.chalmers.se>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98281>

Ok, this might be the difference. I am pretty sure my
filesystem is not case-sensitive (default?).
At least "mkdir Foo" fails when "foo" exists.

Yours,
Lars

> Hi,
>
> On Oct 15, 2008, at 16:51 , Lars Hoss wrote:
>
>>> Works for me on Leopard
>>> [...]
>>> Vienna:a pieter$ git --version
>>> git version 1.6.0.2.415.gf9137
>>
>> My git version "1.6.0.2" says:
>>
>> # On branch master
>> [...]
>> git --version
>> git version 1.6.0.2
>>
>> Git was build from macports.
>
>
> works for me too on OS X 10.5.5 with git 1.6.0.2 from MacPorts. As it
> deviates from the default, it might be worth mentioning that the
> filesystem in use here is the case-sensitive version of HFS+.
>
> Best Regards,
>    Richard
>
