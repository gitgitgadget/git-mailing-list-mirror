From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Minor annoyance with git push
Date: Sun, 10 Feb 2008 19:18:24 +0100
Message-ID: <07136779-23EB-4DAA-84C3-D54B7AC029AB@wincent.com>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <20080209030046.GA10470@coredump.intra.peff.net> <6B804F0D-9C3B-46F3-B922-7A5CBEF55522@zib.de> <alpine.LSU.1.00.0802091307160.11591@racer.site> <7v7ihd7ee1.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802100213330.11591@racer.site> <0DE4061C-7189-4932-AA3D-D09009F753F2@wincent.com> <alpine.LSU.1.00.0802101625200.11591@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Prohaska <prohaska@zib.de>, Jeff King <peff@peff.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 10 19:19:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOGlu-00018L-OO
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 19:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYBJSSs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 13:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbYBJSSs
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 13:18:48 -0500
Received: from wincent.com ([72.3.236.74]:44302 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798AbYBJSSr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 13:18:47 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1AIIPhF016930;
	Sun, 10 Feb 2008 12:18:26 -0600
In-Reply-To: <alpine.LSU.1.00.0802101625200.11591@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73385>

El 10/2/2008, a las 17:26, Johannes Schindelin escribi=F3:

> On Sun, 10 Feb 2008, Wincent Colaiuta wrote:
>
>> El 10/2/2008, a las 3:15, Johannes Schindelin escribi=F3:
>>
>>> I'm no longer that sure.  It seems that quite a lot of people do no=
t
>>> read manuals, and have no clue what they are doing when they just =20
>>> try
>>>
>>> 	$ git push
>>>
>>> to see what the synopsis is.
>>
>> I think there's no way we should be catering for people who type =20
>> command
>> like "git push" just to see what the synopsis does.
>>
>> The verb "push" very clearly has connotations of a state-changing,
>> possibly irreversible action (unlike other verbs like "log" or =20
>> "show").
>
> The problem is that "push" alone does not really imply which kind of =
=20
> push.

Yes, I know. I myself was surprised by the default behaviour the first =
=20
time I used "git push" (I only expected it to push the branch I was =20
currently on).

But my point is that if you don't know what "git push" is going to do =20
because its name doesn't imply "which kind of push" it will do (and in =
=20
reality a newcomer might not even realize that there might be more =20
than one kind of push), then adopting a "try it and see" approach =20
("let's type 'git push' and see if it gives me a synopsis") is not a =20
very good idea, and in a case like this where "push" is what I'd call =20
a "strong" verb, I don't think we should be trying to protect the user =
=20
from doing something obviously idiotic.

I'm all for protecting the user from nasty surprises (like "git =20
clean"; "clean" doesn't sound nearly as destructive as it can actually =
=20
turn out to be) but I don't think that anyone typing "git push" can =20
fairly claim to be surprised when Git goes ahead and, er, pushes =20
something.

Cheers,
Wincent
