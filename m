From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git Confusion
Date: Sat, 30 May 2009 01:32:26 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh21359.460.sitaramc@sitaramc.homelinux.net>
References: <815c8c330905290043i4c99a753jd5ad9bdd4cf18bbc@mail.gmail.com>
 <20090529135242.GA30926@coredump.intra.peff.net>
 <815c8c330905291324w4e861602n8278df72fdbc28db@mail.gmail.com>
 <200905292245.56702.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 03:32:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MADRI-0003h8-Ez
	for gcvg-git-2@gmane.org; Sat, 30 May 2009 03:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbZE3Bck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 21:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752074AbZE3Bcj
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 21:32:39 -0400
Received: from main.gmane.org ([80.91.229.2]:59174 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751186AbZE3Bci (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 21:32:38 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MADR9-0007Uh-SL
	for git@vger.kernel.org; Sat, 30 May 2009 01:32:39 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 May 2009 01:32:39 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 May 2009 01:32:39 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120330>

On 2009-05-29 20:45:55, Jakub Narebski <jnareb@gmail.com> wrote:

>    repositories. I think you can use Gitosis without being a root...

you don't need root for gitosis.  However, this means you
will be using your own "regular work" userid to host gitosis
also, which is a wee bit fiddly.

Apart from things like fixing up PYTHONPATH in advance,
adding a "--prefix=DIR" to the install command, etc., you
should also remember that any pubkey added to gitosis
becomes a "git only" user, so normal ssh won't work for him
anymore.  If your own access to the machine which is now
your gitosis server is via pubkey, you may find yourself
locked out -- don't add that pubkey to gitosis :-)

If the original poster needs more info, I will be happy to
give more details.
