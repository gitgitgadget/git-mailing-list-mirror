From: =?utf-8?b?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: Re: [PATCH 3/3] grep: add --heading
Date: Mon, 6 Jun 2011 12:26:17 +0000 (UTC)
Message-ID: <loom.20110606T141954-541@post.gmane.org>
References: <4DEB9F07.1070006@lsrfire.ath.cx> <4DEB9FB4.8020904@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 14:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTYt8-0002hI-7P
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 14:26:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756249Ab1FFM03 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 08:26:29 -0400
Received: from lo.gmane.org ([80.91.229.12]:38067 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755625Ab1FFM03 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 08:26:29 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QTYt2-0002eZ-79
	for git@vger.kernel.org; Mon, 06 Jun 2011 14:26:28 +0200
Received: from pc10.ivo.park.gdynia.pl ([153.19.128.10])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 14:26:28 +0200
Received: from michal.kiedrowicz by pc10.ivo.park.gdynia.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 14:26:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 153.19.128.10 (Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110510 Gentoo Firefox/3.6.17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175119>

Ren=C3=A9 Scharfe <rene.scharfe <at> lsrfire.ath.cx> writes:
>=20
> This option is taken from ack (http://betterthangrep.com/).  And now
> git grep can dress up like it:
>=20
> 	$ git config alias.ack "grep --break --heading --line-number"
>=20
> 	$ git ack -e --heading
> 	Documentation/git-grep.txt
> 	154:--heading::
> =09
> 	t/t7810-grep.sh
> 	785:test_expect_success 'grep --heading' '
> 	786:    git grep --heading -e char -e lo_w hello.c hello_world >actu=
al &&
> 	808:    git grep --break --heading -n --color \
>=20

Nice! I really missed that.

You can also add --perl-regexp (since 1.7.6-rc0) to alias.ack to achive=
 more
compability with ack (although it uses Perl regexes, not PCRE).
