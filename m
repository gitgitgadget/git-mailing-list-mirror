From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Extracting a single commit or object
Date: Thu, 1 Jan 2009 17:52:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901011747580.30769@pacific.mpi-cbg.de>
References: <21223948.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: yitzhakbg <yitzhakbg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 01 17:53:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIQnr-0002Ra-F5
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 17:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756344AbZAAQw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 11:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756284AbZAAQw0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 11:52:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:44999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756049AbZAAQwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 11:52:25 -0500
Received: (qmail invoked by alias); 01 Jan 2009 16:52:22 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 01 Jan 2009 17:52:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18sHs5k3Z8sTk1cOD7ensRA051q/sKX5pRby2RfC/
	RLg/4RScDfWe0P
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <21223948.post@talk.nabble.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104302>

Hi,

On Tue, 30 Dec 2008, yitzhakbg wrote:

> How would I extract a single commit from a repository by it's SHA1 (or 
> any other treeish)?

Your question is not precise enough to answer.  Are you looking for

- the commit message?
- the patch?
- all the files referenced by that commit?
- all the files _and revisions_ referenced by that commit?

The answer depends quite a lot on the question...

> For that matter, how is any one single object extracted? Examples please.

The user-friendly way to look at a tree is

	git show HEAD:Documentation/

or some such.  Likewise, you can inspect single blobs like this:

	git show HEAD:README

If you activated bash completion, you can even complete monsters like 
this:

	git show \
v1.5.3:v1.5.3:t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_master

Hth,
Dscho
