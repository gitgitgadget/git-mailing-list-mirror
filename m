From: =?iso-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Mon, 05 Sep 2005 18:28:45 +0200
Message-ID: <u5tk6hveawy.fsf@lysator.liu.se>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<u5tvf1feedt.fsf@lysator.liu.se>
	<Pine.LNX.4.58.0509050902070.3568@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Sep 05 18:33:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECJt3-0000Z5-VL
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 18:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVIEQbj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 5 Sep 2005 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVIEQbj
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 12:31:39 -0400
Received: from main.gmane.org ([80.91.229.2]:27623 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932330AbVIEQbi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 12:31:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ECJqK-0008Gh-Iy
	for git@vger.kernel.org; Mon, 05 Sep 2005 18:29:12 +0200
Received: from 212214120186-virtutech-ab.host.songnetworks.se ([212.214.120.186])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 18:29:12 +0200
Received: from davidk by 212214120186-virtutech-ab.host.songnetworks.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Sep 2005 18:29:12 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 212214120186-virtutech-ab.host.songnetworks.se
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:mO3athkwdUbRVsgFJ38z90KhexU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8101>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 5 Sep 2005, David K=E5gedal wrote:
>>=20
>> But to the users (like myself), there's no point in naming it by
>> whether it's a script or a binary.=20
>
> So? There's no downside.
>
> To you, as a user, you never see the "-script" ending anyway. You'd n=
ever=20
> type it out, or you're already doing something wrong.

Then I'm doing something wrong.  And I'm pretty sure others are
too. If I'm not supposed to see the "-script" ending, then don't
install it in my $PATH.

Until someone (possibly myself) writes some zsh completion code to
handle git sub command, I will continue to hit TAB and see all those
names.

=46urthermore, the man page for "git clone" is called
"git-clone-script(1)".  And the "-script" suffix appears inside the
documentation in various places.  I see it in howtos and log messages.
And the git-merge-one-file-script script is supposed to be used in a
way where I have to supply the long name.  Etc.

If the "-script" part is supposed to be hidden from me, why do I keep
seeing it everywhere I turn?

> So to users it doesn't matter, and to developers it _does_ matter (an=
d=20
> calling them ".pl" or ".sh" or something would be _bad_), why not ple=
ase=20
> the developers?

I'm not suggesting we'd call them ".pl" or ".sh".

--=20
David K=E5gedal
