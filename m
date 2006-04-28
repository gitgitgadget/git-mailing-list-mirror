From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fix asciidoc callouts in git man pages
Date: Fri, 28 Apr 2006 16:06:06 +0200
Organization: At home
Message-ID: <e2t7f6$p1i$1@sea.gmane.org>
References: <BAYC1-PASMTP1046BB48C01D83AC57A694AEB20@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Apr 28 16:06:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZTbT-000587-5G
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 16:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030410AbWD1OFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 28 Apr 2006 10:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWD1OFs
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Apr 2006 10:05:48 -0400
Received: from main.gmane.org ([80.91.229.2]:62108 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030410AbWD1OFr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Apr 2006 10:05:47 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FZTbB-000552-3z
	for git@vger.kernel.org; Fri, 28 Apr 2006 16:05:33 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Apr 2006 16:05:33 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Apr 2006 16:05:33 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19280>

<opublikowany i wys=C5=82any>

Sean Estabrooks wrote:

> Started out just wanting to update the git-branch man page
> to include the "-r" option but noticed that the asciidoc
> callouts weren't being rendered in its man page.  Then
> noticed the same was true for all the man pages where
> they are used.
>=20
> It turns out we've not been following the guidelines
> properly on how to use them.  The fact that they show up
> in a useful way in the html docs is really an accident.
> Even there they're not showing up as intended.
>=20
> Unfortunately, even after all the docs are fixed up to use
> the proper format, they still don't render properly in the
> man format.   Seems this is a missing feature in the "xmlto"
> command.
>=20
> The final patch in this series adds an xsl fragment which
> is passed to xmlto so that the callouts appear properly in
> the man pages.

Have you sent bugreport/patch to the authors of asciidoc, by the way?

--=20
Jakub Narebski
Warsaw, Poland
