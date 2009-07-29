From: =?utf-8?b?Wm9sdMOhbg==?= =?utf-8?b?RsO8emVzaQ==?= 
	<zfuzesi@eaglet.hu>
Subject: Re: git-reset any branch head
Date: Wed, 29 Jul 2009 11:37:24 +0000 (UTC)
Message-ID: <loom.20090729T112521-558@post.gmane.org>
References: <loom.20090729T095925-556@post.gmane.org> <adf1fd3d0907290416q341ea6abi97828e75c50b7191@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 13:37:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW7Tg-00052o-Ah
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 13:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbZG2Lhl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 07:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbZG2Lhl
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 07:37:41 -0400
Received: from main.gmane.org ([80.91.229.2]:53823 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754149AbZG2Lhk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 07:37:40 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MW7TY-00058M-KD
	for git@vger.kernel.org; Wed, 29 Jul 2009 11:37:40 +0000
Received: from business-80-99-238-243.business.broadband.hu ([80.99.238.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 11:37:40 +0000
Received: from zfuzesi by business-80-99-238-243.business.broadband.hu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 11:37:40 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 80.99.238.243 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/530.5 (KHTML, like Gecko) Chrome/2.0.172.37 Safari/530.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124344>

Santi B=C3=A9jar <santi <at> agolina.net> writes:

>=20
> 2009/7/29 Zolt=C3=A1nF=C3=BCzesi <zfuzesi <at> eaglet.hu>:
> > Hi, sometimes it would be nice to reset not only the current,
> > but any given branch head. What do you think?
>=20
> git update-ref
>=20
> or do  you mean with porcelain commands?
>=20
> HTH,
> Santi
>=20

Suppose I have 3 branches A, B, C, and A is checked out.
I would like to set B's head to point to C's with a command like:
git-reset --head B C

Currently I can achieve it by 2 commands:
git-checkout B
git-reset --hard C

Z=C3=A9
