From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sun, 08 Sep 2013 17:21:23 +0200
Message-ID: <522C95F3.5030308@web.de>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com> <1377899810-1818-7-git-send-email-felipe.contreras@gmail.com> <xmqq38pqwlyl.fsf@gitster.dls.corp.google.com> <5221A510.2020206@web.de> <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com> <5221B324.7020908@web.de> <CAMP44s0et9_e5XH-4aydrM-i_+ORampdsitJzK-rSj+4dwPUKw@mail.gmail.com> <5221C533.1070109@web.de> <CAMP44s39X2SsZC7f6=j=CX+9wky7YpiJUz3itCiqeLScD0TbNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 08 17:21:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIgo7-0004L1-2m
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 17:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753030Ab3IHPVm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Sep 2013 11:21:42 -0400
Received: from mout.web.de ([212.227.17.11]:50678 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab3IHPVm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 11:21:42 -0400
Received: from [192.168.2.102] ([79.253.173.109]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MddFQ-1VbRcG2FDA-00PNWb for <git@vger.kernel.org>;
 Sun, 08 Sep 2013 17:21:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <CAMP44s39X2SsZC7f6=j=CX+9wky7YpiJUz3itCiqeLScD0TbNA@mail.gmail.com>
X-Provags-ID: V03:K0:pSqiupKyJFvKbogJLIliVfR45JPncWCo3IqrWMtdnMNXMi+8rT4
 U1C387Gzc6lAMRH9vrmtrMpXfKFpkpH3nFHOdfFHZsFJJfhiAIbBvHYGN7eR3QXo+FwDXfU
 Z5alfbpsiRHedzrKIxg2sa1uJoIZb9U88Kg4+RF99xhKmYG5NJY0u2J2qSllY+xR0ys2UmL
 vs28HQu05EO+f4/dZlczw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234251>

Am 31.08.2013 19:20, schrieb Felipe Contreras:
> A summary should contain as much information that would allow me to
> skip the commit message as possible.
>
> If I can't tell from the summary if I can safely skip the commit
> message, the summary is not doing a good job.
>
> "trivial simplification" explains the "what", and the "why" at the
> same time, and allows most people to skip the commit message, thus is
> a good summary.

No patch should be skipped on the mailing list.  As you wrote, trivial=20
patches can still be wrong.

When going through the history I can see that quickly recognizing=20
insubstantial changes is useful, but if I see a summary twice then in m=
y=20
mind forms a big question mark -- why did the same thing had to be done=
=20
yet again?

As an example, both 0d12e59f (pull: replace unnecessary sed invocation)=
=20
and bc2bbc45 (pull, rebase: simplify to use die()) could arguably have=20
had the summary "trivial simplification", but I'm glad the author went=20
with something a bit more specific.

I agree that some kind of tagging with keywords like "trivial", "typo"=20
and so on can be helpful, though.

> Again, triviality and correctness are two separate different things.
> The patch is trivial even if you can't judge it's correctness.

Well, in terms of impact I agree.

> To me, what you are describing is an obvious patch, not a trivial one=
=2E
> An obvious patch is so obvious that you can judge it's correctness
> easily by looking at the diff, a trivial one is of little importance.

That's one definition; I think I had the mathematical notion in mind=20
that calls proofs trivial which are immediately evident.

Ren=C3=A9
