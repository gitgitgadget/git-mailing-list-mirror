From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH] Added test case for stg refresh
Date: Thu, 22 Nov 2007 09:38:26 +0100
Message-ID: <87pry2u131.fsf@lysator.liu.se>
References: <87tznfvqb4.fsf@lysator.liu.se> <87oddnvpzf.fsf@virtutech.se>
	<20071121231553.GA19422@diana.vm.bytemark.co.uk>
	<b0943d9e0711211531v2f7b9c0bl99033c0bd58971c7@mail.gmail.com>
	<871waivhgq.fsf@virtutech.se>
	<b0943d9e0711220015r64d1a5c2y25dfa44610864c99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl =?utf-8?Q?Hasselstr=C3=B6?= =?utf-8?Q?m?= 
	<kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 09:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv7a3-0000bn-0w
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 09:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbXKVIiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 03:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbXKVIiV
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 03:38:21 -0500
Received: from mail.lysator.liu.se ([130.236.254.3]:44926 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbXKVIiU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 03:38:20 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 4BAD7200A236;
	Thu, 22 Nov 2007 09:38:18 +0100 (CET)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 21548-01-68; Thu, 22 Nov 2007 09:38:18 +0100 (CET)
Received: from krank (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 0297A200A230;
	Thu, 22 Nov 2007 09:38:18 +0100 (CET)
Received: by krank (Postfix, from userid 1000)
	id 221D07B406A; Thu, 22 Nov 2007 09:38:26 +0100 (CET)
In-Reply-To: <b0943d9e0711220015r64d1a5c2y25dfa44610864c99@mail.gmail.com> (Catalin Marinas's message of "Thu\, 22 Nov 2007 08\:15\:57 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65756>

"Catalin Marinas" <catalin.marinas@gmail.com> writes:

> On 22/11/2007, David K=C3=A5gedal <davidk@lysator.liu.se> wrote:
>> "Catalin Marinas" <catalin.marinas@gmail.com> writes:
>> > I noticed the weirdness few days ago and fixed it in
>> > e8813959aa3a7c41ffef61d06068b10519bd4830 (though no test caught it=
).
>> > Do you still see problems after this commit?
>>
>> The problem I see is that there still is no test case. That is bad a=
nd
>> means that it could break again tomorrow without anyone noticing.
>>
>> Luckily, I just wrote one for you :-)
>
> Thanks :-). We are still far from testing all the possible
> combinations. Is there a way to do code coverage in Python?

Being far from testing everything doesn't mean that you can't start
adding tests for the things you know have a tendency to break. And for
the things that you are going to refactor. And as regression tests
when you fix a bug. A test suite can be built up by adding small parts
at a time.

But no, I don't know of any useful code coverage tool for python, but
I haven't really looked.

--=20
David K=C3=A5gedal
