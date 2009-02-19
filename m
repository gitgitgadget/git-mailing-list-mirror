From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git rebase -i
Date: Thu, 19 Feb 2009 10:59:15 +0100
Message-ID: <2A7CAA9F-DB42-4782-BF61-41E8DA577DF2@wincent.com>
References: <43d8ce650902190121v2e18aac1rfaa64a4ce6e799a3@mail.gmail.com> <A3E3A7A0-F03F-4C8B-B3F8-756B0E89798C@wincent.com> <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 19 11:00:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La5i4-0005pO-Qg
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 11:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbZBSJ7V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 04:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753755AbZBSJ7V
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 04:59:21 -0500
Received: from wincent1.inetu.net ([209.235.192.161]:32812 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbZBSJ7U convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 04:59:20 -0500
Received: from cuzco.lan (54.pool85-53-5.dynamic.orange.es [85.53.5.54])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n1J9xGBk030124
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 19 Feb 2009 04:59:18 -0500
In-Reply-To: <43d8ce650902190155m4de23643r8a9d3c35686ea4e9@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110656>

El 19/2/2009, a las 10:55, John Tapsell escribi=F3:

> 2009/2/19 Wincent Colaiuta <win@wincent.com>:
>> El 19/2/2009, a las 10:21, John Tapsell escribi=F3:
>>
>>> Hi,
>>>
>>> I often do   'git rebase -i HEAD~10'  to rebase.  Since afaics it
>>> doesn't matter if you go back 'too far' I just always use HEAD~10 =20
>>> even
>>> if it's just for the last or so commit.
>>>
>>> Would there be any objections to making  'git rebase -i' default to
>>> HEAD~10  or maybe 16 or 20.
>>
>> Sounds awfully arbitrary and counter-intuitive to me.
>>
>> Take a sample of Git users who know what "git rebase" does and ask =20
>> them what
>> they intuitively think "git rebase -i" without any additional =20
>> arguments
>> should do; I'd be _extremely_ surprised if they answered that it =20
>> should
>> default to HEAD~10, HEAD~16, HEAD~20, or HEAD~N for any N.
>>
>> (I could tell you what my intuition tells me, but I don't think =20
>> it's very
>> interesting.)
>
> It doesn't really matter if the user manages to guess what the number
> N is, just that it's "recent commits".
>
> If a sample of git users would expect "git rebase -i" to let you
> rebase the last few commits, then it doesn't really matter all that
> much what N is.  10 seems a reasonable default as any.

That's exactly the problem. Most git users aren't going to expect "git =
=20
rebase -i" to let you "rebase the last few commits".

Rebase is mostly used, talked about, and conceptualized in terms of =20
rebasing onto other _branches_.

Cheers,
Wincent
