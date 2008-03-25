From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH 1/7] cvsserver: Respond to the 'editors' command
Date: Tue, 25 Mar 2008 10:03:07 +0100
Message-ID: <20080325090306.GM25732@mail-vs.djpig.de>
References: <cover.1206393086.git.dash@foobox.net> <8cb3f0ef415bdfe8a25f89fdac3d14d3b8360dcf.1206393086.git.dash@foobox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin@catalyst.net.nz>, git@vger.kernel.org
To: Damien Diederen <dash@foobox.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 10:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je54h-0000zW-0Y
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 10:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbYCYJDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 05:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbYCYJDZ
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 05:03:25 -0400
Received: from pauli.djpig.de ([78.46.38.139]:46622 "EHLO pauli.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751953AbYCYJDY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 05:03:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by pauli.djpig.de (Postfix) with ESMTP id EAC9290073;
	Tue, 25 Mar 2008 10:03:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at pauli.djpig.de
Received: from pauli.djpig.de ([127.0.0.1])
	by localhost (pauli.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ehPUjUc4FjEV; Tue, 25 Mar 2008 10:03:09 +0100 (CET)
Received: from mail-vs.djpig.de (mail-vs.djpig.de [78.47.136.189])
	by pauli.djpig.de (Postfix) with ESMTP id 59A8F9006E;
	Tue, 25 Mar 2008 10:03:09 +0100 (CET)
Received: from djpig by mail-vs.djpig.de with local (Exim 4.63)
	(envelope-from <djpig@mail-vs.djpig.de>)
	id 1Je53j-0004rt-5q; Tue, 25 Mar 2008 10:03:07 +0100
Content-Disposition: inline
In-Reply-To: <8cb3f0ef415bdfe8a25f89fdac3d14d3b8360dcf.1206393086.git.dash@foobox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78162>

On Mon, Mar 24, 2008 at 11:48:52PM +0100, Damien Diederen wrote:
> "Cvs editors" lists the users currently working on watched (locked)
> files.  This trivial implementation always returns an empty response,
> since git-cvsserver does not implement file locking.

It might be nicer to name the function something like req_dummy_response
and use it for (at least) editors and watchers commands.

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
