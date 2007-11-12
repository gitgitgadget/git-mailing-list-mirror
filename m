From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 17:39:06 +0100
Organization: At home
Message-ID: <fh9vja$u75$2@ger.gmane.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz> <20071112131927.GA1701@c3sl.ufpr.br> <Pine.LNX.4.64.0711121355380.4362@racer.site> <200711121719.54146.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 12 17:40:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcKz-0006LS-JX
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042AbXKLQkV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 11:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbXKLQkV
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:40:21 -0500
Received: from main.gmane.org ([80.91.229.2]:58515 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXKLQkU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:40:20 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1IrcKQ-00046f-28
	for git@vger.kernel.org; Mon, 12 Nov 2007 16:40:02 +0000
Received: from abwz76.neoplus.adsl.tpnet.pl ([83.8.249.76])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:40:02 +0000
Received: from jnareb by abwz76.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 16:40:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwz76.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64658>

Jan Wielemaker wrote:

> As we are on the subject anyway. Though not tested with the very late=
st,
> but when I was playing with them, I found out that cloning a empty ba=
re
> repository produces nothing at all, dispite the promising message:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0$ mkdir x && cd x
> =A0=A0=A0=A0=A0=A0=A0=A0$ git --bare init --shared=3Dgroup

Note that "git --bare init" and "git init --bare" are two *different*
things (first is no-op, by the way).

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
