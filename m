From: Tait <git.git@t41t.com>
Subject: Re: [PATCH] git send-email: edit recipient addresses with the --compose flag
Date: Mon, 10 Nov 2008 17:49:19 -0800
Message-ID: <20081111014919.GI7408@ece.pdx.edu>
References: <1226235588-2997-1-git-send-email-ian.hilt@gmx.com> <200811091513.55544.fg@one2team.com> <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 11 03:04:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzicF-0006Sv-Ag
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 03:04:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbYKKCDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 21:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753473AbYKKCDH
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 21:03:07 -0500
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:36719 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753703AbYKKCDG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 21:03:06 -0500
X-Greylist: delayed 822 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Nov 2008 21:03:06 EST
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id mAB1nLnu029241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 17:49:21 -0800
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id mAB1nKkv025873
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 17:49:21 -0800 (PST)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id mAB1nJoH025872
	for git@vger.kernel.org; Mon, 10 Nov 2008 17:49:19 -0800 (PST)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811091344480.20499@sys-0.hiltweb.site>
User-Agent: Mutt/1.5.7i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ehlo.cat.pdx.edu [131.252.208.106]); Mon, 10 Nov 2008 17:49:21 -0800 (PST)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=failed
	version=3.2.5
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ehlo.cat.pdx.edu
X-Virus-Scanned: ClamAV 0.92.1/8605/Mon Nov 10 17:11:29 2008 on ehlo.cat.pdx.edu
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100611>

> > > +	if ($c_file =~ /^To:\s*+(.+)\s*\nCc:/ism) {
> > 
> > Greedy operators are only supported with perl 5.10 or more... I think it's a 
> > bad idea to use them...
> 
> The problem here was that a space should follow the field, but it may
> not.  The user may unwarily backup over it.  "\s*" would match this
> case.
> 
> But if there is a space, it is included in the "(.+)".

Not in any version of Perl to which I have access. 

Why doesn't
	/^To:\s*(.+)\s*\nCc:/ism
work?
