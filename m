From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 18:59:13 +1200
Message-ID: <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 10 08:59:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxHOU-0001uf-5H
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 08:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760021AbXFJG7R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 02:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759496AbXFJG7Q
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 02:59:16 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:23366 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759433AbXFJG7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 02:59:16 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1119322wxc
        for <git@vger.kernel.org>; Sat, 09 Jun 2007 23:59:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TFvsCwuP3ciK6HEzpPCdd9gGVT6/8YVRGDDDqybWTHHMDjXOVEdRtMsVY5O4IE0niGdBEHu9B1hqX2L0oEyy3lY9MeBdUq1R54Z4CxWZJ6c54VULfvEf2VhVP+ZPIOag0vFAmzrSNQTCDXiOtzDylJTW7WkM6muZMTyyqbUbrRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GYicKmX5losArsnT/51jCafmeTszVNlw7FSTc226rb1e5nZGlK98Ua85FX4qabnOVyHQ1gMQJti5CTkTFTSJoFDl34TTd9TEUCWKHUshvkwRb/+QOHLqZOyrPSr89onzxS2f1YkeitNmskMyDogja/9cEVqlVduN6gnhIVahxPA=
Received: by 10.90.78.9 with SMTP id a9mr4289518agb.1181458753358;
        Sat, 09 Jun 2007 23:59:13 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sat, 9 Jun 2007 23:59:13 -0700 (PDT)
In-Reply-To: <20070609121244.GA2951@artemis>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49657>

On 6/10/07, Pierre Habouzit <madcoder@debian.org> wrote:
>   FWIW I've begun to work on this (for real). I've called the tool
> "grit". You can follow the developpement on:
>
>   * gitweb: http://git.madism.org/?p=grit.git;a=summary
>   * git:    git://git.madism.org/grit.git/

Call me a fool, but writing a <new> bugtracker looks like a
boil-the-oceans scheme.

Adding git & gitweb support to traq, bugzilla, mantis, gforge, etc is
what is going to make the difference. Most of those have already the
ability to "link" to one or more commits -- after the commits are done
and in GIT.

So you can tell your bugtracker
 - which commit fixed it -- usually auto-linked if you include the
bugnumber in the commit message
 - which commit added the test -- auto linked as above
 - which commit introduced the bug -- if such thing exists and someone
digs it up

If the bugtracker can also auto-link things that look committish in
text entered by users (someone might write "bisect sez that f345e is
to blame"), with tooltips indicating in which heads those commits
resides (like gitk does), then it's just gorgeous.

But I would _never_ try to describe all the possible relations in the
schema -- existing trackers use a liberal mix of regexes and cache
tables with some free form text fields for this kind of stuff.

And definitely, if you use git as an alibi to write a new bugtracker,
don't use the "works only with git" as a feature. It should work with
as many SCMs as possible.

OTOH, that's just me, I'm lazy and like to work on already-successful
projects that are 99% there for my needs (and where I can add that
1%).

cheers,


m
