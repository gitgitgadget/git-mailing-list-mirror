From: Vitali Lovich <vlovich@gmail.com>
Subject: Re: --progress option for git submodule update?
Date: Wed, 09 Sep 2015 20:06:03 -0700
Message-ID: <68DDAE70-85F2-4873-BDBD-373985A49815@gmail.com>
References: <88E7FC00-9A87-4E20-89D8-4BF5997F7B07@gmail.com>
 <CAGZ79kYRYqVE35_i5+DvqOj7G6LvhBQgsQok5gabLY6x20F80w@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3083\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 05:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZsBh-0003KI-MD
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 05:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbIJDGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Sep 2015 23:06:06 -0400
Received: from mail-out7.apple.com ([17.151.62.29]:46822 "EHLO
	mail-in7.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752438AbbIJDGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Sep 2015 23:06:05 -0400
Received: from relay6.apple.com (relay6.apple.com [17.128.113.90])
	by mail-in7.apple.com (Apple Secure Mail Relay) with SMTP id 95.2E.24122.C93F0F55; Wed,  9 Sep 2015 20:06:04 -0700 (PDT)
X-AuditID: 11973e16-f79826d000005e3a-1a-55f0f39c67a3
Received: from marigold.apple.com (marigold.apple.com [17.128.115.132])
	(using TLS with cipher RC4-MD5 (128/128 bits))
	(Client did not present a certificate)
	by relay6.apple.com (Apple SCV relay) with SMTP id 09.AF.22881.B93F0F55; Wed,  9 Sep 2015 20:06:04 -0700 (PDT)
Received: from vldesktop.apple.com ([17.214.197.172])
 by marigold.apple.com (Oracle Communications Messaging Server 7.0.5.30.0 64bit
 (built Oct 22 2013)) with ESMTPSA id <0NUF002QCXY30T60@marigold.apple.com> for
 git@vger.kernel.org; Wed, 09 Sep 2015 20:06:03 -0700 (PDT)
In-reply-to: <CAGZ79kYRYqVE35_i5+DvqOj7G6LvhBQgsQok5gabLY6x20F80w@mail.gmail.com>
X-Mailer: Apple Mail (2.3083)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsUi2FAYpTvn84dQg6d/WC26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXx5/JM9oImqYr5D3pZGxifinQxcnJICJhI3Fv4gRXCFpO4cG89
	G4gtJLCXUaLrXiBMzaJF/UxdjFxA8UlMEhfm3YVypjBJPP+8HaxDWEBCYuWNw+xdjBwczALq
	ElOm5IKEeQX0JJo3TmCHKLGQOL7pODOIzQZU8qV1Jlg5p0CwxLmVISBhFgFViZVHz4JNZBbQ
	l/jQ3wRla0s8eXeBFWKkjcTdw3/ZIE5oBrrzeQ9YkYiAmsTMVbPZQGZKCMhKTNsWD1IjITCH
	TeLXkj+sExhFZiFcNwvJdbOQrFjAyLyKUSg3MTNHNzPPXC+xoCAnVS85P3cTIyiwp9uJ7WB8
	uMrqEKMAB6MSD2/CxQ+hQqyJZcWVuYcYpTlYlMR5v5QDhQTSE0tSs1NTC1KL4otKc1KLDzEy
	cXBKNTCy132//WVGk++xWYFhPUtlcjqu3Jc6/qVZWoS9/0udZfoFX73nqa2d2kVLvW/b3ORx
	LDlu3qTx8LnVks7196/VZa9mtdsd1OkW0ZL1SOhifV/j0XlL2D0i5W7vTH4gbhC45+/bmKv+
	Ks8nsfEk71ePEbwy7db8Y6uKDnfnTta835XlZMYqJqjEUpyRaKjFXFScCACBLZv2TQIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsUi2FDcojvn84dQgz87GS26rnQzOTB6fN4k
	F8AYxWWTkpqTWZZapG+XwJXx5/JM9oImqYr5D3pZGxifinQxcnJICJhILFrUzwRhi0lcuLee
	rYuRi0NIYBKTxIV5d5kgnClMEs8/b2cDqRIWkJBYeeMwexcjBwezgLrElCm5IGFeAT2J5o0T
	2CFKLCSObzrODGKzAZV8aZ0JVs4pECxxbmUISJhFQFVi5dGzYBOZBfQlPvQ3QdnaEk/eXWCF
	GGkjcffwX6h7mhklup73gBWJCKhJzFw1mw1kpoSArMS0bfETGAVnIRw0C8lBs5BMXcDIvIpR
	oCg1J7HSTC+xoCAnVS85P3cTIzgUC6N2MDYstzrEKMDBqMTDm3DxQ6gQa2JZcWXuIUYJDmYl
	Ed607UAh3pTEyqrUovz4otKc1OJDjMlAv0xklhJNzgfGSV5JvKGJiYGJsbGZsbG5iTlpwkri
	vA0ir0KFBNITS1KzU1MLUotgtjBxcEo1MPpJ7+dYbHNW0Ou1StWpqre3333viJi2/blC5EQn
	gwvtG3Jlf04QNrurqn+zQ7Zy+o4A5bV+qflzHvK++pH+xl+aZae1/arDwoweZyI9yhbIX5to
	cySYYf+bAm6Tvsnptt9Er6q3VLuzTLPo+2z8h00w4sdGOROeD82L3zloMqoGFLtb89TzKrEU
	ZyQaajEXFScCAEsw/B6JAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277572>


> On Sep 9, 2015, at 4:40 PM, Stefan Beller <sbeller@google.com> wrote:
>=20
> So submodules...
>=20
> I am currently working on improving submodules (some basic performanc=
e
> improvements have been done, soon to be merged upstream, I currently
> try to get parallelism working for git fetch --recurse-submodules and=
 for
> git submodule update eventually. I sent some early working patches fo=
r that,
> but I am doing a whole new redesign without threads now).
That sounds exciting.  Can=E2=80=99t wait.

> On Wed, Sep 9, 2015 at 3:52 PM, Vitali Lovich <vlovich@gmail.com> wro=
te:
>> Hi,
>>=20
>> Git submodule doesn=E2=80=99t have a --progress option like regular =
clone/fetch does.  This means that it can hang a long time without outp=
ut as it=E2=80=99s transferring data, particularly for large repositori=
es.
>=20
> For repositories with nested submodules it is impossible to estimate
> the progress because you don't know how many there are.
> Say you have a layout like:
>=20
> A
> -> B
> -> C
> -> D
>    -> E
>    -> F
>=20
> whereas each letter is a repository and B,C,D are submodules of A and
> E,F are submodules of D.
> So if D is not cloned yet, it looks like A has only 3 submodules, but
> in fact we need to update 5
> submodules.
I don=E2=80=99t think I=E2=80=99m asking for an overall --progress.  As=
 you point out that is very difficult/an intractable problem.  I was th=
inking it would just report the progress for each submodule it encounte=
rs as it fetches/clones.
The added benefit to that is that if there=E2=80=99s a lot of submodule=
s, an overall progress might get stuck at a long time at a given percen=
tage whereas it=E2=80=99s less likely cloning just a single module woul=
d depending on the size of repositories.

>> This is problematic in automation scenarios where there can be upper=
-bounds on how long a process may run without any output (to protect ag=
ainst processes hanging for long periods of time without forward progre=
ss).
>=20
> Maybe a better error-out-if-hanging would be better IMHO ?
> Another option would be to enumerate the submodules and give the
> currently estimated upper bound ?
That=E2=80=99s much more difficult & I=E2=80=99m still left with the or=
iginal problem where I have to set a very conservative upper-bound whic=
h wastes valuable machine time & causes extra contention for automation=
 resources.

> Doh! I see what you're missing now after rereading the email closely.
> You can add a --quiet option,
> but --verbose or --progress just errors out, but you want that as a
> possible argument for git clone
> inside the git submodule update code.
Yes exactly.

>=20
> Thanks,
> Stefan
>=20
>>=20
>> I=E2=80=99m sure this has been asked for before but having this opti=
on would be really nice for automation system (like buildbot) to take a=
dvantage of.  The only alternative is a hacky solution to clone locally=
 first with the =E2=80=94progress option
>> & then somehow set up the submodule to use the local clone as a refe=
rence.
>>=20
>> Thanks,
>> Vitali--
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
