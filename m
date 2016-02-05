From: =?utf-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
Subject: Re: Clarification on the git+ssh and ssh+git schemes
Date: Fri, 5 Feb 2016 15:59:54 -0800
Message-ID: <DC6DF4A9-2BB4-432F-9893-39523E47A10B@dwim.me>
References: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me> <20160205193027.GC7245@sigill.intra.peff.net> <CA+55aFyWqK0bu2V1SYagrYCBGpj0=2orobK2vT-KRkqpq=kgtw@mail.gmail.com> <xmqq1t8qdcyf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 01:00:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRqIH-0008EU-UZ
	for gcvg-git-2@plane.gmane.org; Sat, 06 Feb 2016 01:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbcBFAAA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 19:00:00 -0500
Received: from hessy.dwim.me ([78.47.67.53]:35878 "EHLO hessy.dwim.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750699AbcBEX77 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2016 18:59:59 -0500
Received: from [172.31.25.155] (GITHUB-INC.bar1.SanFrancisco1.Level3.net [4.53.133.38])
	by hessy.dwim.me (Postfix) with ESMTPSA id ADE428153D;
	Sat,  6 Feb 2016 00:59:56 +0100 (CET)
In-Reply-To: <xmqq1t8qdcyf.fsf@gitster.mtv.corp.google.com>
X-Mailer: Apple Mail (2.3112)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285654>


> On 05 Feb 2016, at 14:11, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
>> On Fri, Feb 5, 2016 at 11:30 AM, Jeff King <peff@peff.net> wrote:
>>>=20
>>> I suspect they were not really documented because nobody wanted to
>>> encourage their use. I don't think it would be wrong to document th=
at
>>> they exist and are deprecated, though.
>>=20
>> They exist because some people seemed to think that people shouldn't
>> use "ssh://" since they thought that only ssh should use that.
>>=20
>> Which is obviously bullshit, since by that logic all the other forma=
ts
>> should have that idiotic "git+" format too ("git+https", anybody?). =
It
>> doesn't actually help anything, and it only pushes somebodys broken
>> agenda.
>>=20
>> So there was a push for that silly thing by a couple of people, but =
it
>> was always wrong. Don't even document it.
>=20
> [=E2=80=A6]
>=20
>> Leave it in the source code as an option, and maybe add a comment
>> about "This is stupid, but we support it for hysterical raisins".
>=20
> Sounds good.

OK then, let=E2=80=99s remove the reference from the manpage.

As peff guessed, this query is indeed triggered by having to make a dec=
ision about whether libgit2 should support them. I suppose we=E2=80=99l=
l have to go in a similar direction. Support them because people are us=
ing them (which is why a user brought it up) but leave a comment that w=
e don=E2=80=99t like it.

Cheers,
   can