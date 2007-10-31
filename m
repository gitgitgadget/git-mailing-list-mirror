From: Florian Weimer <fweimer@bfk.de>
Subject: Re: How to remove a specific hunk
Date: Wed, 31 Oct 2007 12:56:00 +0100
Message-ID: <82zlxzsdkf.fsf@mid.bfk.de>
References: <4722036E.5030204@wanadoo.fr> <20071026192034.GA3062@steel.home>
	<13D08D3F-3647-4E20-AF80-8EC6FD14E66A@lrde.epita.fr>
	<Pine.LNX.4.64.0710311104450.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>,
	Alex Riesen <raa.lkml@gmail.com>,
	git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:56:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InCBJ-0004yX-P6
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 12:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbXJaL4H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 07:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbXJaL4G
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 07:56:06 -0400
Received: from mx01.bfk.de ([193.227.124.2]:50723 "EHLO mx01.bfk.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754298AbXJaL4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 07:56:05 -0400
Received: from mx00.int.bfk.de ([10.119.110.2])
	by mx01.bfk.de with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	id 1InCAy-0003Tr-PY; Wed, 31 Oct 2007 12:56:00 +0100
Received: from fweimer by bfk.de with local id 1InCAy-0007ym-IG; Wed, 31 Oct 2007 12:56:00 +0100
In-Reply-To: <Pine.LNX.4.64.0710311104450.4362@racer.site> (Johannes Schindelin's message of "Wed, 31 Oct 2007 11:06:18 +0000 (GMT)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Johannes Schindelin:

> You have seen that there are two different file lists, "staged
> changes" and "unstaged changes", right?  AFAIK if you click on the
> file in "staged changes", you can find the staged hunk and then
> remove it from the staged area.
>
> "Revert hunk" would not make any sense, since the hunk disappears
> once you staged/unstaged it.

I think Benoit wants to remove it from the working copy (and,
presumably, the index too).  "Revert hunk" and "Move hunk to stash"
might indeed be useful additions to citool.

--=20
=46lorian Weimer                <fweimer@bfk.de>
BFK edv-consulting GmbH       http://www.bfk.de/
Kriegsstra=DFe 100              tel: +49-721-96201-1
D-76133 Karlsruhe             fax: +49-721-96201-99
