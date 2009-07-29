From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3 8/8] t3302-notes-index-expensive: Speed up
 create_repo()
Date: Wed, 29 Jul 2009 18:46:06 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907291845540.7626@intel-tinevez-2-302>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <1248834326-31488-9-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:46:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCIF-0001Sr-CA
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855AbZG2QqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755826AbZG2QqK
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:46:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:60714 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755804AbZG2QqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:46:09 -0400
Received: (qmail invoked by alias); 29 Jul 2009 16:46:07 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp029) with SMTP; 29 Jul 2009 18:46:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19HRWBwOmpHVfmvGOM4BgdRfmOVVOdiaUF3lteeup
	FzXh6kU4VPGt+8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1248834326-31488-9-git-send-email-johan@herland.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124371>

Hi,

On Wed, 29 Jul 2009, Johan Herland wrote:

> Creating repos with 10/100/1000/10000 commits and notes takes a lot of time.
> However, using git-fast-import to do the job is a lot more efficient than
> using plumbing commands to do the same.
> 
> This patch decreases the overall run-time of this test on my machine from
> ~3 to ~1 minutes.

ACK!

Ciao,
Dscho
