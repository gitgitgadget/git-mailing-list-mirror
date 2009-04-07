From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rebase -i (and gitk) problem in Windows/Cygwin
Date: Tue, 7 Apr 2009 16:25:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904071624250.6897@intel-tinevez-2-302>
References: <831vs4im37.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Tue Apr 07 16:27:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrCGK-0006m7-LW
	for gcvg-git-2@gmane.org; Tue, 07 Apr 2009 16:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753042AbZDGOZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2009 10:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752278AbZDGOZU
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 10:25:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39557 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750894AbZDGOZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2009 10:25:19 -0400
Received: (qmail invoked by alias); 07 Apr 2009 14:25:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp046) with SMTP; 07 Apr 2009 16:25:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sRkBSm3ds+tnAD1V/P0UloRGXsqv/KxcCOWxhBZ
	mUOLgw13qvbqD4
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <831vs4im37.fsf@kalahari.s2.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115960>

Hi,

On Tue, 7 Apr 2009, Hannu Koivisto wrote:

> * I change a file in workspace.
> * I "Update" in gitk - I see the change.
> * I undo the change.
> * I "Update" in gitk - I see an empty change.
> * "Reload" doesn't help - I still se an empty change.
> * I run "git status" on the command line and then select "Update"
>   in gitk -> now the change disappears.

What does "git diff" say?  It may be an autocrlf issue or a file mode 
issue.

Ciao,
Dscho
