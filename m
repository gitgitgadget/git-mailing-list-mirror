From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to deal with conflicts after "git stash apply"?
Date: Sun, 21 Oct 2007 23:40:51 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710212338200.25221@racer.site>
References: <20071021223206.GJ16291@srparish.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 00:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjjU4-0003Wb-Iv
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 00:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750967AbXJUWlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Oct 2007 18:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbXJUWlM
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Oct 2007 18:41:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:49296 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750871AbXJUWlL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Oct 2007 18:41:11 -0400
Received: (qmail invoked by alias); 21 Oct 2007 22:41:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 22 Oct 2007 00:41:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19wiGM86MpwIAsK0il7yoOWAm5AMjzlJ0IvKPCws4
	tYyBMmHtzMG8ba
X-X-Sender: gene099@racer.site
In-Reply-To: <20071021223206.GJ16291@srparish.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61920>

Hi,

On Sun, 21 Oct 2007, Scott Parish wrote:

> How is the intended way to deal with "git stash apply" conflicts?
> If i just edit the file and remove the conflict, "git diff" gives
> some really messed up output. Documentation for other commands and
> conflicts suggest "git commit" after cleaning up the conflict, or
> "git add", but in the case of "stash apply" i'm not ready for a
> commit yet, and "git add" keeps "git diff" from showing any output.

You are probably seeing combined diffs.

This show not only the differences of the working tree relative to HEAD, 
but also of the changes stored in the stash.

You should have a look into Documentation/diff-format.txt (section 
"combined diff format") to learn more.

Hth,
Dscho
