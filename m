From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] submodule+shallow clone feature request
Date: Wed, 10 Feb 2010 23:57:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de>
References: <4B73277C.9010801@columbia.edu> <7vsk983fi4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Schuyler Duveen <sky@columbia.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 23:51:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfLP9-0005x6-R4
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 23:51:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756542Ab0BJWv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 17:51:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:49737 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755900Ab0BJWv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 17:51:26 -0500
Received: (qmail invoked by alias); 10 Feb 2010 22:51:25 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp038) with SMTP; 10 Feb 2010 23:51:25 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kJuRI8BgkqroOqwOoBId4wORAjy7jvDiDmfgtdN
	dgDO2Jv2subcsy
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vsk983fi4.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139565>

Hi,

On Wed, 10 Feb 2010, Junio C Hamano wrote:

> Schuyler Duveen <sky@columbia.edu> writes:
> 
> > My use case is deploying from a git repository, which would be even more
> > graceful with the following features:
> >
> > 1. When 'git clone' has both --recursive and --depth, then submodules
> > are also checked out shallow (for speed/bandwidth).
> >
> > 2. Some way to specify an override on .gitmodules sources.  This is
> > because our .gitmodules includes public, read-only sources (github),
> > rather than our local repos we would prefer to deploy from (for the
> > purpose of reliability).
> 
> These should be doable if you do not use --recursive, so I don't think 
> they are insurmountable issues.  I suspect many people would welcome 
> such enhancements to the "git submodule" potty.

Yes. Note, though, that the problems of enhancing git-submodule are not 
technical, as we can learn from the recent history, including the lack of 
support for rebasing submodules (there _were_ patches!).

Ciao,
Dscho
