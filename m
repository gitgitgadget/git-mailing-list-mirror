From: Ted Zlatanov <tzz@lifelogs.com>
Subject: encrypted netrc for Git (was: [Wishlist] could git tell which password it is asking when asking a password.)
Date: Thu, 14 Jul 2011 09:05:50 -0500
Organization: =?utf-8?B?0KLQtdC+0LTQvtGAINCX0LvQsNGC0LDQvdC+0LI=?= @
 Cienfuegos
Message-ID: <87bowxt0sh.fsf_-_@lifelogs.com>
References: <877h82nlua.dlv@debian.org> <87aacygcfx.fsf@lifelogs.com>
Reply-To: git@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 16:06:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhMYT-0002zs-7x
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 16:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755184Ab1GNOGM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jul 2011 10:06:12 -0400
Received: from lo.gmane.org ([80.91.229.12]:34693 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755149Ab1GNOGL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 10:06:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QhMYI-0002qS-FH
	for git@vger.kernel.org; Thu, 14 Jul 2011 16:06:06 +0200
Received: from 38.98.147.133 ([38.98.147.133])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 16:06:06 +0200
Received: from tzz by 38.98.147.133 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 Jul 2011 16:06:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: git@vger.kernel.org
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 38.98.147.133
X-Face: bd.DQ~'29fIs`T_%O%C\g%6jW)yi[zuz6;d4V0`@y-~$#3P_Ng{@m+e4o<4P'#(_GJQ%TT= D}[Ep*b!\e,fBZ'j_+#"Ps?s2!4H2-Y"sx"
Mail-Copies-To: never
User-Agent: Gnus/5.110018 (No Gnus v0.18) Emacs/24.0.50 (gnu/linux)
Cancel-Lock: sha1:ed0V0ImIojJlN0TPKjCCJoTjS10=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177130>

On Fri, 01 Jul 2011 12:04:02 -0500 Ted Zlatanov <tzz@lifelogs.com> wrot=
e:=20

TZ> On Fri, 01 Jul 2011 15:59:09 +0200 R=E9mi Vanicat <vanicat@debian.o=
rg> wrote:=20

RV> It would be interesting also to plug some sort of password-safe unt=
o
RV> git, or some "git-agent".=20

TZ> This would also be really nice.  ~/.netrc is not a great place to p=
ut
TZ> passwords for the HTTP transport.  In GNU Emacs we have ~/.authinfo=
=2Egpg
TZ> with the same content as ~/.netrc but encrypted by GPG and thus mor=
e
TZ> secure (the user is either prompted for the password, if the file i=
s
TZ> encrypted symmetrically, or the user simply loads their private key=
 into
TZ> the GPG agent).  I believe all this can be done with the GPGME libr=
ary.
TZ> There's also the Secrets API on newer Gnome and KDE installs, which=
 has
TZ> a pretty nice D-Bus interface.

TZ> But is this a libcurl feature request?  Or can a Git plugin (an
TZ> alternate HTTPS transport maybe?) handle it?

Ping?  I'd like to work on this if it seems like a feasible feature.

Thanks
Ted
