From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Using Filemerge.app as a git-diff viewer
Date: Wed, 21 Nov 2007 14:28:03 +0100
Message-ID: <4455F263-251E-4B04-9F61-A26A3548B316@wincent.com>
References: <47440912.8010800@cam.ac.uk> <20071121112757.GA17231@sigill.intra.peff.net> <47442E57.8010004@cam.ac.uk>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Toby White <tow21@cam.ac.uk>
X-From: git-owner@vger.kernel.org Wed Nov 21 14:28:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iupd0-0004TO-7x
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 14:28:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbXKUN2M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Nov 2007 08:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbXKUN2M
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 08:28:12 -0500
Received: from wincent.com ([72.3.236.74]:54807 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027AbXKUN2L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Nov 2007 08:28:11 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lALDS46E015382;
	Wed, 21 Nov 2007 07:28:05 -0600
In-Reply-To: <47442E57.8010004@cam.ac.uk>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65648>

El 21/11/2007, a las 14:10, Toby White escribi=F3:

> (Wincent pointed out its flaws better than me. Basically,
> opendiff is not really diff-like enough.)
>
> And in any case, that launches Filemerge repeatedly
> on every file separately, which makes reviewing a large diff
> time-consuming and not very helpful.

I know it's not much help to you right now, but when I first asked =20
about a side-by-side diff viewer back in September I explored creating =
=20
a wrapper using GIT_EXTERNAL_DIFF and was basically unsatisfied with =20
the results.

So I decided to write a very simple native Cocoa app (I'm working on =20
Mac OS X); it was to be a diff viewer and nothing more (not a =20
repository browser). I was able to spend a few hours on it back in =20
September but then other things came up so I haven't been able to =20
finish it, but I do intend to come back to it when time permits. You =20
can browse the work in progress at:

<http://git.wincent.com/gdiff.git>

Basically consists of a fast Ragel-generated state machine for parsing =
=20
git-diff output, patches and email messages, and the beginnings of a =20
UI. But like I said, not much help to you right now as it can't yet be =
=20
used to do anything useful. My goal for it is to provide a nice =20
experience, above all when reviewing patches on a mailing list (ie. =20
where your local repository doesn't have the proposed commits in it =20
yet). In fact, even when run from outside of any Git repo I want it to =
=20
at least show the known parts of the files (the context) and provide a =
=20
shaded background for the unknown bits.

Cheers,
Wincent
