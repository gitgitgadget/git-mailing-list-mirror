From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: How to make public repository GIT_DIR=my-git.git git-init
	Command not found.
Date: Tue, 18 Nov 2008 15:19:25 -0800
Message-ID: <20081118231925.GW2932@spearce.org>
References: <138223.4849.qm@web37905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gary Yang <garyyang6@yahoo.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 00:20:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Zs8-0007DL-VV
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 00:20:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbYKRXT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 18:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752086AbYKRXT0
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 18:19:26 -0500
Received: from george.spearce.org ([209.20.77.23]:52595 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752005AbYKRXT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 18:19:26 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 790BA381FF; Tue, 18 Nov 2008 23:19:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <138223.4849.qm@web37905.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101293>

Gary Yang <garyyang6@yahoo.com> wrote:
> Hi,
> 
> I want to make a public repository. I followed the instructions in gitcore-tutorial. I typed "GIT_DIR=my-git.git git init" per instruction. But, I got command not found. I do not think this is the correct command. How should I do? I use C-Shell.
> 
> http://manpages.ubuntu.com/manpages/intrepid/man7/gitcore-tutorial.html
> 
> %mkdir my-git.git
> %GIT_DIR=my-git.git git init
> 
> GIT_DIR=my-git.git: Command not found.

Instead you can do:

  $ git --git-dir=my-git.git init

The --git-dir option does the same thing that GIT_DIR= was doing
in a Bourne shell.

-- 
Shawn.
