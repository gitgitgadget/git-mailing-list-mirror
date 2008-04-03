From: Michele Ballabio <barra_cuda@katamail.com>
Subject: Re: [REGRESSION] git-gui
Date: Thu, 3 Apr 2008 23:04:16 +0200
Message-ID: <200804032304.17054.barra_cuda@katamail.com>
References: <007901c89590$a827f7c0$93a7c10a@LGE.NET> <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jonathan del Strother" <maillist@steelskies.com>,
	"=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre_rosa@lge.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 23:04:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWbH-0003Yu-AF
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:03:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756189AbYDCVDQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Apr 2008 17:03:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756129AbYDCVDQ
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:03:16 -0400
Received: from smtp.katamail.com ([62.149.157.154]:46110 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1756079AbYDCVDP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Apr 2008 17:03:15 -0400
Received: (qmail 12683 invoked by uid 89); 3 Apr 2008 21:02:59 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host93-57-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.93)
  by smtp1-pc with SMTP; 3 Apr 2008 21:02:57 -0000
User-Agent: KMail/1.9.7
In-Reply-To: <57518fd10804030700r6de977f5p6f0418e6eaea2583@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78779>

On Thursday 03 April 2008, Jonathan del Strother wrote:
> On Thu, Apr 3, 2008 at 2:43 PM, Andr=E9 Goddard Rosa <andre_rosa@lge.=
com> wrote:
> > Hi, all!
> >
> >     After updating to git version 1.5.5.rc3 I always get the error =
below
> >  when starting "git gui".
> >     Linux distributions used are opensuse 10 and opensuse Factory.
> >
> >  # git gui
> >  Error in startup script: bad event type or keysym "["
> >     while executing
> >  "bind $ui_comm <$M1B-Key-\[> {show_less_context;break}"
> >     file "/usr/bin/git-gui" linux 2718)
> >
> >     I think it's related to git-gui 0.10 recently added into the tr=
ee.
>=20
> Doh, I broke git :(
>=20
> The problem is in c91ee2bd61 (Add shortcut keys for Show More/Less Co=
ntext).
> Works fine on my OS X 10.5 installation with tcl 8.4.7 - can anyone
> suggest an alternative way of binding the left/right brackets?  I'm
> not familiar with Tcl, and didn't manage to find a list of key names.

These changes should help (haven't tried):
	\[ -> bracketleft
	\] -> bracketright
but some European keyboards do not have easy access to brackets, so
other keys would be preferable (comma and period, for example, or 1 and=
 2).

See
	man keysyms
for a list of key names.
