From: Mike Hommey <mh@glandium.org>
Subject: Re: error in rewriting author history with filter-branch
	--env-filter
Date: Sun, 5 Apr 2009 09:21:58 +0200
Message-ID: <20090405072158.GA3881@glandium.org>
References: <799406d60904042121o27b4ac39m633354dcf0bcc84d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?R0lU77u/77u/77u/77u/?= <git@vger.kernel.org>
To: Adam Mercer <ramercer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 09:22:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqMgv-0003gI-FZ
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 09:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845AbZDEHVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 03:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756716AbZDEHVV
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 03:21:21 -0400
Received: from vuizook.err.no ([85.19.221.46]:40883 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbZDEHVU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 03:21:20 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LqMfJ-0005iF-1O; Sun, 05 Apr 2009 09:21:15 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LqMg2-00016A-Jy; Sun, 05 Apr 2009 09:21:58 +0200
Content-Disposition: inline
In-Reply-To: <799406d60904042121o27b4ac39m633354dcf0bcc84d@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115637>

On Sat, Apr 04, 2009 at 11:21:36PM -0500, Adam Mercer wrote:
> Hi
> 
> I'm trying to use git filter-branch to rewrite the author information
> on an repo that was imported from CVS a while ago, the commits I'm
> trying to rewrite are as follows:
> 
> commit 2cdeb25148f02b35391bd80a2c4c1876d7b8b840 Author: <ram> Date:
> Wed Dec 22 13:36:01 2004 +0000
> 
>     modify style
> 
> I'm trying to modify <ram> to be replaced with my name and email
> address. To do this I've been trying to use the following command
> 
> $ git filter-branch --env-filter ' an="$GIT_AUTHOR_NAME"
> am="$GIT_AUTHOR_EMAIL" if [ "$GIT_AUTHOR_EMAIL" = "ram"]; then
> an="Adam Mercer" am="ramercer@gmail.com" fi export GIT_AUTHOR_NAME=$an
> export GIT_AUTHOR_EMAIL=$am '
> 
> however when I run this I get loads of errors of the form:
> 
> Rewrite 18242fa722ff393e7fce78e05f37fa7c3b3825e1
> (1/216)/opt/local/libexec/git-core/git-filter-branch: line 307: [:
> missing `]'
> 
> Any ideas what I'm doing wrong? I'm running git-1.6.2.2.

You need a white space between "ram" and ].

Mike
