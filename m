From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Sat, 19 Dec 2009 11:54:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912191150450.4985@pacific.mpi-cbg.de>
References: <4B2C0828.4010505@signalbeam.net> <20091219013246.GD25474@genesis.frugalware.org> <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net> <7vzl5fik3o.fsf@alter.siamese.dyndns.org> <4B2C7EC3.6070501@signalbeam.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Moe <moe@signalbeam.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 11:49:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLwsQ-0006mI-3K
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 11:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbZLSKtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 05:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbZLSKtY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 05:49:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:39567 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751502AbZLSKtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 05:49:22 -0500
Received: (qmail invoked by alias); 19 Dec 2009 10:49:20 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 19 Dec 2009 11:49:20 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+RA+EaT5+RZyZAgESBWRZbETT7y2Xq6C5jy0WGbj
	w8Mc2QD22Z7NOA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B2C7EC3.6070501@signalbeam.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135471>

Hi,

On Sat, 19 Dec 2009, Moe wrote:

> What we do is, we put our entire runtime environment [for a web 
> application] under a dedicated user and under version control. This is a 
> very comfortable way to maintain an identical environment across the 
> board, we even deploy this way to our production servers by the means of 
> a git pull on a dedicated branch.

Just ignoring the fact that you version control a version controlled 
directory (including the repository), which is inefficient, and even 
further ignoring the fact that you open the door for concurrent -- 
incompatible -- modifications, if all you want to do is:

> In practice our developers will su or ssh to this user to get working 
> and generally they need only a very small set of divertions from the 
> common configuration - such as their personal git identity and their 
> preferred editor settings.

... then I suggest reading up on GIT_EDITOR, GIT_AUTHOR_IDENT and 
GIT_COMMITTER_IDENT, and leaving the $HOME/.gitconfig alone.

Ciao,
Dscho
