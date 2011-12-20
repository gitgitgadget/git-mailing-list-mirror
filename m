From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/2] Documentation: make git-sh-setup docs less scary
Date: Tue, 20 Dec 2011 21:27:44 +0100
Message-ID: <87bor3ounz.fsf@thomas.inf.ethz.ch>
References: <c53feb0de8006c205fd26c2c07dcd78bd86b6c24.1324378986.git.trast@student.ethz.ch>
	<c8867738c264a76f9662080b64e00615ec1aa28f.1324378986.git.trast@student.ethz.ch>
	<CACBZZX5BSfh8S9Kf1Wbi+NPEKpxJNXU8TD8-hkC2o1Mi91Or6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 21:27:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rd6Hz-0007xo-Tx
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 21:27:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621Ab1LTU1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Dec 2011 15:27:52 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:25738 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751411Ab1LTU1v convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Dec 2011 15:27:51 -0500
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 21:27:47 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.211.99) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 20 Dec
 2011 21:27:47 +0100
In-Reply-To: <CACBZZX5BSfh8S9Kf1Wbi+NPEKpxJNXU8TD8-hkC2o1Mi91Or6A@mail.gmail.com>
	(=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Dec
 2011 20:45:05
	+0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.211.99]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187524>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> On Tue, Dec 20, 2011 at 12:09, Thomas Rast <trast@student.ethz.ch> wr=
ote:
>> At least one IRC user was scared away by the introductory "This is n=
ot
>> a command the end user would want to run. =C2=A0Ever." to the point =
of not
>> reading on.
>
> Arguably that's the point isn't it? To not have people who aren't
> maintaining Git itself waste time on reading it.

Junio C Hamano writes:
> You would need to say what that IRC user needed to find out. Dependin=
g on
> that, letting the user know that there is no point reading on early a=
nd
> not waste his or her time may be a good thing. That was what the para=
graph
> was designed for. IOW, it is not to "scare" away, but to allow the us=
ers
> to decide if they are intended audiences.

Well, the original question was [*]

  <ribasushi> how do I write a batch-test (goes in a script, exit value=
 matters only) to test if the current workdir is clean?
  <ribasushi> i.e. nothing staged/unstaged to commit
  <shruggar> last I looked, there was no "all in one" method :/
  <shruggar> git diff -q && git diff =E2=80=94cached -q, perhaps
  <charon> ribasushi: . "$(git --exec-path)/git-sh-setup" ; require_cle=
an_worktree
  <shruggar> but I think that's ignoring something
  <ribasushi> lack of output of `git status -s` seems to be what I want
  <ribasushi> hmmm
  <ribasushi> charon: git-gh-setup's manpage does not seem to list what=
 you gave me
  <ribasushi> and the manpage says that I should not be touching it...

Leaving aside my worktree vs. work_tree mistake, he concluded that he
should not be using it even though he is a script writer.

Regardless, I don't really care enough about this one; let's just do th=
e
first patch (v2 upcoming) so that we have documentation to point people
at.


[*] http://colabti.org/irclogger/irclogger_log/git?date=3D2011-12-20#l1=
284

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
