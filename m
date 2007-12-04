From: Wayne Davison <wayne@opencoder.net>
Subject: Re: [PATCH] git-stash: Display help message if git-stash is run
	with wrong sub-commands
Date: Tue, 4 Dec 2007 07:28:27 -0800
Message-ID: <20071204152827.GB24201@blorf.net>
References: <e66701d40712021834h64bf8d0y14f0e222d0f9a617@mail.gmail.com> <20071203061617.GB1976@blorf.net> <Pine.LNX.4.64.0712031023480.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Leung <kevinlsk@gmail.com>, Git ML <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 16:29:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzZiI-0001Uu-4F
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 16:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbXLDP2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 10:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbXLDP23
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 10:28:29 -0500
Received: from dsl-74-220-69-132.cruzio.com ([74.220.69.132]:42615 "EHLO
	dot.blorf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754146AbXLDP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 10:28:28 -0500
Received: by dot.blorf.net (Postfix, from userid 1000)
	id A5E6C2E13; Tue,  4 Dec 2007 07:28:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712031023480.27959@racer.site>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67055>

On Mon, Dec 03, 2007 at 10:25:17AM +0000, Johannes Schindelin wrote:
> But those are not really options, are they?  They are commands, which 
> exclude each other.

Option syntax is often used to represent exclusive commands, especially
when those commands need to be distinguished from free-form arg words.
The "git checkout" command is another example of this in git, and there
are plenty of non-git examples of such a use of option syntax around.
Such a syntax makes it easier to have a default action while still
taking a free-form arg.  I personally think that using option syntax
for its behavior choices would be preferable with git stash.

..wayne..
