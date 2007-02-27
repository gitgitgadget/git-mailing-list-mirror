From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trivia: When did git self-host?
Date: Tue, 27 Feb 2007 01:02:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702270100360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 01:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLpo4-000435-Pu
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 01:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161413AbXB0AC4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 19:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161447AbXB0ACz
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 19:02:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:58727 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161413AbXB0ACz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 19:02:55 -0500
Received: (qmail invoked by alias); 27 Feb 2007 00:02:53 -0000
X-Provags-ID: V01U2FsdGVkX1/ceaxVsAzc0dCdCqwd3eQYpZuXgYsxqTN0SlEQ8U
	BDog==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <3c6c07c20702261551u55ec2ea7mde4075b1c929cf87@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40676>

Hi,

On Mon, 26 Feb 2007, Mike Coleman wrote:

> Does anyone recall when git first self-hosted?  This doesn't seem to be 
> present on the GitHistory page on the wiki, and I'm not finding it 
> elsewhere.

Hey, how about adding a trivia page there, with the information you get 
here?

> I suppose this could mean different things, but roughly I'm curious 
> about the earliest point at which all further commits were 
> human-generated, in real time, as opposed to the machine-generated 
> commits of some robo-import script.

The initial commit was v0.99~954, and it was not yet generated with 
git-commit, because it was not there:

$ git show v0.99~954:
tree v0.99~954:

Makefile
README
cache.h
cat-file.c
commit-tree.c
init-db.c
read-cache.c
read-tree.c
show-diff.c
update-cache.c
write-tree.c

Hth,
Dscho
