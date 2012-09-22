From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: What are the ways CRLF files can make it into the repository?
Date: Sat, 22 Sep 2012 16:08:21 +0400
Message-ID: <20120922120821.GI32381@localhost.localdomain>
References: <505CB9B3.5010307@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Sep 22 14:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFOWB-0003SH-T7
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 14:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261Ab2IVMI1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 08:08:27 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60059 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931Ab2IVMI1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 08:08:27 -0400
Received: from proxysrv.domain007.com (localhost [10.8.0.42] (may be forged))
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q8MC8Mud027341;
	Sat, 22 Sep 2012 16:08:24 +0400
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id 0E80FB22E91; Sat, 22 Sep 2012 16:08:21 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <505CB9B3.5010307@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206203>

On Fri, Sep 21, 2012 at 01:02:11PM -0600, Joshua Jensen wrote:

> We've been running with core.autocrlf = input (some people with
> core.autocrlf = true).  However, there are some text files in the
> repository that are CRLF, and I am at a loss to explain how they go
> here.
> 
> We understand that if core.autocrlf=false, this could happen.  While
> I admit there is a remote possibility this did occur, I'm not
> convinced our people were smart enough with Git 1.5 years ago to
> make this configuration change.
> 
> There are no .gitattributes settings for these source code files.
> 
> Are there other ways CRLF files could sneak into the repository?
Is there any chance Git considered them binary for some reason and hence
did not apply its EOL-conversion logic at all?
