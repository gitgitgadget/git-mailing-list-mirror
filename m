From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/11] Miscellaneous MinGW port fallout
Date: Tue, 13 Nov 2007 22:54:36 +0100
Message-ID: <200711132254.37053.johannes.sixt@telecom.at>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at> <200711132232.11730.johannes.sixt@telecom.at> <Pine.LNX.4.64.0711132145400.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 22:55:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3ij-0000RA-4z
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:54:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759818AbXKMVyk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:54:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757611AbXKMVyk
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:54:40 -0500
Received: from smtp2.srv.eunet.at ([193.154.160.116]:49676 "EHLO
	smtp2.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757874AbXKMVyk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:54:40 -0500
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp2.srv.eunet.at (Postfix) with ESMTP id 7D8B6BF7C0;
	Tue, 13 Nov 2007 22:54:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 4652259084;
	Tue, 13 Nov 2007 22:54:37 +0100 (CET)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0711132145400.4362@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64888>

On Tuesday 13 November 2007 22:46, Johannes Schindelin wrote:
> Hi,
>
> On Tue, 13 Nov 2007, Johannes Sixt wrote:
> > On Tuesday 13 November 2007 22:10, Junio C Hamano wrote:
> > > Johannes Sixt <johannes.sixt@telecom.at> writes:
> > > > On Tuesday 13 November 2007 21:04, Johannes Sixt wrote:
> > > >> [PATCH 09/11] Allow a relative builtin template directory.
> > > >> [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates access
> > > >> 	of ETC_GITCONFIG.
> > > >> [PATCH 11/11] Allow ETC_GITCONFIG to be a relative path.
> > > >>
> > > >> These need probably some discussion. They avoid that $(prefix) is
> > > >> hardcoded and so allows that an arbitrary installation directory.
> > > >
> > > > ... and so allow that the compiled binaries are installed in any
> > > > directory that the user chooses.
> > >
> > > If you can do that without breaking the tests (specifically, the
> > > test script should pick up the version of git you just built,
> > > not from /usr/bin nor /usr/local/stow/git/bin) that would be
> > > great.
> >
> > Sorry, I don't understand your statement. Do you see any tests breaking?
>
> I guess what Junio is getting at: if your changes could lead to our not
> needing to hard code defaults, that would be awesome.
>
> For example, a very unhappy camper reported recently that installing git
> with a different prefix triggers a complete rebuild.

[PATCH 10/11] is one step into this direction.

-- Hannes
