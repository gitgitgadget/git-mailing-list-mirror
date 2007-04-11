From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [PATCH 0/6] Initial subproject support (RFC?)
Date: Wed, 11 Apr 2007 10:08:29 +0200
Message-ID: <87d52bib9e.fsf@morpheus.local>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <Pine.LNX.4.64.0704092133550.6730@woody.linux-foundation.org> <81b0412b0704100604x2841d96aq194d3dedd303c588@mail.gmail.com> <Pine.LNX.4.64.0704100758430.6730@woody.linux-foundation.org> <81b0412b0704100848n69c99f55xa7cc96087cad7e31@mail.gmail.com> <Pine.LNX.4.64.0704100852550.6730@woody.linux-foundation.org> <7v6484vxd5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704101302480.6730@woody.linux-foundation.org> <7vk5wkuf35.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 15:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbXsx-0007pQ-I0
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 10:08:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbXDKII4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 11 Apr 2007 04:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbXDKII4
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 04:08:56 -0400
Received: from main.gmane.org ([80.91.229.2]:46723 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961AbXDKIIz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 04:08:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HbXsb-0001lj-AH
	for git@vger.kernel.org; Wed, 11 Apr 2007 10:08:37 +0200
Received: from c83-253-22-207.bredband.comhem.se ([83.253.22.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 10:08:37 +0200
Received: from davidk by c83-253-22-207.bredband.comhem.se with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Apr 2007 10:08:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c83-253-22-207.bredband.comhem.se
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:g7Da3l7XzvsKI92zy6C0WGrJCEY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44219>

Junio C Hamano <junkio@cox.net> writes:

> $ git rebase HEAD lt/gitlink
>=20
> This will take us back on lt/gitlink branch, set the tip of the
> branch to the commit we just made with the fix-up, and the first
> round will try to apply the change lt/gitlink~3 brings in on top
> of our HEAD.  This _will_ fail, but that is to be expected, as
> we intend to replace that with what we just amended.  Just reset
> it away and keep going.
>=20
> $ git reset --hard
> $ git rebase --skip

Wouldn't

$ git rebase --onto HEAD lt/gitlink~3 lt/gitlink

do the trick in one step?

--=20
David K=C3=A5gedal
