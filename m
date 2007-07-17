From: Thomas Glanzmann <thomas@glanzmann.de>
Subject: Re: Update a bare repository
Date: Tue, 17 Jul 2007 09:41:12 +0200
Message-ID: <20070717074112.GH5823@cip.informatik.uni-erlangen.de>
References: <20070717063026.GA5823@cip.informatik.uni-erlangen.de> <20070717070428.GA13266@coredump.intra.peff.net> <20070717072635.GG5823@cip.informatik.uni-erlangen.de> <20070717073115.GA14629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 17 09:41:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAhgi-0005LG-K9
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 09:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754402AbXGQHlO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jul 2007 03:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754325AbXGQHlO
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 03:41:14 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:33466 "EHLO
	faui03.informatik.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754299AbXGQHlN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jul 2007 03:41:13 -0400
Received: by faui03.informatik.uni-erlangen.de (Postfix, from userid 31401)
	id B49703F42C; Tue, 17 Jul 2007 09:41:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070717073115.GA14629@coredump.intra.peff.net>
User-Agent: Mutt/1.5.15 (2007-05-02)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52746>

Hello Peff,

> echo "echo Sorry, no pushing allowed.; exit 1" >.git/hooks/pre-receive
> chmod +x .git/hooks/pre-receive

thank you, that does exactly what I wanted:

	(faui03) [/var/tmp/git] git commit -a
	Created commit 9e89d1d: added some whitespace
	1 files changed, 1 insertions(+), 0 deletions(-)
	(faui03) [/var/tmp/git] git push origin
	updating 'refs/heads/master'
	from 9dfdf14b3805e89aa2782458bda15b3dfae24c09
	to   9e89d1d3890c6b0fd8546143a6e797820e274cb1
	Generating pack...
	Done counting 5 objects.
	Result has 3 objects.
	Deltifying 3 objects...
	100% (3/3) done
	Writing 3 objects...
	100% (3/3) done
	Total 3 (delta 2), reused 0 (delta 0)
	Sorry, no pushing allowed.
	error: hooks/pre-receive exited with error code 1
	ng refs/heads/master pre-receive hook declined
	error: failed to push to '131.188.30.103:/home/cip/adm/sithglan/work/repositories/mirror/git.git'

		Thomas
