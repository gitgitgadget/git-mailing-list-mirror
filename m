From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge commit.
Date: Sun, 21 Dec 2008 23:40:45 +0100
Message-ID: <200812212340.46375.robin.rosenberg.lists@dewire.com>
References: <200812182039.15169.bss@iguanasuicide.net> <200812211513.26808.bss@iguanasuicide.net> <7vprjlkwbb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:42:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEX06-00057J-JK
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbYLUWk7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Dec 2008 17:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbYLUWk7
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:40:59 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:39754 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524AbYLUWk7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:40:59 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C5021A4A0F; Sun, 21 Dec 2008 23:40:49 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <7vprjlkwbb.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103728>

s=F6ndag 21 december 2008 23:17:12 skrev Junio C Hamano:
> From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
> Subject: git-revert: record the parent against which a revert was mad=
e
>=20
> As described in Documentation/howto/revert-a-faulty-merge.txt, re-mer=
ging
> from a previously reverted a merge of a side branch may need a revert=
 of
> the revert beforehand.  Record against which parent the revert was ma=
de in
> the commit, so that later the user can figure out what went on.
>=20
> [jc: original had the logic in the message reversed, so I tweaked it.=
]
No need for this comment.

> +			add_to_msg(",\nreverting damages made to %s");
maybe "changes" is more neutrral language. I also think you break
the line too early.

Are we done now?

-- robin
