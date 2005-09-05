From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 05 Sep 2005 17:13:50 +0200
Message-ID: <u5tvf1feedt.fsf@lysator.liu.se>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 05 17:19:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECIj4-0000Qy-DE
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 17:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbVIEPRV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Sep 2005 11:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbVIEPRV
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 11:17:21 -0400
Received: from main.gmane.org ([80.91.229.2]:50362 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932300AbVIEPRV (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 11:17:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ECIhS-000097-Fl
	for git@vger.kernel.org; Mon, 05 Sep 2005 17:15:58 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 17:15:58 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 17:15:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:ZhNc15aWL5Gt7Ou6XAeidxb9NYs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8095>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 4 Sep 2005, Horst von Brand wrote:
>> > I had the same opinion.  The counter-argument people raised when
>> > this topic came up on the list was that it would help grepping
>> > in the source tree.
>>=20
>> Grepping for what?
>
> Grepping for strings.
>
> For example, when renaming a binary, the sane way to check that you f=
ixed=20
> all users right now is
>
> 	grep old-binary-name *.c *.h *-scripts
>
> and you catch all users.
>
> In contrast, "grep *" will catch totally uninteresting patterns like=20
> object files etc.
>
> I personally find that very useful, and I don't see _any_ point to na=
ming=20
> by what _kind_ of interpreter you use. Why would _anybody_ care wheth=
er=20
> something is written in perl vs shell? There's no reason to name thin=
gs by=20
> the interpreter.

But to the users (like myself), there's no point in naming it by
whether it's a script or a binary.  Since, as a user, I couldn't care
less that git-foobar is a shell script, I don't want to pollute the
command name space with "-script" suffixes.  Calling the command
git-foobar makes much more sense, and allows us to reimplement the
scripts as binaries, or whatever.

So your argument that it makes it easier for git developers to work
with the source doesn't help the user.

The consequence is maybe that the scripts should be called *-script in
the source, but be installed without the suffix?

--=20
David K=E5gedal
