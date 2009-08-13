From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [BUG] Submodules problem with subdirectories and pushing
Date: Thu, 13 Aug 2009 13:19:33 +0200
Message-ID: <20090813111933.GZ14475@mail-vs.djpig.de>
References: <20090813103231.GY14475@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 13 13:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbYLm-00077l-RT
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 13:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbZHMLTm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 07:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbZHMLTm
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 07:19:42 -0400
Received: from pauli.djpig.de ([78.46.38.139]:51716 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752399AbZHMLTl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 07:19:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id 69BDC9007F
	for <git@vger.kernel.org>; Thu, 13 Aug 2009 13:19:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZjKEOHOiLnm for <git@vger.kernel.org>;
	Thu, 13 Aug 2009 13:19:33 +0200 (CEST)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id DB4309007D
	for <git@vger.kernel.org>; Thu, 13 Aug 2009 13:19:33 +0200 (CEST)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.69)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1MbYLF-00038o-Ou
	for git@vger.kernel.org; Thu, 13 Aug 2009 13:19:33 +0200
Content-Disposition: inline
In-Reply-To: <20090813103231.GY14475@mail-vs.djpig.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125802>

On Thu, Aug 13, 2009 at 12:32:31PM +0200, Frank Lichtenheld wrote:
> Hi.
> 
> I have a git repository where I include several submodules. This seemed to
> work fine until the server I push to got (finally) updated from 1.5.something
> to 1.6.4. Now I get an error if I try to push.
> 
> The issue is easily reproducible with a minimal repository for me:
> 
> Creating an empty repository on server:
> 
> flichtenheld@git-test:~$ git version
> git version 1.6.4    <---- Directly compiled from git
> flichtenheld@git-test:~$ mkdir test.git
> flichtenheld@git-test:~$ cd test.git/
> flichtenheld@git-test:~/test.git$ git init --bare
> Initialized empty Git repository in /home/flichtenheld/test.git/

Here is a "git config receive.fsckObjects true" missing. I have
this in my default config, and without it the error will not be
triggered.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
