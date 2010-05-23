From: Bruce Stephens <bruce.stephens@isode.com>
Subject: Re: gitignore - how to ignore only in current directory
Date: Sun, 23 May 2010 21:33:44 +0100
Message-ID: <808w7a4atz.fsf@tiny.isode.net>
References: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Sun May 23 22:39:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHxj-0007hW-Ah
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0EWUjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 16:39:51 -0400
Received: from rufus.isode.com ([62.3.217.251]:35004 "EHLO rufus.isode.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab0EWUju (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:39:50 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 May 2010 16:39:50 EDT
Received: from tiny.isode.net (shiny.isode.com [62.3.217.250]) 
          by rufus.isode.com (submission channel) via TCP with ESMTPA 
          id <S=mRKABeGavA@rufus.isode.com>; Sun, 23 May 2010 21:33:46 +0100
Received: by tiny.isode.net (sSMTP sendmail emulation);
          Sun, 23 May 2010 21:33:44 +0100
X-Hashcash: 1:20:100523:git@vger.kernel.org::d2Ql5bo40lsj4kiZ:0000000000000000000000000000000000000000001/+y
X-Hashcash: 1:20:100523:howard@e-learndesign.co.uk::/P+VhKOABwk67HOk:000000000000000000000000000000000003x7b
In-Reply-To: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
	(Howard Miller's message of "Sun, 23 May 2010 21:28:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147586>

Howard Miller <howard@e-learndesign.co.uk> writes:

> I want to ignore a particular file name in a particular directory.
> However, the same filename may appear in subdirectories and in those
> cases I do *not* want it ignored. The documentation seems to imply
> that git will read up the directories looking for .gitignore files and
> will ignore files that I need included.

Make the pattern begin with /

[...]
