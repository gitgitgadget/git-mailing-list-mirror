From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: corrupted repository?
Date: Thu, 2 Oct 2008 07:29:52 -0700
Message-ID: <20081002142952.GP21310@spearce.org>
References: <48E3EBC2.7090107@cs.mcgill.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Francois Pepin <fpepin@cs.mcgill.ca>
X-From: git-owner@vger.kernel.org Thu Oct 02 16:31:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlPCp-0002NK-UW
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 16:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753516AbYJBO3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbYJBO3y
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 10:29:54 -0400
Received: from george.spearce.org ([209.20.77.23]:57439 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751949AbYJBO3x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 10:29:53 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C38E63835F; Thu,  2 Oct 2008 14:29:52 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48E3EBC2.7090107@cs.mcgill.ca>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97342>

Francois Pepin <fpepin@cs.mcgill.ca> wrote:
> Everything seems to be working properly there (git fsck --full returns  
> normally with no output), but I cannot clone or pull from my other 
> machines:
...
> [francois@Iduna ~]$ git clone localhost:git git2
> Initialized empty Git repository in /Users/francois/git2/.git/
> remote: fatal: exec pack-objects failed.

Your git-upload-pack cannot find git-pack-objects.  It sounds like
Git was incorrectly installed on your system.

  which git-upload-pack ?
  which git ?
  are they in the same directory?
  did you possibly move git after installing it?

  git --exec-path?
  does that exist?
  does it have git-pack-objects inside it?

> I am running git 1.6.0.2 on the mac, and have only recently updated it  
> so that might have a role to play.

I think it is the upgrade.  It sounds like its not installed correcly
because the helpers in libexec/git-core cannot be found.

-- 
Shawn.
