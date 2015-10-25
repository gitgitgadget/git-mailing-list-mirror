From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] sh-setup: explicitly mark CR as a field separator
Date: Sun, 25 Oct 2015 14:25:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510251422310.31610@s15462909.onlinehome-server.info>
References: <cover.1445777347.git.johannes.schindelin@gmx.de> <214d877df18f3189b1809946817aab9765450ea9.1445777347.git.johannes.schindelin@gmx.de> <20151025131059.GA370025@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sun Oct 25 14:25:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqLJ5-0000Tr-3a
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 14:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751243AbbJYNZu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 09:25:50 -0400
Received: from mout.gmx.net ([212.227.17.20]:64412 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbbJYNZt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Oct 2015 09:25:49 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx101) with ESMTPSA (Nemesis) id 0M0cs6-1aeBIj1LIc-00usq6;
 Sun, 25 Oct 2015 14:25:47 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151025131059.GA370025@vauxhall.crustytoothpaste.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:nKZy70tESgqpXGdIF5r0yJ/MX8lHkvFNBeVeRy91U79Tyr+8jZS
 IHiHixItmRjZ+oupKbiaLpwKtsiv2CAfoOGAMCEtkGzQQ526NS9+I3TgF/v4PkBfOqV8soV
 EBbhz0xhYQ3eD+c6fQ8bfc2ortrhDmleXaXcSKYXMOBqsc9NtKg4TMpHASzcrhEQnw8uj57
 hg+9cTc1d5WjcFff4545g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:pAJNHbnmdKw=:yNZvoUZPhFtxrKQPoCPZ83
 U0yR1YmIKnxmAX+USJEFRHr6hZGQa/+iPx9/U/hGVLyQiU/uSn1CkaKwl1HC0JW81ZAnN7f9J
 HAp503nUY6lb6GfH72ChF9akkCKv3SP3e/fNjWOFEmpT3gBZnXUR4Jcjx541/uFLky81l6H7c
 R4Dj6zQQeZFjMjVysOTi9UKBn4O2qApaRVZBOAZ2RNHhgOngFc5w3m5mQGkX+l9aD7lgEVfi8
 viUNhabG6RVirFAsSBBjegUP//Me+jFZk8uP7Go6jX6Co7C9Hb7luhsbcf8xh71FzPCozfVsH
 dXPKSzpg+0SADdUMnMWVhkipW91oIRSj7fV/mbM9nsPYo1jtpbqnZ4uQO1eVXtb63CvZFOSbK
 RIu7SH5ZQ2kaoDjo+2P2WomXf6lQ5qQjiLSt/xyu04Fo0pkT/claVGXz5NHSR+jrfqvbxF6Mi
 3oBnSdyyYQFtkAw7IyfDCnFD2x6OwWHTZlgyeauhvn+fDQXw5DLEqyI3OPtZ458RmnJyiSjU0
 Gdpikwmwfz5ufJ0qLqRj9vIWWyjGMA3lEVVvVv1quxpIlSdGS6O9FTxhvI8wXeS9/oyWSdLzA
 /UL9B581RxPEYnLf0xXLyPSyIu84wmVcW7p8Hz1nFcUfUtqCO8FoWAGZAz+QNSrX35af52/lj
 JkeSfqNmjNeYIEDCoWxV1pRaVEi/fAldGHlvTwxELWzE261PcsS/DsIvQ2F38++g1SIoCzJ1I
 w1j93j7SinMHjNA7NOYSVNguU8Co00PCkffWU1kuR+JKnuuyBDo3uiF5TT9mqafsrpZZZhfg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280146>

Hi Brian,

re-Cc:ing the Git mailing list.

On Sun, 25 Oct 2015, brian m. carlson wrote:

> On Sun, Oct 25, 2015 at 01:50:32PM +0100, Johannes Schindelin wrote:
> > This is the correct thing to do, really: we already specify LF as
> > field separator.
> > 
> > Incidentally, this fixes the problem interactive rebase has when the
> > editor wants to save text with CR/LF line endings, as WordPad does
> > in Windows 10.
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  git-sh-setup.sh               | 2 +-
> >  t/t3404-rebase-interactive.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> > index 4691fbc..94dfe04 100644
> > --- a/git-sh-setup.sh
> > +++ b/git-sh-setup.sh
> > @@ -13,7 +13,7 @@ unset CDPATH
> >  # do not equate an unset IFS with IFS with the default, so here is
> >  # an explicit SP HT LF.
> >  IFS=' 	
> > -'
> > +'"$(printf '')"
> 
> On Linux, printf '' produces no output.  From my understanding of the
> POSIX spec, this is the correct behavior.   Does it behave differently
> on Windows?  If so, it might be nice to explain that in the commit
> messgae.

Hrm. This is apparently a bug in the script I tried to write for three
days now (because the mailing list-based code submission is really *so*
much more tedious than the Pull Request-based process I got so used to).

The '' should really read '\r'.

Ciao,
Johannes
