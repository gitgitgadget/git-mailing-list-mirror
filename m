From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log -S doesn't find some commits
Date: Wed, 5 Nov 2008 00:15:44 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811050014310.30769@pacific.mpi-cbg.de>
References: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:09:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxV1k-0000lf-VZ
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYKDXIX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbYKDXIX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:08:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:55943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754042AbYKDXIX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:08:23 -0500
Received: (qmail invoked by alias); 04 Nov 2008 23:08:20 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 05 Nov 2008 00:08:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19S2ep6E9JSHeL3sdo99DudL9zT2N8KIeyEKdLjYm
	zO+hxcN01AstP9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <87fxm7rtb7.fsf@gollum.intra.norang.ca>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.73
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100115>

Hi,

On Tue, 4 Nov 2008, Bernt Hansen wrote:

> Commits B, C, and D are not included in the git log -S output even
> though with gitk you can see that 'org-publish-validate-link' is in the
> patch.

It is not sufficient for it to be in the patch, it has to be added or 
deleted in whole.  So for example if you had a line

	org-publish-validate-link Hello

and you changed it to

	org-publish-validate-link World

git log -SWorld will find the commit, but git log 
-Sorg-publish-validate-link will not.

Hth,
Dscho
