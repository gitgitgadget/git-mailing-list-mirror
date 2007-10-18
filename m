From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [PATCH] git-blame shouldn't crash if run in an unmerged tree
Date: Thu, 18 Oct 2007 11:21:08 +0200
Message-ID: <20071018092108.GA24166@atjola.homenet>
References: <20071018063407.GA28861@spearce.org> <20071018083105.GA21768@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 11:21:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiRZE-0002Iz-3q
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 11:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760194AbXJRJVM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Oct 2007 05:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759743AbXJRJVM
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 05:21:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:38551 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759651AbXJRJVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 05:21:11 -0400
Received: (qmail invoked by alias); 18 Oct 2007 09:21:09 -0000
Received: from i577BAA3E.versanet.de (EHLO localhost) [87.123.170.62]
  by mail.gmx.net (mp043) with SMTP; 18 Oct 2007 11:21:09 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/gW3RC6Frgu0UFx/0KYW9cFhA4TJ0GbXqRamv25r
	zD0e7gfoDzNIhu
Content-Disposition: inline
In-Reply-To: <20071018083105.GA21768@atjola.homenet>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61509>

On 2007.10.18 10:31:05 +0200, Bj=F6rn Steinbrink wrote:
> On 2007.10.18 02:34:07 -0400, Shawn O. Pearce wrote:
> > I'm applying this patch to my maint tree tonight as it does resolve
> > the issue for now.  What surprised me was the file that we were
> > crashing out on wasn't even the file we wanted to get the blame
> > data for.  :-\
>=20
> The first merge moved some code from file1 (which doesn't exist in th=
e
> branch anymore) into file2, so I guess the code move detection comes
> into play here.
>=20
> Actually, in the original case that crashed here, I was curious about
> some lines in file2 which looked like they had been automatically mer=
ged
> from file1, so I tried to use git blame with file2 to see if that rea=
lly
> happened (I didn't expect git to be even able to follow code moves wh=
ile
> merging). Unfortunately, I didn't get such a test case yet, which mig=
ht
> indicate that I've only imagined that merge, and thinking about it, I
> think that file2 wasn't marked as modified in "git status". Hm, I'll =
try
> to find that merge conflict again and try that again.

Nope, didn't succeed in reproducing what I probably just pretend to hav=
e
seen.

Bj=F6rn
