From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Re* [RFC/PATCH] extend meaning of "--root" option to index comparisons
Date: Sun, 21 Sep 2008 19:04:08 +0200
Organization: At home
Message-ID: <gb5uq6$565$1@ger.gmane.org>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com> <bd6139dc0809151411p49f5adeaq4beff452574ca980@mail.gmail.com> <20080915223442.GD20677@sigill.intra.peff.net> <bd6139dc0809152319m31a79877h5dc1b701a8210802@mail.gmail.com> <20080916062105.GA12708@coredump.intra.peff.net> <20080918092152.GA18732@coredump.intra.peff.net> <3665a1a00809180931t191b5a24wd58554cdb761535@mail.gmail.com> <20080919142537.GA1287@coredump.intra.peff.net> <7vskrvswxp.fsf@gitster.siamese.dyndns.org> <20080921135616.GA25238@sigill.intra.peff.net> <3665a1a00809210858r1c494d22p77b5e9964c06424e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 19:10:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhSS2-0004B8-JF
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 19:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbYIUREQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2008 13:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbYIUREQ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 13:04:16 -0400
Received: from main.gmane.org ([80.91.229.2]:43615 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751721AbYIUREP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 13:04:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KhSM1-0000g1-Is
	for git@vger.kernel.org; Sun, 21 Sep 2008 17:04:13 +0000
Received: from abvi218.neoplus.adsl.tpnet.pl ([83.8.206.218])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 17:04:13 +0000
Received: from jnareb by abvi218.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 17:04:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvi218.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96412>

Anatol Pomozov wrote:

> What about following algorithm. HEAD points to ref and ref is not
> created yet. Additional check could be
> =A0a) there are no other refs
> =A0or/and b) object database is empty

What about the case when you create _independent_ branch (additional
root, i.e. parentless commit), like 'html', 'man' and 'todo' branches
in git.git repository?  Neither a) nor b) applies, and I don't consider
such situation a bug.  HEAD should be in proper symref format:
"ref: refs/heads/<branchname>".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
