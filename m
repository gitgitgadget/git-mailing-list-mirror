From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Wed, 16 Apr 2008 18:47:58 +0200
Organization: At home
Message-ID: <fu5ajm$eaq$1@ger.gmane.org>
References: <200804161334.17748.brian.foster@innova-card.com> <a537dd660804160448w5ba28f13m8c081ebc2a71db91@mail.gmail.com> <4805FD7C.5000206@viscovery.net> <20080416142551.GB3133@dpotapov.dyndns.org> <48061388.6090705@viscovery.net> <20080416161742.GC3133@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 16 19:17:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmAoX-0003oh-BG
	for gcvg-git-2@gmane.org; Wed, 16 Apr 2008 18:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765090AbYDPQsI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Apr 2008 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764990AbYDPQsH
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Apr 2008 12:48:07 -0400
Received: from main.gmane.org ([80.91.229.2]:52052 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764867AbYDPQsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2008 12:48:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JmAni-0008HW-4T
	for git@vger.kernel.org; Wed, 16 Apr 2008 16:48:02 +0000
Received: from abwk183.neoplus.adsl.tpnet.pl ([83.8.234.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 16:48:02 +0000
Received: from jnareb by abwk183.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 16 Apr 2008 16:48:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwk183.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79719>

Dmitry Potapov wrote:

> On Wed, Apr 16, 2008 at 04:56:08PM +0200, Johannes Sixt wrote:
>>=20
>> No. The reason why git clone'd repositories have problems is that
>> git-upload-pack sends a pack that does not contain the hidden object=
s;
but
>> since the cloned repository doesn't have the info/grafts, it tries t=
o
look
>> up the hidden, now missing, objects, and fails.
>=20
> In my experiment, there was no problem with hidden commits and object=
s
> as long as they presented in the original repository. Maybe, it is
> because I cloned it as locally using:
>=20
> =A0 =A0git clone PATH-TO-ORIG-REPO PATH-TO-DEST-REPO
>=20
> Maybe things would be as you say if I used git://

file:// should be enough.

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
