From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Stashing untracked files
Date: Sat, 29 Sep 2007 22:03:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709292201400.28395@racer.site>
References: <46FE9924.7080006@theory.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Neil Macneale <mac4-git@theory.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 23:04:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbjUO-000609-Q6
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 23:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755406AbXI2VEd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 17:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbXI2VEd
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 17:04:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:33020 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754124AbXI2VEc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 17:04:32 -0400
Received: (qmail invoked by alias); 29 Sep 2007 21:04:31 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 29 Sep 2007 23:04:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19zuqYciipzIkfN71Q/z56UigLMa5/8OZDJoNq5Zh
	mIPCTT4WTHJP0q
X-X-Sender: gene099@racer.site
In-Reply-To: <46FE9924.7080006@theory.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59490>

Hi,

On Sat, 29 Sep 2007, Neil Macneale wrote:

> When using "git stash," in some cases I'd like to stash away files that 
> are currently untracked. It seems to me like there should be a way to 
> stash everything in a working directory so that the end result is a 
> pristine tree. Then applying the stash will reinstate those file as 
> untracked.

Funny how the same ideas always come in packs: I had the same discussions 
a few nights ago on IRC.

Here is why I think it is _wrong_ to stash untracked files: this would 
include *.o and *.a, as well as all those binary files, too.

Instead this is what you _should_ do:

git add <the files that you care about>
git stash

Hth,
Dscho
