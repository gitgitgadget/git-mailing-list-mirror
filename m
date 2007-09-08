From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Button added to performs a GUI diff (inline)
Date: Sun, 9 Sep 2007 00:34:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709090031260.28586@racer.site>
References: <200709081231.26894.pmdumuid@pezdell>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: pierre.dumuid@adelaide.edu.au
X-From: git-owner@vger.kernel.org Sun Sep 09 10:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOt-0004BX-Nz
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:15 +0200
Received: from mail-mx1.uio.no ([129.240.10.29])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9vT-0002fp-Aj
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:41:19 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx1.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9vL-0005pZ-M2
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 01:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208AbXIHXe6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 19:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755076AbXIHXe6
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 19:34:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:39612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754965AbXIHXe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 19:34:57 -0400
Received: (qmail invoked by alias); 08 Sep 2007 23:34:55 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 09 Sep 2007 01:34:55 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6DE59SgG6WGkzpif2wEowJaH7iKWKILpvLMQdzi
	XIPPHgmyUVw/20
X-X-Sender: gene099@racer.site
In-Reply-To: <200709081231.26894.pmdumuid@pezdell>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.500,UIO_VGER=-3)
X-UiO-Scanned: F86370F39E390D436D391C1581D03F27605EA1A4
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 27 total 517784 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58145>

Hi,

On Sat, 8 Sep 2007, Pierre Marc Dumuid wrote:

> From bd43cca7aa88282455b6bbe6e2f9d8134da1029c Mon Sep 17 00:00:00 2001
> From: Pierre Marc Dumuid <pierre.dumuid@adelaide.edu.au>
> Date: Sat, 8 Sep 2007 00:32:10 +0930
> Subject: [PATCH] Button added to performs a GUI diff

Almost!  Just make sure that you are sending this patch with the correct 
Sender and put the Subject: line as subject of your mail.

And then describe in more detail what the patch does (This commit adds a 
button to gitk to easily look at diffs between a commit and its first 
parent.  It uses the GUI tool selected in merge.tool to visualize the 
diff, erroring out if none was specified.)

> +    if {[catch {exec git cat-file -p $sha1string^:$fname > .gitk_diffolder} err] 
> +	|| [catch {exec git cat-file -p $sha1string:$fname > .gitk_diffnewer} err]} {
> +	error_popup "Invalid file selected for comparison"
> +	return
> +    }

I think I found a solution for removing the temporary files: man n after.

Ciao,
Dscho
