From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [PATCH] Add a guilt-export(1) command to export a guilt series to quilt.
Date: Wed, 13 Jun 2007 11:54:54 -0400
Message-ID: <20070613155454.GC18989@filer.fsl.cs.sunysb.edu>
References: <1181743313509-git-send-email-madcoder@debian.org> <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Benjamin Sergeant <bsergean@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyVBS-0003by-OX
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:54:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757738AbXFMPy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757958AbXFMPy5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:54:57 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:48008 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496AbXFMPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:54:56 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5DFssTO019696;
	Wed, 13 Jun 2007 11:54:54 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5DFsso8019694;
	Wed, 13 Jun 2007 11:54:54 -0400
Content-Disposition: inline
In-Reply-To: <1621f9fa0706130810n17bc3f67h1c539d75b3aed4ed@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50081>

On Wed, Jun 13, 2007 at 08:10:36AM -0700, Benjamin Sergeant wrote:
> For the shebang:
> #!/usr/bin/env bash
> should works well and should work on non-linux boxes that did not
> added a link in /bin/bash.
 
Ideally, the best thing to do is to change guilt to use /bin/sh. Right now,
there are a number of bash-isms that are used. And if a system doesn't have
/bin/sh, it doesn't deserve to run any useful software ;)

Patches are welcomed ;)

Josef "Jeff" Sipek.

-- 
Reality is merely an illusion, albeit a very persistent one.
		- Albert Einstein
