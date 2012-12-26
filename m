From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: generating format-patch options from an e-mail
Date: Wed, 26 Dec 2012 21:06:23 +0100
Message-ID: <20121226200623.GA29446@simaj.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 26 21:06:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnxFV-0003Yj-12
	for gcvg-git-2@plane.gmane.org; Wed, 26 Dec 2012 21:06:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab2LZUG0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 15:06:26 -0500
Received: from simaj.xs4all.nl ([83.160.71.26]:48529 "EHLO simaj.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab2LZUGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 15:06:25 -0500
Received: by simaj.xs4all.nl (Postfix, from userid 1000)
	id 059C740C7B; Wed, 26 Dec 2012 21:06:23 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212147>

Hi all

I've been very frustrated by the process to setup a commandline for git format-patch, to include everyone in the cc list and reply to the right message-id.

In my frustration I created a perl script to generate the options from a saved e-mail, I realise that it may be non-general and perhaps it could be written better using a module which understands e-mails, but well, it worked for me ;-)

Anyway, I could imagine this as optional flag of git format-patch, so you could say:
$ git format-patch -s --in-reply-to-email <mboxfile> a7fe7de8

But I'll save that as an exercise for the reader (or the future)

Cheers

Simon
