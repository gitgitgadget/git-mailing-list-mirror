From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sun, 21 Dec 2008 11:09:36 +0100
Message-ID: <200812211109.36788.robin.rosenberg.lists@dewire.com>
References: <200812182039.15169.bss@iguanasuicide.net> <7viqpetfs3.fsf@gitster.siamese.dyndns.org> <200812202111.17831.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 11:12:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LELIn-0005nk-Tu
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 11:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbYLUKJy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2008 05:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbYLUKJy
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 05:09:54 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:38235 "EHLO
	pne-smtpout2-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459AbYLUKJx convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 05:09:53 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout2-sn1.fre.skanova.net (7.3.129)
        id 4843FAEB02FF55DB; Sun, 21 Dec 2008 11:09:44 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <200812202111.17831.bss@iguanasuicide.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103695>

s=F6ndag 21 december 2008 04:11:13 skrev Boyd Stephen Smith Jr.:
> On Saturday 2008 December 20 20:37:16 Junio C Hamano wrote:
> > Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> > > An alternative, would be "removing changes relative to .."
> > > (mainline).
> >
> > But that is exactly what "This reverts commit X" means, isn't it?
>=20
> When X is a merge commit, the phrase "the reverts commit X" is ambigu=
ous.  Did=20
> you revert the tree to X^, X^2, or X^8?  I'd be fine with "This rever=
ts=20
> commit X to X^y", but we definitely need some mention of X^y.

One could consider keeping the contributions from ^1 a special case and=
 not
mention the parent, making it look like any revert commit. I guess most=
 merge
reverts are like this in practice.

-- robin
