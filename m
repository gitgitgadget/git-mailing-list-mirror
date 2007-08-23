From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Thu, 23 Aug 2007 02:24:18 +0200
Message-ID: <A204C4FE-A3EB-4EB3-8D76-BDC1F30E74C6@wincent.com>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site> <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org> <86absjcqfq.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org> <85ir77ky0u.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 02:25:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO0VO-0007nH-3s
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 02:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbXHWAYt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 20:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbXHWAYs
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 20:24:48 -0400
Received: from wincent.com ([72.3.236.74]:60479 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXHWAYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 20:24:48 -0400
Received: from [192.168.1.99] (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id l7N0Oaaa012212;
	Wed, 22 Aug 2007 19:24:40 -0500
In-Reply-To: <85ir77ky0u.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56439>

El 23/8/2007, a las 0:25, David Kastrup escribi=F3:

> Pretty much _any_ complex extensible system nowadays comes with a
> scripting/pattern/macro language of choice, and this language is, for
> a variety of reasons, rarely C.

But Git isn't really a "complex extensible system" relatively =20
speaking. It's actually a remarkably simple version control system, =20
both in terms of its design and in the number of lines of code to =20
implement that design. You already have all the extensibility you =20
will ever need in the form of the command set (about 144 commands by =20
my count) and you're free to script them to your heart's content; the =20
fact that some of these commands are being slowly migrated over to C =20
is an implementation detail that shouldn't really affect you as a =20
user at all, except indirectly in the sense that:

- it should run more quickly

- it should compile and work correctly more easily and with fewer =20
dependencies on more platforms

And if you accept Linus' point about the maintainability of C projects:

- the overall quality of the code should be higher because fewer =20
cycles will be burnt in maintenance

Cheers,
Wincent
