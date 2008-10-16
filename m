From: "Lars Hoss" <lars@woeye.net>
Subject: Re: [BUG] git status doesn't handle submodules properly on OSX
Date: Thu, 16 Oct 2008 12:30:19 +0200 (CEST)
Message-ID: <fa8b32c2ff1d10914c5f3f24f79db91b.squirrel@webmail.highteq.net>
References: <c60a85c1297be6446ad92a3e7723ddc8.squirrel@webmail.highteq.net>
    <5D0481A4-D173-4CF8-B855-5E58978210F8@ai.rug.nl>
    <6ca24750ca8d7bd9e995d023e78e0d71.squirrel@webmail.highteq.net>
    <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Lars Hoss" <lars@woeye.net>, "Pieter de Bie" <pdebie@ai.rug.nl>,
	"Jeff King" <peff@peff.net>,
	"Git Mailinglist" <git@vger.kernel.org>
To: "Pedro Melo" <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Thu Oct 16 12:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqQ5l-00024H-I5
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 12:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578AbYJPK1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 06:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbYJPK1S
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 06:27:18 -0400
Received: from mail.codewut.de ([78.47.135.140]:55702 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969AbYJPK1R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 06:27:17 -0400
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 502317BEF1; Thu, 16 Oct 2008 12:30:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 136FA7BE4C;
	Thu, 16 Oct 2008 12:30:19 +0200 (CEST)
Received: from 194.127.8.17
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Thu, 16 Oct 2008 12:30:19 +0200 (CEST)
In-Reply-To: <524C98C8-C3A5-4501-932A-2F0ACDE2886A@simplicidade.org>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98363>

Hi!

I've cloned git this morning in order to try a build from this.
But chances are small that it will make a difference. Because from
the portfile I can see that macports just downloads 1.6.0.2 release
and builds it without any special patches or configure options.

As I said before, 1.5.6 works fine for me. But why 1.6.0.2 does not
work on my box - I don't know yet. Since Pedro uses a case-insensitive
volume as well, the problem seems not be related to sensitve/insensitive.

Now that I have a git clone on my box I might try bisect as well.

Yours,
Lars

> On Oct 15, 2008, at 3:51 PM, Lars Hoss wrote:
>
>>> Works for me on Leopard
>>>
>>> Vienna:a pieter$ git submodule add ~/projects/GitX/ gitx
>>> Initialized empty Git repository in /Users/pieter/a/gitx/.git/
>>> Vienna:a pieter$ git st
>>> # On branch master
>>> # Changes to be committed:
>>> #   (use "git reset HEAD <file>..." to unstage)
>>> #
>>> #	new file:   .gitmodules
>>> #	new file:   gitx
>>> #
>>> Vienna:a pieter$ git --version
>>> git version 1.6.0.2.415.gf9137
>>
>> My git version "1.6.0.2" says:
>>
>> # On branch master
>> # Changes to be committed:
>> #   (use "git reset HEAD <file>..." to unstage)
>> #
>> #	new file:   .gitmodules
>> #	new file:   lib
>> #
>> # Untracked files:
>> #   (use "git add <file>..." to include in what will be committed)
>> #
>> #	lib/
>> git --version
>> git version 1.6.0.2
>>
>> Git was build from macports.
>
> hmms.. Really, I know about fink and Macports and all others, but I'm
> using Mac OS X since version 10.1 (when compiling OSS software was
> near impossible due to Apple decisions) and I've always had better
> results with compiling my own than using any of those OSS repositories.
>
> I understand the appeal, it seems easier, but I would recommend that
> you compile yourself the software packages you depend on.
>
> Regarding git, I saw a git-build.sh script floating around. If you
> cannot find it, you might want to try my own recipe
> (http://tinyurl.com/4ayze6
> ). I compile git master every day (cron) and thats the one I use on my
> main machine.
>
> Best regards,
> --
> Pedro Melo
> Blog: http://www.simplicidade.org/notes/
> XMPP ID: melo@simplicidade.org
> Use XMPP!
>
>
>
