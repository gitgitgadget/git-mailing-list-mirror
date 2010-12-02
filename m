From: =?utf-8?b?Wm9sdMOhbg==?= =?utf-8?b?RsO8emVzaQ==?= 
	<zfuzesi@eaglet.hu>
Subject: Re: msysgit clone/pull/fetch broken
Date: Thu, 2 Dec 2010 07:28:35 +0000 (UTC)
Message-ID: <loom.20101202T081807-557@post.gmane.org>
References: <loom.20101201T141924-761@post.gmane.org> <AANLkTinaxO1FVb-MvY91mscUcpNtbxQH0vTvE4YJrJtB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 02 08:28:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO3b8-0007Mc-67
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 08:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756392Ab0LBH2v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 02:28:51 -0500
Received: from lo.gmane.org ([80.91.229.12]:45754 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755663Ab0LBH2u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 02:28:50 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PO3az-0007Kj-Hd
	for git@vger.kernel.org; Thu, 02 Dec 2010 08:28:49 +0100
Received: from catv-80-99-94-142.catv.broadband.hu ([80.99.94.142])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 08:28:49 +0100
Received: from zfuzesi by catv-80-99-94-142.catv.broadband.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 08:28:49 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.99.94.142 (Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US) AppleWebKit/534.10 (KHTML, like Gecko) Chrome/8.0.552.210 Safari/534.10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162680>

Erik Faye-Lund <kusmabite <at> gmail.com> writes:

>=20
> On Wed, Dec 1, 2010 at 2:31 PM, Zolt=C3=A1nF=C3=BCzesi <zfuzesi <at> =
eaglet.hu> wrote:
> > Hi, I can't clone/pull/fetch from any of my repositories with the l=
atest=20
stable
> > version (1.7.3.2.430.g208247) on Windows.
> >
> > $ git clone --recursive git://server/user/project.git
> > Cloning into project...
> > fatal: failed to read object <sha1>: No error
> >
> > After reverting commit 3ba7a065527a27f45659398e882feaa1165cbb4c ("A=
 loose=20
object
> > is not corrupt if it cannot be read due to EMFILE") it works.
> >
> > On Linux everything is fine.
>=20
> I've already submitted a patch-series that address this issue:
> <1290533444-3404-1-git-send-email-kusmabite <at> gmail.com>
>=20

Thanks! Could you give me the sha1(s) of those patches? I've found some=
 of your=20
recent patches, but they have already been merged into master.
