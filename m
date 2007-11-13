From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 21:46:59 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132145400.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <200711132110.29136.johannes.sixt@telecom.at> <7vlk91svgf.fsf@gitster.siamese.dyndns.org>
 <200711132232.11730.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:48:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3c6-0006XF-Lv
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760403AbXKMVru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758591AbXKMVru
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:47:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:48625 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760109AbXKMVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:47:49 -0500
Received: (qmail invoked by alias); 13 Nov 2007 21:47:48 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp034) with SMTP; 13 Nov 2007 22:47:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CGoNDM4zCHnXn+FHLtYHOmFjfTG4fZ+VUJVFn6K
	dudZ9KV9LajPBv
X-X-Sender: gene099@racer.site
In-Reply-To: <200711132232.11730.johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64880>

Hi,

On Tue, 13 Nov 2007, Johannes Sixt wrote:

> On Tuesday 13 November 2007 22:10, Junio C Hamano wrote:
> > Johannes Sixt <johannes.sixt@telecom.at> writes:
> > > On Tuesday 13 November 2007 21:04, Johannes Sixt wrote:
> > >> [PATCH 09/11] Allow a relative builtin template directory.
> > >> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> > >> 	of ETC_GITCONFIG.
> > >> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
> > >>
> > >> These need probably some discussion. They avoid that $(prefix) is
> > >> hardcoded and so allows that an arbitrary installation directory.
> > >
> > > ... and so allow that the compiled binaries are installed in any
> > > directory that the user chooses.
> >
> > If you can do that without breaking the tests (specifically, the
> > test script should pick up the version of git you just built,
> > not from /usr/bin nor /usr/local/stow/git/bin) that would be
> > great.
> 
> Sorry, I don't understand your statement. Do you see any tests breaking?

I guess what Junio is getting at: if your changes could lead to our not 
needing to hard code defaults, that would be awesome.

For example, a very unhappy camper reported recently that installing git 
with a different prefix triggers a complete rebuild.

Ciao,
Dscho
