From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t4202-log.sh: Test git log --no-walk sort order
Date: Fri, 17 Jul 2009 16:53:56 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907171653300.4495@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302> <1247840886-14795-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jul 17 16:54:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRop9-00085v-Gq
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 16:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934131AbZGQOyC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 10:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934090AbZGQOyB
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 10:54:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:46548 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933913AbZGQOyA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 10:54:00 -0400
Received: (qmail invoked by alias); 17 Jul 2009 14:53:58 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp012) with SMTP; 17 Jul 2009 16:53:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/azKRMnb7auDAPKg6z2fLAy37mB2xJPFZ9yxNeZk
	PnyV2B2IC1rwB6
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1247840886-14795-1-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123465>

Hi,

On Fri, 17 Jul 2009, Michael J Gruber wrote:

> 'git log --no-walk' sorts commits by commit time whereas 'git show' does
> not (it leaves them as given on the command line). Document this by two
> tests so that we never forget why ba1d450 (Tentative built-in "git
> show", 2006-04-15) introduced it and 8e64006 (Teach revision machinery
> about --no-walk, 2007-07-24) exposed it as an option argument.
> 
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  t/t4202-log.sh |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> v3: For completeness' sake, use git show -s.

Thanks!

Ciao,
Dscho
