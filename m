From: Wincent Colaiuta <win@wincent.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 11:27:28 +0100
Message-ID: <5382B5D2-35B5-4FCA-BA7B-95B4CC1A099B@wincent.com>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com> <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org> <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com> <vpqfxwi5ljf.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"git mailing list" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:28:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRE8-0000No-9x
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbYA1K2B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 05:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbYA1K2B
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:28:01 -0500
Received: from wincent.com ([72.3.236.74]:37277 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbYA1K2A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2008 05:28:00 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0SARTW4022792;
	Mon, 28 Jan 2008 04:27:30 -0600
In-Reply-To: <vpqfxwi5ljf.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71873>

El 28/1/2008, a las 10:47, Matthieu Moy escribi=F3:

> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>
>> Yes it helps but I still wonder whether thereis a "simpler" way to =20
>> achive that.
>> Is it possible to split a patch selecting the hunk in git gui or any
>> other graphical
>> tool?
>
> You can apply the patch without commiting it, and them make several
> partial commits, by right-click "stage hunk for commit" in git-gui.

Or "git add --interactive", which isn't GUI but is a similar idea in =20
command line form.

And in case you've already applied the patch you can do a "git reset =20
HEAD^"; this moves your HEAD back by one commit, puts the index back =20
the way it was, but leaves the changes in your working tree. Then you =20
stage your hunks and commit them like Matthieu says.

Cheers,
Wincent
