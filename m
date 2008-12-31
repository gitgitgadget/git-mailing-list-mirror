From: David Brown <git@davidb.org>
Subject: Re: why still no empty directory support in git
Date: Tue, 30 Dec 2008 17:06:20 -0800
Message-ID: <20081231010620.GA26997@linode.davidb.org>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com> <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net> <alpine.DEB.2.00.0812300113050.22107@vellum.laroia.net> <9b18b3110812300043l55a42f6sd995f36bf857543e@mail.gmail.com> <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
To: Asheesh Laroia <asheesh@asheesh.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 02:07:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHpYn-00014n-90
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 02:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbYLaBGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 20:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751530AbYLaBGW
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 20:06:22 -0500
Received: from linode.davidb.org ([72.14.176.16]:54346 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750964AbYLaBGV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 20:06:21 -0500
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1LHpXQ-0007Bn-RA; Tue, 30 Dec 2008 17:06:20 -0800
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0812300346040.19911@vellum.laroia.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104235>

On Tue, Dec 30, 2008 at 03:58:46AM -0500, Asheesh Laroia wrote:

> This is because git is removing these directories. There is a strict 
> incompatibility between git rmdir()ing empty directories behind my back and 
> Maildir systems.

So, would there be a hook that would run at all of the times git might
remove the directories, and the hook could just put them back if
missing?

The post-merge hook is certainly one place, but there are likely
others.  You might also want one in post-checkout, but I'm guessing
that switching branches is going to be less frequent in a maildir
directory.

David
