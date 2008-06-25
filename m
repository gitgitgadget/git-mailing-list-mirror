From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [NON-TOY PATCH] git bisect: introduce 'fixed' and 'unfixed'
Date: Wed, 25 Jun 2008 09:27:33 +0200
Message-ID: <20080625072733.GA26605@diana.vm.bytemark.co.uk>
References: <alpine.DEB.1.00.0806241515460.9925@racer> <20080624163810.GA4654@sigill.intra.peff.net> <alpine.DEB.1.00.0806241750030.9925@racer> <alpine.DEB.1.00.0806241808400.9925@racer> <486153DB.3070502@alum.mit.edu> <486179C8.2000704@gmail.com> <486188E3.10803@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lea Wiemann <lewiemann@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBPRS-0000cN-SO
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 09:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYFYH20 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 03:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751966AbYFYH20
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 03:28:26 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2494 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751847AbYFYH20 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 03:28:26 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KBPPh-00070P-00; Wed, 25 Jun 2008 08:27:33 +0100
Content-Disposition: inline
In-Reply-To: <486188E3.10803@gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86249>

On 2008-06-24 19:53:07 -0400, A Large Angry SCM wrote:

> Lea Wiemann wrote:
>
> > I think this is a good suggestion (though I haven't thought things
> > through). Another idea is to add "old" and "new" (or something
> > like that) as aliases to "good" and "bad", since that's the only
> > semantics that the bisect labels actually seem to have.
>
> "Before" and "After" the "Change" maybe?

Ha. It would not be hard to make it accept any two tags the user
happens to use. fast/slow, works/broken, fina-fisken/totalkvaddad, ...
it even comes with built-in internationalization!

/me ducks.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
