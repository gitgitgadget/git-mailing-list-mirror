From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/1]   Make git-tar-tree more flexible
Date: Mon, 31 Jul 2006 02:26:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607310225190.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060730174847.GA32574@eve.kumria.com> <7vbqr6dd4t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 31 02:26:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7Lc8-0005kx-R2
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 02:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWGaA03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Jul 2006 20:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWGaA03
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Jul 2006 20:26:29 -0400
Received: from mail.gmx.de ([213.165.64.21]:53663 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932151AbWGaA03 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Jul 2006 20:26:29 -0400
Received: (qmail invoked by alias); 31 Jul 2006 00:26:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp012) with SMTP; 31 Jul 2006 02:26:27 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqr6dd4t.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24480>

Hi,

On Sun, 30 Jul 2006, Junio C Hamano wrote:

> Anand Kumria <wildfire@progsoc.org> writes:
> 
> >   If you have a project which is setup like:
> >      project
> >      website
> >   and you decide you wish to generate a tar archive of _just_ the 'project'
> >   portion, git-tar-tree is not able to help. This patch adds two parameters
> >   which can assist.
> 
> No need I see.
> 
> 	git tar-tree tag-1.0:project project-1.0/project
> 	git tar-tree tag-1.0:project project-1.0

So how about this:

-- 8< --
[PATCH] tar-tree: illustrate an obscure feature better

Since you can tar just a subdirectory of a certain revision, tell
the users so, by showing an example how to do it.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

 Documentation/git-tar-tree.txt |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-tar-tree.txt b/Documentation/git-tar-tree.txt
index 7a99acf..1e1c7fa 100644
--- a/Documentation/git-tar-tree.txt
+++ b/Documentation/git-tar-tree.txt
@@ -71,6 +71,11 @@ git tar-tree --remote=example.com:git.gi
 
 	Get a tarball v1.4.0 from example.com.
 
+git tar-tree HEAD:Documentation/ git-docs > git-1.4.0-docs.tar::
+
+	Put everything in the current head's Documentation/ directory
+	into 'git-1.4.0-docs.tar', with the prefix 'git-docs/'.
+
 Author
 ------
 Written by Rene Scharfe.
