From: Wincent Colaiuta <win@wincent.com>
Subject: Re: git push (mis ?)behavior
Date: Wed, 3 Oct 2007 08:47:40 +0200
Message-ID: <0F838789-B02F-4081-8C75-ED06B551D4C0@wincent.com>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <buoprzwn5qm.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 08:48:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icy1V-0005UX-9n
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 08:47:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXJCGrt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Oct 2007 02:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbXJCGrt
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 02:47:49 -0400
Received: from wincent.com ([72.3.236.74]:46293 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162AbXJCGrt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Oct 2007 02:47:49 -0400
Received: from [192.168.0.129] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l936lgfU010155;
	Wed, 3 Oct 2007 01:47:43 -0500
In-Reply-To: <buoprzwn5qm.fsf@dhapc248.dev.necel.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59796>

El 3/10/2007, a las 7:10, Miles Bader escribi=F3:

> Junio C Hamano <gitster@pobox.com> writes:
>> I think it is sensible to have an option to make it push only the
>> current branch.  I am not sure if it is sensible to make that the
>> default.
>
> I really like the current default, it matches my mental model well:  =
I
> generally use "push" to mean "synchronize the remote repository =20
> with my
> current one"; if multiple branches have changed, I want those changes
> propagated too.
>
> I think changing it would be a bad idea, it just seems a pointlessly
> incompatible change.  The reasons I've seen offered on this thread fo=
r
> changing the default seem pretty weak, e.g., "it's more conservative"
> (but more annoying)

It could be more annoying for some, yet a life saver for others. So =20
before changing the default obviously we would need to get a clear =20
idea of whether or not the majority would approve of such a move. =20
Such differences of opinion would be easily accommodated if the =20
default behaviour were made configurable. That way everyone can have =20
the behaviour they want.

Cheers,
Wincent

PS. I'm the one who mentioned SVK, but I didn't offer it as a reason =20
to justify the change (I agree, more than "weak" it's not really any =20
reason at all); I  just mentioned to indicate why it is that the =20
current behaviour caught me off guard.
