From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if cur/ is empty
Date: Mon, 05 Nov 2007 13:58:50 +0100
Organization: At home
Message-ID: <fgn429$gs9$1@ger.gmane.org>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 13:59:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip1Y0-0000K0-Pa
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 13:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbXKEM7H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Nov 2007 07:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754661AbXKEM7G
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:59:06 -0500
Received: from main.gmane.org ([80.91.229.2]:36510 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754184AbXKEM7F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:59:05 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ip1Xg-0005iC-KA
	for git@vger.kernel.org; Mon, 05 Nov 2007 12:59:00 +0000
Received: from abvt3.neoplus.adsl.tpnet.pl ([83.8.217.3])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 12:59:00 +0000
Received: from jnareb by abvt3.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 12:59:00 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvt3.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63510>

[Cc: Gerrit Pape <pape@smarden.org>, git@vger.kernel.org]

Gerrit Pape wrote:

> +=A0=A0=A0=A0=A0=A0=A0char *sub[] =3D { "cur", "new" };
[...]
> +=A0=A0=A0=A0=A0=A0=A0for (i =3D 0; i < 2; ++i) {

Wouldn't it be better to use sizeof(sub)/sizeof(sub[0]) or it's macro
equivalent ARRAY_SIZE(sub) instead of hardcoding 2 to avoid errors?

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
