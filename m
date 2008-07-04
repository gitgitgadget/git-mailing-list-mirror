From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: can I configure git clone to preserve the '.git' when it makes
	the initial dir
Date: Sat, 5 Jul 2008 01:22:41 +0200
Message-ID: <20080704232241.GD28515@leksak.fem-net>
References: <p06240819c49453b4beda@[192.168.1.105]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Bannasch <stephen.bannasch@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 01:23:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEudA-00074y-5Y
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 01:23:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbYGDXWx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 19:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751533AbYGDXWw
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 19:22:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:33218 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751416AbYGDXWw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 19:22:52 -0400
Received: (qmail invoked by alias); 04 Jul 2008 23:22:50 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp043) with SMTP; 05 Jul 2008 01:22:50 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+9wb1zsX69ecEw9Ch4oUZ5Mpg53qWHrQR4Peppll
	+JswyRb9EMXZMr
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KEubx-0005Aj-Md; Sat, 05 Jul 2008 01:22:41 +0200
Content-Disposition: inline
In-Reply-To: <p06240819c49453b4beda@[192.168.1.105]>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87424>

Hi,

Stephen Bannasch wrote:
> As I'm moving to more use of git I find it very helpful to keep the  
> '.git' suffix on the names of directories in which I have git  
> repositories. This makes it easier to distinguish between checkouts  
> using different SCMs.

When you finally fall in love with git, you won't want to
use another SCM. :)
Even, if you have to, there is git-cvs{exportcommit,import}, git-svn,
and some other more or less working interfaces from git to other SCMs.

Perhaps it's also worth having a look at http://kitenet.net/~joey/code/mr/
(I've never used it, but heard of people who like using it.)

> Is there a way to configure git clone to preserve the '.git' suffix when 
> creating a directory?

I don't know a configuration for that, but you can simply do:
	git clone <repository> <reponame>.git
(e.g.	git clone git://example.com/foo.git foo.git)

But, btw, I think some unofficial convention is, that the ".git" suffix
indicates a bare repository and without that suffix it is a checked out
working tree.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
