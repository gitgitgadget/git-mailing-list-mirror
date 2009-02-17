From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 14:53:46 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171452060.6185@intel-tinevez-2-302>
References: <499AB8A1.7090909@datacom.ind.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Tue Feb 17 14:55:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQPr-0001sQ-Fs
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 14:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbZBQNxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 08:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbZBQNxv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 08:53:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:48613 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751810AbZBQNxv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 08:53:51 -0500
Received: (qmail invoked by alias); 17 Feb 2009 13:53:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 17 Feb 2009 14:53:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX182Ibw1Ozk2ydlD1dxAk36xXkgWaD406w8/80Cg1n
	m0DY3ZSx23ZZ8j
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499AB8A1.7090909@datacom.ind.br>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110372>

Hi,

On Tue, 17 Feb 2009, Samuel Lucas Vaz de Mello wrote:

> Is there any way to git blame (or annotate) a diff between two commits?

If you do not mean the diff, but a commit range:

	$ git blame A..B -- file

"Unblameable" lines will be shown with a prefix ^A (not literal, of 
course, but the short commit name of A).

Hth,
Dscho
