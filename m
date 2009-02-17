From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Blamming a diff between two commits?
Date: Tue, 17 Feb 2009 15:27:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902171526470.6185@intel-tinevez-2-302>
References: <499AB8A1.7090909@datacom.ind.br> <alpine.DEB.1.00.0902171452060.6185@intel-tinevez-2-302> <499AC530.7000408@datacom.ind.br>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZQwU-0007I9-8N
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 15:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbZBQO1Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 09:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbZBQO1Z
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 09:27:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:56741 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751944AbZBQO1Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 09:27:24 -0500
Received: (qmail invoked by alias); 17 Feb 2009 14:27:23 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp047) with SMTP; 17 Feb 2009 15:27:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/mluMz5o3mJn3jz2W//MACsB9x+ViBCT2bh1+gMb
	dxkuPkKteDFtqh
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <499AC530.7000408@datacom.ind.br>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110390>

Hi,

On Tue, 17 Feb 2009, Samuel Lucas Vaz de Mello wrote:

> Johannes Schindelin wrote:
> > 
> >> Is there any way to git blame (or annotate) a diff between two commits?
> > 
> > If you do not mean the diff, but a commit range:
> > 
> > 	$ git blame A..B -- file
> > 
> > "Unblameable" lines will be shown with a prefix ^A (not literal, of 
> > course, but the short commit name of A).
> > 
> 
> This work fine for lines that were added or changed, but not for deleted 
> lines.
> 
> If a commit in the range just delete a couple of lines and adds nothing, 
> the whole file is marked as "unblameable" as the deleted lines doesn't 
> exist anymore.

You might want to add the --reverse option for that.

Ciao,
Dscho
