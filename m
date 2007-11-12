From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deprecate git-fetch-pack?
Date: Mon, 12 Nov 2007 01:16:13 +0100
Organization: At home
Message-ID: <fh8609$umn$1@ger.gmane.org>
References: <Pine.LNX.4.64.0711101752490.29952@iabervon.org> <7v4pftip42.fsf@gitster.siamese.dyndns.org> <74415967-7F49-426C-8BF5-1A0210C337AB@develooper.com> <Pine.LNX.4.64.0711111103240.4362@racer.site> <7vd4ugcwkm.fsf@gitster.siamese.dyndns.org> <20071111222117.GA7392@thunk.org> <7vabpkbebj.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711112247350.4362@racer.site> <20071111235819.GB7392@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 01:16:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrMyr-00048O-Q6
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 01:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbXKLAQa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 19:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755601AbXKLAQa
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 19:16:30 -0500
Received: from main.gmane.org ([80.91.229.2]:39773 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752748AbXKLAQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 19:16:29 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrMyW-0005dT-38
	for git@vger.kernel.org; Mon, 12 Nov 2007 00:16:24 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 00:16:24 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 00:16:24 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64538>

Theodore Tso wrote:

> 2) The command which are displayed by "git help" should use some
> serious rethinking. =A0Ideally, it would be nice if the output fit in=
 a
> single 24-line terminal window. =A0 Some candidates for removal:
>=20
> =A0 =A0 =A0 =A0a) prune: "git prune" definitely doesn't deserve to be=
 on the
> =A0 =A0 =A0 =A0front and center as displayed by "git help". =A0Maybe =
replace it
> =A0 =A0 =A0 =A0with "gc", but now that we have gc.auto, I'm not sure =
it's
> =A0 =A0 =A0 =A0worth it at all.

I would replace it by "git gc" (you have to run 'git gc --prune' by han=
d
on quiescent repository), or remove it altogether.

> =A0 =A0 =A0 =A0b) revert: =A0Is that really that common of a command?

It is useful command, perhaps short description should be improved.
BTW. if we have cherry-pick, then we should have revert.

> =A0 =A0 =A0 =A0c) show-branch: The output is terrifying without expla=
nation

I agree. I would replace it by gitk, or gui (git-gui / "git gui").

> There are other commands I'm not so sure about, but it is worth
> flagging them. =A0One way that might be helpful is to group the comma=
nds
> into subcommands, much like gdb does, so you could do something like
> "git help other-repos" (where all commands that involve interacting
> with other repositories are summarized), and so on.

I think that "git-rm" could be removed, because "rm <file>; git commit =
=2E.."
works just fine.

See also discussion about results of Git User's Survey 2007, somewhere
around
  http://thread.gmane.org/gmane.comp.version-control.git/59935/focus=3D=
62205

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
