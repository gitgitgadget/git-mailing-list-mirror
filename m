From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [QGIT RFC] Unit tests for QGit
Date: Fri, 29 Aug 2008 00:18:22 +0200
Message-ID: <20080828221822.GA21850@diana.vm.bytemark.co.uk>
References: <20080808211318.GA4396@efreet.light.src> <e5bfff550808170846y522cc6a8w59b696be39df311b@mail.gmail.com> <20080817195839.GB4542@efreet.light.src> <e5bfff550808171330w28dda6a2m32b0e51b1ef73cdc@mail.gmail.com> <20080818180048.GA15520@efreet.light.src> <e5bfff550808190753t4f99ddb6q83886dbca27dbf03@mail.gmail.com> <20080827201819.GD15520@efreet.light.src> <e5bfff550808280429h63496f9byfa4454af7adb0e86@mail.gmail.com> <20080828153118.GA13169@diana.vm.bytemark.co.uk> <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:57:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYpUX-00039D-I9
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYH1V4Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 17:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753652AbYH1V4Q
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:56:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3349 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYH1V4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:56:16 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYpos-0005j5-00; Thu, 28 Aug 2008 23:18:22 +0100
Content-Disposition: inline
In-Reply-To: <e5bfff550808281154h67392297y3a08d4ed8aea408f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94188>

On 2008-08-28 20:54:44 +0200, Marco Costalba wrote:

> On Thu, Aug 28, 2008 at 5:31 PM, Karl Hasselstr=F6m <kha@treskal.com>
> wrote:
>
> > StGit has no per-repo data. It's all per-branch. "stg init"
> > operates on the current branch, not the whole repo.
>
> Ok. Thanks. In this case the check qgit does is broken, and I think
> not only that because I never had this point clear while developing
> the interface.
>
> > Hmm. For me, "stg branch" succeeds even if "stg init" has not yet
> > been run (which is arguably as it should be, since it doesn't
> > require that stg init has been run in the current branch). "stg
> > series" or something is probably better for this purpose.
>
> But if I run 'stg branch' in a git-only repo this gives an error.
> This conditions, at least until now, has always been working for me.

Ah. I guess it might have gotten fixed recently, then. [ ... makes
some quick tests ... ] Yes, it gives an error in 0.13, but not in
0.14.

Not failing in this case is arguably correct for stg branch. But stg
series can per definition not work before stg init, so I recommend you
use that instead. Or don't use an stg command at all.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
