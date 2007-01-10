From: Yann Dirson <ydirson@altern.org>
Subject: Re: suggestions about stgit commands renaming
Date: Wed, 10 Jan 2007 20:52:12 +0100
Message-ID: <20070110195212.GH17093@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070108220918.18329.30083.stgit@gandelf.nowhere.earth> <b0943d9e0701090202v7951076cg7c86c0f5499c7d60@mail.gmail.com> <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 10 21:12:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4jnj-00067V-Tk
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 21:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965071AbXAJUL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbXAJUL4
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 15:11:56 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:39892 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965071AbXAJUL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 15:11:56 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 6AC61589F;
	Wed, 10 Jan 2007 21:11:54 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D8AA81F0A3; Wed, 10 Jan 2007 20:52:12 +0100 (CET)
To: Catalin Marinas <catalin.marinas@gmail.com>
Content-Disposition: inline
In-Reply-To: <20070109220332.GD17093@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36527>

On Tue, Jan 09, 2007 at 11:03:32PM +0100, Yann Dirson wrote:
> Maybe some restucturing of commands is called for.  One possibility
> would be to go with prefixes (eg. ppush, pshow), but that does not
> address the sub-commands issue, which would have to be dealt with
> another way, possibly by multiplying commands (branch -> blist,
> bcreate, etc), which I'm not very fond of.
> 
> Another would be to generalize command groups, and acknowledge
> subcommands as such.  Eg:
> 
> stg branch --create		-> stg branch create
> stg show			-> stg patch show
> stg push			-> stg patch push
> 
> 
> The latter obviously suggests that some would want to keep "stg push"
> as an alias (here comes again the idea of programable aliases like we
> already have for GIT.

Thinking twice, the current "shortcut prefix" mechanism would already
allow us to use shortcuts like "stg p show" and "stg b create".
