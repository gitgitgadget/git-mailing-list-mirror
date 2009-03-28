From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: git svn clone failure
Date: Sat, 28 Mar 2009 16:20:29 +0100
Message-ID: <200903281620.29564.markus.heidelberg@web.de>
References: <A5DCF978-5D10-4A6C-BE4B-1024FA475E2F@gmail.com> <200903281359.34412.markus.heidelberg@web.de> <F76E6356-60EB-4FDE-B97E-CB34FF2D7017@gmail.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 16:22:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnaMG-0007f7-Rq
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 16:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756741AbZC1PUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 11:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755137AbZC1PUd
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 11:20:33 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:40019 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbZC1PUd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 11:20:33 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id 8C06AFC31162;
	Sat, 28 Mar 2009 16:20:30 +0100 (CET)
Received: from [89.59.72.204] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LnaKk-0007Fl-00; Sat, 28 Mar 2009 16:20:30 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <F76E6356-60EB-4FDE-B97E-CB34FF2D7017@gmail.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/JHe22jW49Juh1ENlJ8Vn+wQEIanFvYjOT3zwv
	zpNrJYVehzaLo7+QXodV7Yysf6cwADeHssws8xZRAkMJhsbg1b
	ZPjmSE4fTjtm8w53rsOA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114961>

Lachlan Deck, 28.03.2009:
> On 28/03/2009, at 11:59 PM, Markus Heidelberg wrote:
> 
> > Lachlan Deck, 27.03.2009:
> >> Hi there,
> >>
> >> I'm trying to clone an existing svn repository with git (just getting
> >> started with git) and it keeps failing with:
> >> ...
> >> r604 = 6428e63734a21ee5fcb4593274747e2758578a91 (git-svn)
> >> fatal: unable to run 'git-svn'
> >
> > Are you sure r604 isn't the latest svn revision?
> 
> A few thousand out, yes.
> 
> > I always get this error when doing "git svn fetch" with an http URL,  
> > it
> > doesn't occur with an svn URL. But everything seems to work fine,
> > though.
> 
> Interesting. Yes, it's from an https url. I'll try svn+ssh://..
> But are you saying there's no way to get more info about the error?

At least I don't have more info about it except for this:
I use Gentoo Linux and the git ebuild (I have the distribution package
installed, but use the self-compiled git) says

    "Per Gentoo bugs #223747, #238586, when subversion is built"
    "with USE=dso, there may be weird crashes in git-svn. You"
    "have been warned."

I have subversion compiled with dso (Enable runtime module search), it's
enabled per default. And since it worked, I didn't change it. But it
would be interesting to see, if this error has something to do with it.
Maybe I'll try it out.

Markus
