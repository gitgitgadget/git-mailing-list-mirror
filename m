From: Kevin Geiss <kevin@desertsol.com>
Subject: Re: git-archimport
Date: Thu, 10 Nov 2005 22:19:10 -0700
Message-ID: <20051111051910.GP9131@raven.localdomain>
References: <D92ED0A1-B83A-43C3-B39C-AA8A21934D7F@desertsol.com> <46a038f90511101332r3389734uc1aa1effd2898e15@mail.gmail.com> <20051110214959.GO9131@raven.localdomain> <46a038f90511101421o7988a1bfi89eb0e33bd34e4bb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Geiss <kevin@desertsol.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 06:23:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaRKJ-00011C-J2
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 06:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVKKFTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 00:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbVKKFTO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 00:19:14 -0500
Received: from 12-219-167-192.client.mchsi.com ([12.219.167.192]:7378 "EHLO
	desertsol.com") by vger.kernel.org with ESMTP id S932363AbVKKFTM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 00:19:12 -0500
Received: from kevin by desertsol.com with local (Exim 4.50)
	id 1EaRJe-0006u2-V5; Thu, 10 Nov 2005 22:19:10 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90511101421o7988a1bfi89eb0e33bd34e4bb@mail.gmail.com>
X-PGP-Key: http://www.desertsol.com/~kevin/gpg.txt
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11559>

On Fri, Nov 11, 2005 at 11:21:12AM +1300, Martin Langhoff wrote:
> On 11/11/05, Kevin Geiss <kevin@desertsol.com> wrote:
> > Cannot find patchset for 'kevin@desertsol.com--files/scripts--oco--0--patch-1' at /usr/bin/git-archimport line 784
> 
> Hmmm. The script uses tla itself to get the patch. What happens if you do
> 
>   tla get-changeset -A kevin@desertsol.com--files/scripts--oco--0--patch-1
> 
> In short, you must have a recent tla configured and with the archive
> registered.
> 
> cheers,
> 
> 
> 
> martin

I've got tla 1.3, and the changeset seems to be there:

10:15pm0raven>tla get-changeset -A kevin@desertsol.com--files/scripts--oco--0--patch-1                                         /tmp
usage: tla get-changeset [options] revision [dir]
try get-changeset --help
10:15pm1raven>tla get-changeset  kevin@desertsol.com--files/scripts--oco--0--patch-1                                           /tmp
gpg: Signature made Mon Feb 14 12:28:10 2005 MST using DSA key ID E1E6A3B1
gpg: Good signature from "Kevin Geiss <kevin@desertsol.com>"
10:15pm0raven>tla get-changeset --help                                                                                         /tmp
retrieve a changeset from an archive
usage: tla get-changeset [options] revision [dir]

  -h, --help     Display a help message and exit.
  -H             Display a verbose help message and exit.
  -V, --version  Display a release identifier string
                 and exit.
  -A, --archive  Override `my-default-archive'

10:16pm0raven>tla --version                                                                                                    /tmp
tla lord@emf.net--gnu-arch-2004/dists--tla--1.3--version-0(configs/gnu/This-release) from regexps.com
