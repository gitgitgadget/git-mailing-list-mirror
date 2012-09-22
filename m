From: Sascha Cunz <sascha-ml@babbelbox.org>
Subject: Message from 'git-rebase'; German translation
Date: Sat, 22 Sep 2012 23:57:49 +0200
Message-ID: <1527028.GPe6zkelBV@blacky>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 00:04:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFXoX-0002cp-Jy
	for gcvg-git-2@plane.gmane.org; Sun, 23 Sep 2012 00:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408Ab2IVWEc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Sep 2012 18:04:32 -0400
Received: from babbelbox.org ([83.133.105.186]:53237 "EHLO mail.babbelbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2IVWEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Sep 2012 18:04:32 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Sep 2012 18:04:31 EDT
Received: (qmail 14883 invoked from network); 22 Sep 2012 21:58:22 -0000
Received: from p54aece43.dip.t-dialin.net (HELO blacky.localnet) (sascha@babbelbox.org@84.174.206.67)
  by babbelbox.org with ESMTPA; 22 Sep 2012 21:58:22 -0000
User-Agent: KMail/4.9.1 (Linux/3.5.3-gentoo; KDE/4.9.1; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206216>

As I know how hard translations can be, esp. with that much technical t=
erms=20
inside, I'm usually expecting _not_ to yield the same result when trans=
lating=20
a software's translation back to English.

However, git-rebase just threw these two sentences at me (And though i =
know=20
their meaning, i couldn't get the meaning from the message, it gave). B=
oth are=20
in context of starting a rebase while one is already in progress.

first is:

Original:
=2E.. and I wonder if you are in the middle of another rebase.

German git translation:
=2E.. und es w=E4re verwunderlich, wenn ein Neuaufbau bereits im Gange =
ist.

And a re-translation back to English from my understanding as native Ge=
rman=20
speaker:
=2E.. and it would be astonishing (=3Di'd be surprised), if a rebase wa=
s already=20
in progress.

And second:

Original:
I am stopping in case you still have something valuable there.

German git translation:
Es wird angehalten, falls bereits etwas N=FCtzliches vorhanden ist.

I wanted to point out that "etwas N=FCtzliches" is more "something usef=
ul" that=20
"something valuable". But the more I thought about it, the more it star=
ted to=20
confuse me (even the original text) - and now I feel like I don't under=
stand=20
the meaning of the last sentence at all; neither in English nor in the =
German=20
translation:
After removing the directory with all rebase-information inside it, WHE=
RE=20
should something valuable still be left over? Is it referring to my wor=
king=20
tree?

So, for completeness, the full English message:

	It seems that there is already a rebase-merge directory, and
	I wonder if you are in the middle of another rebase.  If that is the
	case, please try
     	   git rebase (--continue | --abort | --skip)
	If that is not the case, please
	        rm -fr "/work/lg2/src/.git/rebase-merge"
	and run me again.  I am stopping in case you still have something
	valuable there.

Sascha
