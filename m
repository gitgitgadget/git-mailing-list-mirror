From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 15:03:13 +0100
Message-ID: <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 15:04:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOCmv-00072U-Sy
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 15:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbYBJODf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 09:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbYBJODf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 09:03:35 -0500
Received: from wincent.com ([72.3.236.74]:43857 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750879AbYBJODe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 09:03:34 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1AE3EcY012716;
	Sun, 10 Feb 2008 08:03:15 -0600
In-Reply-To: <alpine.LSU.1.00.0802100213330.11591@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73357>

El 10/2/2008, a las 3:15, Johannes Schindelin escribi=F3:

> I'm no longer that sure.  It seems that quite a lot of people do not =
=20
> read
> manuals, and have no clue what they are doing when they just try
>
> 	$ git push
>
> to see what the synopsis is.

I think there's no way we should be catering for people who type =20
command like "git push" just to see what the synopsis does.

The verb "push" very clearly has connotations of a state-changing, =20
possibly irreversible action (unlike other verbs like "log" or "show").

People who type "git push" just to see a synopsis need to learn a =20
lesson; the lesson being that if you want to find out what a command =20
does the safest thing is to type "git help push" instead.

Cheers,
Wincent
