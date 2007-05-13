From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: ~ and ^
Date: Sun, 13 May 2007 21:13:50 +0200
Message-ID: <20070513191350.GB14657@diana.vm.bytemark.co.uk>
References: <20070513144442.b3cba792.seanlkml@sympatico.ca> <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 13 21:14:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnJWA-0006ND-5G
	for gcvg-git@gmane.org; Sun, 13 May 2007 21:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548AbXEMTOC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 13 May 2007 15:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758063AbXEMTOC
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 15:14:02 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4130 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755548AbXEMTOA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 15:14:00 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HnJVu-0003re-00; Sun, 13 May 2007 20:13:50 +0100
Content-Disposition: inline
In-Reply-To: <7v8xbssfti.fsf@assigned-by-dhcp.cox.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47172>

On 2007-05-13 12:07:21 -0700, Junio C Hamano wrote:

> Sean <seanlkml@sympatico.ca> writes:
>
> > Would it be possible/reasonable to treat a bare ~3 (or ^) on the
> > git command line as equivalent to "<current branch>~3" ? At least
> > @{3} already works this way and it would be nice to do the same
> > for the even more common tilde and hat operations. If so, it would
> > be a small convenience to just type: "git show ~3"
>
> Interesting.

Yes. I think we should have this, even if just for consistency.

> At least, "ls ~0" does not seem to get confused by bash to be the
> home directory of the root user, so I do not offhand think of a
> reason not to have ~$n as a synonym to HEAD~$n.

It seems that ~foo is only expanded to foo's home if there is such a
user. Since all-numeric users probably aren't common, we can probably
get away with it.

> Would that be useful? I dunno.

It would allow you to say

  git log ~5..

instead of

  git log HEAD~5..

so I'd say it is useful.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
