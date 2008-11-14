From: "Lars Hoss" <lars@woeye.net>
Subject: Re: getting started with git
Date: Fri, 14 Nov 2008 15:29:45 +0100 (CET)
Message-ID: <fc0c0c65f69439eede2e4565c5f930fd.squirrel@webmail.highteq.net>
References: <20497802.post@talk.nabble.com>
    <1a6be5fa0811140456j10fd8703w74e485571e3c70af@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Ivan Senji" <ivan.senji@gmail.com>, git@vger.kernel.org
To: "Tor Arvid Lund" <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 15:26:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0zck-0006Yv-5J
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 15:26:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751192AbYKNOY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 09:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbYKNOY6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 09:24:58 -0500
Received: from mail.codewut.de ([78.47.135.140]:48481 "EHLO mail.codewut.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbYKNOY5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 09:24:57 -0500
Received: by mail.codewut.de (Postfix, from userid 65534)
	id 13FA57BF44; Fri, 14 Nov 2008 15:29:47 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on mail.codewut.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb
Received: from webmail.highteq.net (web.highteq.net [78.47.135.138])
	by mail.codewut.de (Postfix) with ESMTP id 85D737BEAF;
	Fri, 14 Nov 2008 15:29:45 +0100 (CET)
Received: from 194.127.8.17
        (SquirrelMail authenticated user lars)
        by webmail.highteq.net with HTTP;
        Fri, 14 Nov 2008 15:29:45 +0100 (CET)
In-Reply-To: <1a6be5fa0811140456j10fd8703w74e485571e3c70af@mail.gmail.com>
User-Agent: SquirrelMail/1.4.15
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100976>

>
> Well, if it were me, I think I would commit that eclipse config file
> under a different name... Say, ".classpath.defaults" instead of
> ".classpath". Then your README file could tell your users to start by
> copying the .classpath.defaults to .classpath, and update its contents
> as necessary. Put .classpath in your .gitignore file, so it won't be
> committed to the repository.

Template files (x.default) is a good idea. But regarding your example
with .classpath: it's safe to add it to git since it's developer
independent and project oriented. Therefore it's useful for every
developer in the project who uses eclipse :-)

Yours,
Lars
