From: Sam Vilain <sam@vilain.net>
Subject: Re: Dropping Git.pm (at least Git.xs)?
Date: Mon, 11 Sep 2006 05:59:54 +1200
Message-ID: <4504529A.70401@vilain.net>
References: <7vodtxuqt4.fsf@assigned-by-dhcp.cox.net> <20060903150305.G50c94aea@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 20:02:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMTcr-0004Tc-Uq
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 20:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932343AbWIJSBr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 14:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbWIJSBr
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 14:01:47 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:14209 "EHLO
	watts.utsl.gen.nz") by vger.kernel.org with ESMTP id S932343AbWIJSBq
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 14:01:46 -0400
Received: by watts.utsl.gen.nz (Postfix, from userid 65534)
	id B52932D73; Mon, 11 Sep 2006 06:01:43 +1200 (NZST)
Received: from [127.0.0.1] (longdrop.watts.utsl.gen.nz [192.168.255.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by watts.utsl.gen.nz (Postfix) with ESMTP id E31F82D72;
	Mon, 11 Sep 2006 06:01:15 +1200 (NZST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
To: Dennis Stosberg <dennis@stosberg.net>
In-Reply-To: <20060903150305.G50c94aea@leonov.stosberg.net>
X-Enigmail-Version: 0.94.0.0
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	mail.watts.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26804>

Dennis Stosberg wrote:
> Having perl bindings to git internals and sometime in the future to a
> libified git is a great thing.  It will allow people to do interesting
> things, quickly trying concepts without having to write any C code.
> And I expect that gitweb can be sped up remarkably by using Git.pm (no
> forking, parsing of command output often not necessary, easy caching of
> frequently cached data across calls, etc)

FWIW, I have been starting on a perl implementation.  It uses the
Git.pm, but not for anything *that* important.  It's still very young,
but once I have reading and writing files basically working, I'll
release it to CPAN separately - no reason it needs to be distributed
with Git itself.

See http://utsl.gen.nz/gitweb/?p=VCS-Git

I used this design to talk about Moose at YAPC::Europe 2006.
http://utsl.gen.nz/talks/moose/start.html

Sam.
