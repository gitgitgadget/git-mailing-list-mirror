From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 01/10] Add a birdview-on-the-source-code section to the user manual
Date: Tue, 15 May 2007 10:24:07 +0200
Message-ID: <20070515082407.GA9096@diana.vm.bytemark.co.uk>
References: <20070514181943.GA31749@diana.vm.bytemark.co.uk> <20070514183931.GC23090@fieldses.org> <20070515042200.GA10884@coredump.intra.peff.net> <20070515045044.GB2805@fieldses.org> <20070515050808.GA11745@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 15 10:24:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnsKo-0007A0-Tu
	for gcvg-git@gmane.org; Tue, 15 May 2007 10:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756048AbXEOIYN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 15 May 2007 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760183AbXEOIYN
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 04:24:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3636 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756048AbXEOIYM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 04:24:12 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnsKG-0002Na-00; Tue, 15 May 2007 09:24:08 +0100
Content-Disposition: inline
In-Reply-To: <20070515050808.GA11745@coredump.intra.peff.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47324>

On 2007-05-15 01:08:08 -0400, Jeff King wrote:

> However, the content-type is already specified, so it shouldn't need
> to rewrite. However, I notice that your original message is missing
> a MIME-Version: 1.0 header. My guess is that vger's logic is that
> without that header, it can't trust the Content-Type you have
> provided (and indeed, not including MIME-Version violates the MIME
> RFCs, I believe).

You know, this rings a bell. I've discovered that a "MIME-Version:
1.0" is needed before. :-)

"stg mail" used to have the same problem, until it was changed to use
the Python e-mail libraries for all that stuff. And since then I
haven't had problems with it.

> I assumed this was a bug in git-send-email, but looking closer, it
> doesn't put in any mime information at all! So your sending smtp
> server is adding in the content-type header, but it's failing to add
> the MIME-Version header, which I think is a bug (I can dig up the
> RFC reference if you want).
>
> Arguably, git should be generating the full MIME header-set, since
> it knows what actual encoding the message is in.

I very much agree.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
