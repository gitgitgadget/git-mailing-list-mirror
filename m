From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rebase vs rebase -i
Date: Thu, 4 Feb 2010 19:46:42 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002041946170.4505@intel-tinevez-2-302>
References: <76718491002032019i5f8ea947paa527988ddb7a378@mail.gmail.com>  <alpine.DEB.1.00.1002041414530.4505@intel-tinevez-2-302>  <76718491002040914t12956bb2gbe21ae89f31cbc7f@mail.gmail.com>  <alpine.DEB.1.00.1002041859000.4505@intel-tinevez-2-302>
 <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-798737136-1265309206=:4505"
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 19:47:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd6jS-0004NW-Oa
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 19:47:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757827Ab0BDSqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2010 13:46:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:60185 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757817Ab0BDSqy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2010 13:46:54 -0500
Received: (qmail invoked by alias); 04 Feb 2010 18:46:46 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 04 Feb 2010 19:46:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+w9n8Fbe2wZiC3VgWuUXxVfs9TlFcd6BylyuNIKo
	TglK4sNxmaO32Y
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <76718491002041010k84ad55ct5c3e80529e8f8428@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64000000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138996>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-798737136-1265309206=:4505
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 4 Feb 2010, Jay Soffian wrote:

> On Thu, Feb 4, 2010 at 1:00 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 4 Feb 2010, Jay Soffian wrote:
> >
> >> On Thu, Feb 4, 2010 at 8:27 AM, Johannes Schindelin
> >> <Johannes.Schindelin@gmx.de> wrote:
> >> >> (Here I'm setting GIT_EDITOR=true just to demonstrate that I didn't
> >> >> change the list of commits in the latter case.)
> >> >
> >> > You can get _exactly_ the same behavior if you use -m.
> >>
> >> Or rather, -p. ;-)
> >
> > No.  -p tries to preserve merges, and it will use
> > git-rebase--interactive.sh for hysterical raisins.
> >
> > I meant -m.
> 
> I don't understand what you mean by "_exactly_ the same behavior" then.

Both "rebase -i" and "rebase -m" are really a cherry-pick in a loop.

Ciao,
Dscho
--8323329-798737136-1265309206=:4505--
