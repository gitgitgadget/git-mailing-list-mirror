From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: shell scripting woes, was Re: [PATCH 2/2] sh-setup: explicitly mark
 CR as a field separator
Date: Sun, 25 Oct 2015 14:56:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510251453420.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <214d877df18f3189b1809946817aab9765450ea9.1445777347.git.johannes.schindelin@gmx.de> <20151025131059.GA370025@vauxhall.crustytoothpaste.net>
 <alpine.DEB.1.00.1510251422310.31610@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 25 14:56:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqLn2-0007GG-00
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 14:56:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbbJYN4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 09:56:48 -0400
Received: from mout.gmx.net ([212.227.17.22]:59634 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbJYN4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 09:56:47 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Md31i-1a8QdW3rIg-00IHF7;
 Sun, 25 Oct 2015 14:56:40 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1510251422310.31610@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:r6/nqsNjxFV2Xj7pQy5xKnS7194Yv15+zGscyvPOTGVoWqPb3Wm
 itUHsrQX16BMeWGNx8O2K0kcz0KgR+KgNaqfejiZhu90jBqodRBC2+Ay3sLVfwaHSlPz+v4
 z+2h2p/GrXO+FRfpyDKegML3Xy6Z+v0oq1pz4z4kYGUXy4ZqKIA49eXMDQ8iNISZbWKqnPJ
 RqHnRwB8Sp1A1mFCevgZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i8RY7UyRs4Q=:MnyNIshNslu0KkeIxFLESm
 aX3jDCi/0s8ZpqpzEx5N9ErvFWJcv7O33PR7PBDBNWrU6dvmF8NDFXdnk2meAoY8ff6bmg1Xd
 qVlBOkd6HA1/iKBkL04qAkBssqy3kNeuLqzo8NS5oaTHurCTUx5FuNNibdqVVYyLQrUSeGJhB
 mWYVXJkTtv1J8jkYXWp3jQ8ynMESnlqanLgJKwks/+sPXct93mSU9rWkalm+DL4E2Esd6GYNQ
 wK+Z6H68CO7iwL+5jACEi0NF2TBltqvoFBG+//pxzHvGa51sEb04I0hmf68elz3kzM6i+BhCf
 scyqApa2DzHLS+ia4HtX9DU70/aO6hOh/PmeyXhlSVorR33RHsXNCVY05PILuDV/5ecgnizGF
 UyIiro9Bl47aSQHvElyrtt0VMzCKOzK+Ge/0Dq4BXki5sXXQeBv7fuXE/qY0mmERHIkmkA6d9
 sX6gkDbjAHn3/rt3hMRkJNSqoC4lvtWeW8PrhMv6NumxRCkeckq3nQ68OO734yfSm3QkcCX3F
 Y2yqFb0HeeL8YpbbLgqpU0ahX1FvyKVcRBNIGQb3HhIdosprVqJ3mj13GXBmchzrQGBTcjB1g
 9FB6r2Tn+HnXuuFfEl+aPaxI2IAitOPwGEBlnXg965GjD30lSrcCzyu1yGaWmyGdasCt/zgIC
 d6y/ak5xt3JNXeHBPbepmPriOHYh5UMQGW3mzboL7jurURvr6ZGCr9aeMtqb9w0K9Z6+IB38E
 xswimHU1Gx/8BXcmk3llgEIsVmGuTSoOT8nz5tm9/rgHHxcMtW/+XMTdPpzzWD49pQdaFJe8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280149>

Hi Brian,

On Sun, 25 Oct 2015, Johannes Schindelin wrote:

> On Sun, 25 Oct 2015, brian m. carlson wrote:
> 
> > On Sun, Oct 25, 2015 at 01:50:32PM +0100, Johannes Schindelin wrote:
> > > This is the correct thing to do, really: we already specify LF as
> > > field separator.
> > > 
> > > Incidentally, this fixes the problem interactive rebase has when the
> > > editor wants to save text with CR/LF line endings, as WordPad does
> > > in Windows 10.
> > > 
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  git-sh-setup.sh               | 2 +-
> > >  t/t3404-rebase-interactive.sh | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> > > index 4691fbc..94dfe04 100644
> > > --- a/git-sh-setup.sh
> > > +++ b/git-sh-setup.sh
> > > @@ -13,7 +13,7 @@ unset CDPATH
> > >  # do not equate an unset IFS with IFS with the default, so here is
> > >  # an explicit SP HT LF.
> > >  IFS=' 	
> > > -'
> > > +'"$(printf '')"
> > 
> > On Linux, printf '' produces no output.  From my understanding of the
> > POSIX spec, this is the correct behavior.   Does it behave differently
> > on Windows?  If so, it might be nice to explain that in the commit
> > messgae.
> 
> Hrm. This is apparently a bug in the script I tried to write for three
> days now (because the mailing list-based code submission is really *so*
> much more tedious than the Pull Request-based process I got so used to).
> 
> The '' should really read '\r'.

Aargh. It is 'dash'. Which is the default /bin/sh on Ubuntu. Try to run
the following script through dash and bash, compare the outputs, and weep:

-- snip --
x="$(echo "printf '\\n'")"
echo "$x"
-- snap --

Ciao,
Johannes

P.S.: At least here, the output differs as following:

Bash:
printf '\n'

Dash:
printf '
'

(!!!)
