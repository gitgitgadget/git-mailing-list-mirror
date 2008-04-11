From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
Subject: Re: how to use two bare repositories?
Date: Sat, 12 Apr 2008 00:44:30 +0100
Message-ID: <20080411234430.GQ29940@cs-wsok.swansea.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 12 01:45:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkSwH-0007pc-MR
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 01:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759754AbYDKXog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 19:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756620AbYDKXof
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 19:44:35 -0400
Received: from mhs.swan.ac.uk ([137.44.1.33]:45388 "EHLO mhs.swan.ac.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759609AbYDKXoc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 19:44:32 -0400
Received: from [137.44.2.59] (helo=cs-svr1.swan.ac.uk)
	by mhs.swan.ac.uk with esmtp (Exim 4.69)
	(envelope-from <O.Kullmann@swansea.ac.uk>)
	id 1JkSv1-0004ZP-5B; Sat, 12 Apr 2008 00:44:31 +0100
Received: from cs-wsok.swansea.ac.uk (cs-wsok [137.44.2.227])
	by cs-svr1.swan.ac.uk (Postfix) with ESMTP id 154EFDAE20;
	Sat, 12 Apr 2008 00:44:31 +0100 (BST)
Received: by cs-wsok.swansea.ac.uk (Postfix, from userid 3579)
	id 08489741BB; Sat, 12 Apr 2008 00:44:30 +0100 (BST)
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79314>

Sorry, by error I didn't post this message to the
list, but it might be interesting for somebody,
so here the copy.

----- Forwarded message from Oliver Kullmann <O.Kullmann@swansea.ac.uk> -----

X-Original-To: csoliver@cs-svr1.swan.ac.uk
Delivered-To: csoliver@cs-svr1.swan.ac.uk
Date: Sat, 12 Apr 2008 00:40:38 +0100
From: Oliver Kullmann <O.Kullmann@swansea.ac.uk>
To: Junio C Hamano <gitster@pobox.com>
Subject: Re: how to use two bare repositories?
In-Reply-To: <7v7if4ouan.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i

On Fri, Apr 11, 2008 at 04:17:52PM -0700, Junio C Hamano wrote:
> Oliver Kullmann <O.Kullmann@swansea.ac.uk> writes:
> 
> > Now I want to create another public repository B,
> > from which anonymous pull is possible via http.
> > So B should be another bare repository.
> >
> > The problem is now that it seems not to be possible
> > to update B:
> >
> > 1. pulling from A is not possible since B is bare;
> > 2. fetching from A seems to work, checking the content of
> >    B via gitk seems to indicate that B has been updated
> >  --- however pulling from B doesn't work
> 
> The usual answer when you see a word "http" mentioned is...
> 
> 	how are you arranging update-server-info to be run whenever B is
> 	updated?

Aha, I see: So first I fetch, and then I run update-server-info.
Just tried it out, and it worked. Thanks!

(By the way, since B is updated anyway only by my package-building
script, it's no problem to run update-server-info then (by the script).)

----- End forwarded message -----
