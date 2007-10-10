From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] git-filter-branch and filename case changes on insensitive
 file systems
Date: Wed, 10 Oct 2007 14:39:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710101436570.4174@racer.site>
References: <80A15F58-5A53-419B-9E22-E967CD590A12@steelskies.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 15:40:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfbnK-0002MY-UR
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 15:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbXJJNkF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 09:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753050AbXJJNkF
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 09:40:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:55321 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752183AbXJJNkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 09:40:03 -0400
Received: (qmail invoked by alias); 10 Oct 2007 13:40:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 10 Oct 2007 15:40:01 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Q7gdKhJRQZnjwiZCMokiGh05cpIdzGuIny7Kwy2
	Fqp4ubObWxNUuE
X-X-Sender: gene099@racer.site
In-Reply-To: <80A15F58-5A53-419B-9E22-E967CD590A12@steelskies.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60495>

Hi,

On Wed, 10 Oct 2007, Jonathan del Strother wrote:

> My repo has a change where a directory named Src was renamed to src.

That is no problem for git-filter-branch.

> I'm using case insensitive HFS+.

That is the problem.

Of course, we could work around that in git, but frankly, you will turn 
into problems once you have files whose names differ only in case.  And I 
am certain somebody will come soon and report this as a bug in git!

I vote for wont-fix (or more accurately "invalid") in git and 
please-fix-in-your-setup.

Ciao,
Dscho
