From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bisect run, was Re: More git bisect modes
Date: Thu, 5 Mar 2009 12:31:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903051231070.6524@intel-tinevez-2-302>
References: <43d8ce650903050149u4ca98444w28efceb9084efa68@mail.gmail.com>  <20090305190542.6117@nanako3.lavabit.com>  <43d8ce650903050217m2885692dkcef08ab2a5f60082@mail.gmail.com>  <7vvdqo1csl.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.00.0903051207480.6524@intel-tinevez-2-302>
 <43d8ce650903050318g6ab81e6es9869b9f526c5eb24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-815418203-1236252701=:6524"
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Git Mailing List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 12:33:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfBpI-0002Sx-EV
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 12:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbZCELbp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 06:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbZCELbp
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 06:31:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:59512 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751192AbZCELbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 06:31:44 -0500
Received: (qmail invoked by alias); 05 Mar 2009 11:31:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp027) with SMTP; 05 Mar 2009 12:31:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18dsuJxFV0dsjlpyV8oQyZ7KaE8H3iItU5EfHHiPo
	XEkMgwzOmfwL7c
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <43d8ce650903050318g6ab81e6es9869b9f526c5eb24@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112300>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-815418203-1236252701=:6524
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 5 Mar 2009, John Tapsell wrote:

> 2009/3/5 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> > That reminds me of a personal gripe with "bisect run": You cannot use it
> > like this:
> >
> >        $ git bisect run 'make test'
> >
> > as it interprets 'make test' as a name of an executable.  That makes
> > 'bisect run' rather less useful to me.
> 
> A very quick test seems to show that:
> 
> $ git bisect run make test
> 
> Works as you want.  Maybe a quick example of this could be added to
> the man page.

Indeed, the source code agrees with you.

Thanks,
Dscho

--8323329-815418203-1236252701=:6524--
