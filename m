From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsimport: add support for cvs pserver password
 scrambling.
Date: Thu, 13 Aug 2009 18:43:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908131837110.7429@intel-tinevez-2-302>
References: <5794AED2-43FF-4441-8292-0C9BFB3139A2@gmail.com> <20090410093434.6117@nanako3.lavabit.com> <7vhc0udiac.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-671064305-1250181835=:7429"
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	=?ISO-8859-15?Q?Dirk_H=F6rner?= <dirker@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 18:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbdPK-0006va-ER
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 18:44:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812AbZHMQn6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbZHMQn6
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 12:43:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:54336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751545AbZHMQn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 12:43:57 -0400
Received: (qmail invoked by alias); 13 Aug 2009 16:43:57 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp032) with SMTP; 13 Aug 2009 18:43:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+uEZBj0O6ulTKiCz21WkjTyg6fyYM466/yQqdfYu
	6vmCae8UIhX0zw
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <7vhc0udiac.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125832>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-671064305-1250181835=:7429
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 11 Apr 2009, Junio C Hamano wrote:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
> 
> > Quoting Dirk Hörner:
> >
> >> Instead of a cleartext password, the CVS pserver expects a scrambled one
> >> in the authentication request. With this patch it is possible to import
> >> CVS repositories only accessible via pserver and user/password.
> >> 
> >> Signed-off-by: Dirk Hoerner <dirker@gmail.com>
> >
> > Junio, may I ask what happened to this patch?
> 
> I do not use cvs emulation myself, nor pserver access, and I actually have
> been waiting for people who do use pserver access to report breakages and
> people pointing this patch out.

I really think it would be good if this patch was amended with a simple 
and quick test. Using the stdin/stdout server method, it should not be 
hard.

Ciao,
Dscho

--8323329-671064305-1250181835=:7429--
