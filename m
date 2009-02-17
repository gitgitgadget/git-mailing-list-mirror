From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] filter-branch -d: Export GIT_DIR earlier
Date: Wed, 18 Feb 2009 00:01:41 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902172359210.10279@pacific.mpi-cbg.de>
References: <20090217083146.GA7338@lars.home.noschinski.de> <alpine.DEB.1.00.0902171327270.6185@intel-tinevez-2-302> <20090217175959.GA3564@lars.home.noschinski.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Lars Noschinski <lars@public.noschinski.de>
X-From: git-owner@vger.kernel.org Wed Feb 18 00:02:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZYx9-0004aB-QT
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 00:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754002AbZBQXAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 18:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753998AbZBQXAn
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 18:00:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:56642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753996AbZBQXAm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 18:00:42 -0500
Received: (qmail invoked by alias); 17 Feb 2009 23:00:40 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 18 Feb 2009 00:00:40 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tvXAKVygtvdl9b52QLpnVKZQsq17eEeboMskhcW
	8HszPl3mVEf3o+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090217175959.GA3564@lars.home.noschinski.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110469>

Hi,

On Tue, 17 Feb 2009, Lars Noschinski wrote:

> I'll change [make_commit] to test_commit.

Oops, sorry, I actually was not trying to suggest that, but relate a story 
that I found funny ;-)

> I think as it does not bite us, it would be unnecessary code churn to 
> remove the remaining usage of make_commit?

Probably.  I mean, every cleanup bears a very real possibility of 
introducing a regression, so it better be worth it.  As t7003 seems to 
work on (case) insensitive filesystems, let's leave it.

Ciao,
Dscho
