From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 11:15:51 +0100
Message-ID: <6887C6DB-E9C8-4DC8-BD1E-C20E92271FA5@wincent.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com> <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com> <2A7CAA9F-DB42-4782-BF61-41E8DA577DF2@wincent.com> <20090219101154.GB16119@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:17:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5yD-00032o-FH
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbZBSKQA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 05:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753195AbZBSKQA
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 05:16:00 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:45060 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZBSKP7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 05:15:59 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1JAFpcH031040
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 19 Feb 2009 05:15:54 -0500
In-Reply-To: <20090219101154.GB16119@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110665>

El 19/2/2009, a las 11:11, Jeff King escribi=F3:

> On Thu, Feb 19, 2009 at 10:59:15AM +0100, Wincent Colaiuta wrote:
>
>>> If a sample of git users would expect "git rebase -i" to let you
>>> rebase the last few commits, then it doesn't really matter all that
>>> much what N is.  10 seems a reasonable default as any.
>>
>> That's exactly the problem. Most git users aren't going to expect =20
>> "git
>> rebase -i" to let you "rebase the last few commits".
>>
>> Rebase is mostly used, talked about, and conceptualized in terms of
>> rebasing onto other _branches_.
>
> Actually, I don't think that's true anymore with "rebase -i"; it is
> probably most convenient way in core git to rewrite the history of a
> patchset. E.g., a core part of my workflow as a contributor is:
>
>  $ git checkout -b jk/topic origin
>  $ while true; do hack hack hack; commit commit commit; done
>  $ git rebase -i origin
>
> which gives me a list of everything on the topic, ready to be
> reordered, squashed, or edited as appropriate.

Yes, I do the same. But notice that you did "git rebase -i --=20
 >>>origin<<<---". Seems to me you are definitely _thinking_ in terms =20
of your topic _branch_ and not in terms of "the last few commits".

Cheers,
Wincent
