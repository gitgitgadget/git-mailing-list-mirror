From: Wincent Colaiuta <win@wincent.com>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 10:51:09 +0200
Message-ID: <65C61F04-EF05-4CB4-A4E2-BFF6601F46B9@wincent.com>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:51:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqc9-00064F-OM
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:51:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756092AbXIEIvx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 04:51:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756086AbXIEIvw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:51:52 -0400
Received: from wincent.com ([72.3.236.74]:43100 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756055AbXIEIvw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Sep 2007 04:51:52 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l858pBRR003005;
	Wed, 5 Sep 2007 03:51:13 -0500
In-Reply-To: <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57691>

El 5/9/2007, a las 9:30, Junio C Hamano escribi=F3:

> Perhaps _exiting_ "git-commit" and "git-fetch" before doing
> anything, when the repository has more than 5000 loose objects
> with a LOUD bang that instructs an immediate repack would be
> good?
>
> I really do not like the idea of automatically running a repack
> after first interrupting the original command and then resuming.
> For one thing it would make a horribly difficult situation to
> debug if anything goes wrong.  You cannot reproduce such a
> situation easily.

I would strongly oppose any *automatic* repacking and strongly =20
support any *advisory* recommandation to repack when the loose object =20
count exceeds a certain threshold. I don't think *exiting* a command =20
in such cases is a good idea; worse than automatic repacking this =20
would be *forced* manual repacking, which isn't very user-friendly.

Cheers,
Wincent
