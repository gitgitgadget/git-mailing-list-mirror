From: Jeff King <peff@peff.net>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 05:20:53 -0500
Message-ID: <20090219102053.GA17417@coredump.intra.peff.net>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com> <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com> <2A7CAA9F-DB42-4782-BF61-41E8DA577DF2@wincent.com> <20090219101154.GB16119@coredump.intra.peff.net> <6887C6DB-E9C8-4DC8-BD1E-C20E92271FA5@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:22:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La62x-0004w3-4r
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbZBSKUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2009 05:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752941AbZBSKUz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:20:55 -0500
Received: from peff.net ([208.65.91.99]:40104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751526AbZBSKUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2009 05:20:55 -0500
Received: (qmail 21636 invoked by uid 107); 19 Feb 2009 10:21:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 19 Feb 2009 05:21:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Feb 2009 05:20:53 -0500
Content-Disposition: inline
In-Reply-To: <6887C6DB-E9C8-4DC8-BD1E-C20E92271FA5@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110668>

On Thu, Feb 19, 2009 at 11:15:51AM +0100, Wincent Colaiuta wrote:

>> Actually, I don't think that's true anymore with "rebase -i"; it is
>> probably most convenient way in core git to rewrite the history of a
>> patchset. E.g., a core part of my workflow as a contributor is:
>>
>>  $ git checkout -b jk/topic origin
>>  $ while true; do hack hack hack; commit commit commit; done
>>  $ git rebase -i origin
>>
>> which gives me a list of everything on the topic, ready to be
>> reordered, squashed, or edited as appropriate.
>
> Yes, I do the same. But notice that you did "git rebase -i -- 
> >>>origin<<<---". Seems to me you are definitely _thinking_ in terms of 
> your topic _branch_ and not in terms of "the last few commits".

Perhaps. I think of it as "the set of commits not yet published"
(since I publish only by sending patches to Junio, and he is my origin)
and nothing to do with the topic branch itself.

But we are just quibbling over minor terminology. I think we both agree
that HEAD~10 is silly and abitrary.

-Peff
