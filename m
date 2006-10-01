From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [BUG] "git cat-file tree <sha1>" prints garbage
Date: Sun, 1 Oct 2006 22:48:30 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610012247330.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061001202602.GD32373@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-612564280-1159735710=:14200"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 22:48:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU8En-0000pT-Hs
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 22:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWJAUsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 16:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWJAUsd
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 16:48:33 -0400
Received: from mail.gmx.de ([213.165.64.20]:23247 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932361AbWJAUsc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 16:48:32 -0400
Received: (qmail invoked by alias); 01 Oct 2006 20:48:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 01 Oct 2006 22:48:30 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Sebastian Harl <sh@tokkee.org>
In-Reply-To: <20061001202602.GD32373@albany.tokkee.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28203>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-612564280-1159735710=:14200
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 1 Oct 2006, Sebastian Harl wrote:

> When using "git cat-file tree <sha1>" to print a tree's content, it produces
> garbage output like the following:
> 
>   $ git cat-file -t c0cd1e4e1888be6a70d44476996ece8be1ab52a2
>   tree
>   $ git cat-file tree c0cd1e4e1888be6a70d44476996ece8be1ab52a2
>   100644 .gitignore%ëF7¦ùq¤¢«‚:“y—Ç½100644
>   COPYINGoø|Fd˜C—bW‘Èê;»_"y£40000 DocumentationŠ>Ý¢ÞÀŸçœ $ë#ºâü100755
>   GIT-VERSION-GEN
>   [...]
> 
> Using "git cat-file -p <sha1>" works fine.
> (The above example uses one of the latest commits of the git.git repository)

That is not a bug. "git cat-file tree <sha1>" produces the _exact_ 
contents of the object, while "-p" _pretty_-prints the contents.

Ciao,
Dscho

---1148973799-612564280-1159735710=:14200--
