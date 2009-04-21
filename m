From: Jeff King <peff@peff.net>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 15:27:18 -0400
Message-ID: <20090421192718.GA7832@coredump.intra.peff.net>
References: <2FE32A75-C0D9-4156-B5D2-61AC6C086E5F@teksol.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?RnJhbsOnb2lz?= Beausoleil <francois@teksol.info>
X-From: git-owner@vger.kernel.org Tue Apr 21 21:29:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwLeR-0002wQ-PI
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 21:29:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757662AbZDUT1X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Apr 2009 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757745AbZDUT1W
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 15:27:22 -0400
Received: from peff.net ([208.65.91.99]:58391 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757425AbZDUT1V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 15:27:21 -0400
Received: (qmail 11077 invoked by uid 107); 21 Apr 2009 19:27:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 21 Apr 2009 15:27:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Apr 2009 15:27:18 -0400
Content-Disposition: inline
In-Reply-To: <2FE32A75-C0D9-4156-B5D2-61AC6C086E5F@teksol.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117152>

On Mon, Apr 20, 2009 at 10:50:25AM -0400, Fran=C3=A7ois Beausoleil wrot=
e:

> Regarding Anders reproduction recipe, no file was deleted.  I'm tryin=
g to=20
> write a reproduction script, but haven't managed to reproduce it just=
 yet.=20
>  The steps I *think* happened are thus:

If there is no deletion, then that seems like it might actually be a
bug.

> But the bug isn't reproduced with these steps.  If you want access to=
 the=20
> repository, please contact me privately and I'll give you access.

I can take a look at it if you want to mail me the details off-list.

> Johannes, you were right: I should have found the right avenue for =20
> posting this question and done so.  If not immediately, at least the =
next=20
> day.  It was late, I had other things to do, I just decided to post a=
=20
> quick note.  Call me lazy, yes.  Incompetent, that's going a bit too =
far. =20
> I hope my competence can be redeemed in your eyes.

I think it is OK to complain about and discuss git on your blog. That's
what it's there for. But I do think you are much more likely to get
developer attention and get your problem _fixed_ if you send a message
to the mailing list. So I don't think posting on a blog makes you
incompetent; but complaining afterwards that git developers didn't read
your blog and fix your problem might. ;)

-Peff
