From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: jgit doesn't support "compare with" and "replace with"?
Date: Fri, 19 Dec 2008 21:39:20 +0100
Message-ID: <200812192139.20597.robin.rosenberg.lists@dewire.com>
References: <1229677848765-1677009.post@n2.nabble.com> <20081219152045.GR32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Martin_S" <iksdrijf@yahoo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 21:45:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDmEF-0001HS-TG
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 21:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbYLSUoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 15:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbYLSUoa
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 15:44:30 -0500
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:56882 "EHLO
	pne-smtpout1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751084AbYLSUo3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 15:44:29 -0500
Received: from sleipner.localnet (213.67.100.250) by pne-smtpout1-sn2.hy.skanova.net (7.3.129)
        id 48A144C502147FCB; Fri, 19 Dec 2008 21:39:26 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081219152045.GR32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103582>

fredag 19 december 2008 16:20:45 skrev Shawn O. Pearce:
> Martin_S <iksdrijf@yahoo.com> wrote:
> > 
> > Hi, I'm using eclipse 3.4 and jgit 0.4. The right click context menus don't
> > list "compare with" and "replace with". Am I doing something wrong?
> 
> We haven't implemented them in EGit.  So its not surprising that
> they aren't appearing.

Actually, we had it in v0.3 though it didn't always work. In particular it didn't work on
Windows... 

The history rewrited killed it, but re-adding it would not be to hard, It's mostly about passing two explicit
versions to compare, which is already done in 

The old version disappeared in 07f04ae5b1771069667028d225196daff29402a0, checkout out and rebuild
if you are really desperate. Reverting it is an option, but that is not trivial either so going forward and 
reimplementing it (correctly this time) is a more appealing approach. Dependig on your needs, i.e. if
you only don't need clone/fetch/push you could go back to the commit mentioned above. The closest
tagged version is v0.3.1. As a bonus it draws the graph correctly, though it is not optimal.

-- robin
