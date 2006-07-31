From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 19] gitweb: No need to quote path for list version of open "-|"
Date: Mon, 31 Jul 2006 21:00:47 +0200
Organization: At home
Message-ID: <ealk0e$to2$2@sea.gmane.org>
References: <200607292239.11034.jnareb@gmail.com> <200607311833.39524.jnareb@gmail.com> <7v3bch7gf8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Mon Jul 31 21:02:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7d1U-0007kT-Tl
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 21:01:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWGaTBI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 31 Jul 2006 15:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030332AbWGaTBI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 15:01:08 -0400
Received: from main.gmane.org ([80.91.229.2]:4577 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030328AbWGaTBG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 15:01:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G7d0O-0007Yq-E4
	for git@vger.kernel.org; Mon, 31 Jul 2006 21:00:44 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 21:00:44 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 31 Jul 2006 21:00:44 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24539>

<opublikowany i wys=B3any>

Junio C Hamano wrote:

> I suspect the patch title is wrong -- it is not "no need to" but
> "quoting path breaks so do not do it" ;-).
>=20
> I guess this fixes the problem I saw last night?

If I remember correctly it worked without this patch, for git 1.4.1.1=20
(i.e. with --full-history option, although not working as advertised: s=
ee my
comment earlier in thread).

How to do sane fallback to version without "--full-history", if git bin=
aries
used do not support "--full-history"?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
