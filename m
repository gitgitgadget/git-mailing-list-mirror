From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 3/3] rebase: new convenient option to edit a single commit
Date: Tue, 04 Mar 2014 09:59:45 +0100
Message-ID: <53159601.8020702@alum.mit.edu>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <1393728794-29566-1-git-send-email-pclouds@gmail.com> <1393728794-29566-4-git-send-email-pclouds@gmail.com> <CAPig+cTn-YcWHsGRKUZWqACJ5ZspWoB+f4i7hNj09_4Ci6odiw@mail.gmail.com> <CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 10:00:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKlCg-0000rn-Bg
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 09:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460AbaCDI7y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 03:59:54 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:43717 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756216AbaCDI7x (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 03:59:53 -0500
X-AuditID: 1207440d-f79d86d0000043db-a0-53159608013f
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 97.C2.17371.80695135; Tue,  4 Mar 2014 03:59:52 -0500 (EST)
Received: from [192.168.69.148] (p57A2482C.dip0.t-ipconnect.de [87.162.72.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s248xmaY000695
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 4 Mar 2014 03:59:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CACsJy8Ct41PRb=_Ez7FLXbdiZkTU-tFYqtAxow9mCw7wYAfOhg@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHfe69264vtx7vpntaZjQooZqVCQ2J6kPW8IOkQ4gg1tXdtuF2
	Z/duptKLZi/LFzDzdZGIVoKlxkIxrIQJDS0js0CIiR/KcOmHWpCMou51+PLtz/n/z/lxOIfE
	ab9MQ9o4F8tzjF0rjyNoxfEdOrIlybh/ykvpaz7WYvoP4QGZvrZpCeiXr9fh+tvN2/RvF6vA
	MbnhuTeoMNz5FZAZeh72A8N8/Qtg6J7LMYR9qafkZ+IPFzKuUqPNwu07ci7eujQ2Jit5isoi
	wXFFJfAoa0AsiWAmmp9ZIKI6Gb2fHZDXgDiShtMA/V5elEsGDScxFPAVSJqCe1DkW5+iBpAk
	AXeivgaFVJZDHeqqq8YknQSN6PH0HBGNJ6Lx9i8rWgW1aNEzhEvzcfgGoE7PCCHNUcJc1Hct
	PcodwtDsQttKQyzMQ73hMCZlEFSjuqp8SeIwDQ100FICh9tR9eA9vAEkejfQvOsp74ZUJ8B7
	QSpjdzt0DsZmF9ginVDEcBzL6zLSHTZXOmt2+0D0BtQw+Nef4geQBNoEqq1FZaRlTKlQ7vCD
	LSSmTaICTUlGelOh01xuZQSriXfbWcEPEIlrVVToruhRZqa8guWdq9ZWktCqqV0P0nJpaGFc
	bDHLlrD8qptCklpEORvExkSetbBl521217qNkbHS8DiNSmA5M8szbpfVJF3XJIjnlawEkRvT
	LHGFEsYhVqOtE0BHfr4Z+QlognNyrEZNqSQGlEJWN7eGWH29EFCLGyupv9J6CeJjrk0KiRBM
	hMSvLCe4mHVLUwk6jMFLdRbfUKxx88LwSGmM52Dm5cLx0SuNlvqZQ6YLQsbRwWfJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243330>

On 03/04/2014 03:08 AM, Duy Nguyen wrote:
> On Tue, Mar 4, 2014 at 3:28 AM, Eric Sunshine <sunshine@sunshineco.co=
m> wrote:
>> On Sat, Mar 1, 2014 at 9:53 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>>> "git rebase -e XYZ" is basically the same as
>>>
>>> EDITOR=3D"sed -i '1s/pick XYZ/edit XYZ/' $@" \
>>> git rebase -i XYZ^
>>>
>>> In English, it prepares the todo list for you to edit only commit X=
YZ
>>> to save your time. The time saving is only significant when you edi=
t a
>>> lot of commits separately.
>>
>> Is it correct to single out only "edit" for special treatment? If
>> allowing "edit" on the command-line, then shouldn't command-line
>> "reword" also be supported? I, for one, often need to reword a commi=
t
>> message (or two or three); far more frequently than I need to edit a
>> commit.
>>
>> (This is a genuine question about perceived favoritism of "edit", as
>> opposed to a request to further bloat the interface.)
>=20
> Heh I had the same thought yesterday. The same thing could be asked
> for "git commit --fixup" to send us back to the fixed up commit so we
> can do something about it. If we go along that line, then "git commit=
"
> may be a better interface to reword older commits..

I disagree.  "git commit --fixup" doesn't rewrite history.  It just add=
s
a new commit with a special commit message that will make it easier to
rewrite history later.  I think it would be prudent to keep the
history-rewriting functionality segregated in "git rebase", which users
already know they have to use with care [1].

But the next question is whether "git rebase" should have shortcuts for
*most* of its line commands.  All of the following seem to make sense:

    git rebase --edit COMMIT

        A long-form for the -e option we have been talking about.
        It is unfortunately that this spelling sounds like the
        "--edit" option on "git commit --edit" and "git merge --edit",
        so people might use it when they really mean
        "git rebase --reword COMMIT".

    git rebase --reword COMMIT
    git rebase --fixup COMMIT
    git rebase --squash COMMIT

    git rebase --kill COMMIT

        Remove the commit from history, like running "git rebase
        --interactive" then deleting that line.

I'm quite confident that I would use all of these commands.

Moreover, it would logically be reasonable to allow multiple of these
options, at least as long as they have distinct COMMIT arguments.
Though, as Duy points out, it might in practice be easier to edit the
todo list in an editor rather than trying to do multiple "edits" at a
time via the command line.

Some thought would have to go into the question of if/how these command=
s
should interact with "git rebase --autosquash" (which, don't forget, ca=
n
also be requested via rebase.autosquash).

Michael

[1] OK, granted, there is "git commit --amend", which rewrites history
too.  But it rewrites only the last commit, which is less likely to be
problematic.

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
