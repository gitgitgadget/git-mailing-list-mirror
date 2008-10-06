From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Repairing fatal: ref HEAD is not a symbolic ref (git checkout
	of svn remote)
Date: Mon, 6 Oct 2008 07:02:43 -0700
Message-ID: <20081006140243.GB8203@spearce.org>
References: <pan.2008.10.06.14.00.57.104051@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jeff Kowalczyk <jtk@yahoo.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 16:04:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmqgl-000648-5F
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 16:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752232AbYJFOCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 10:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752145AbYJFOCo
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 10:02:44 -0400
Received: from george.spearce.org ([209.20.77.23]:49880 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbYJFOCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 10:02:43 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3837F3835F; Mon,  6 Oct 2008 14:02:43 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <pan.2008.10.06.14.00.57.104051@yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97581>

Jeff Kowalczyk <jtk@yahoo.com> wrote:
> To test a particular upstream revision, on a git svn remote checkout (i.e.
> branches/1.2, 76c7af2...), I checked out the equivalent of HEAD^^ (git
> checkout 4a3d99c0c9).
> 
> Now back at the branch tip, I get fatal: ref HEAD is not a symbolic ref
> on git svn rebase: 
> 
> (4a3d99c...) $ git checkout 76c7af2
> HEAD is now at 76c7af2... Minor changes to CONTRIBUTORS
> (76c7af2...) $ git svn rebase
> fatal: ref HEAD is not a symbolic ref Current branch HEAD is up to date.
> Segmentation fault
> 
> How can I manually correct ref HEAD?

git checkout whateverbranchyouwereonbefore
git svn rebase

-- 
Shawn.
