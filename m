From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-completion.bash missing --help
Date: Mon, 5 Jan 2009 20:37:08 -0800
Message-ID: <20090106043708.GA29462@spearce.org>
References: <877i59nmd1.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 06 05:38:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK3i5-0008Sh-G9
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 05:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbZAFEhK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2009 23:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752151AbZAFEhK
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jan 2009 23:37:10 -0500
Received: from george.spearce.org ([209.20.77.23]:39714 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZAFEhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2009 23:37:09 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id B132A38210; Tue,  6 Jan 2009 04:37:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <877i59nmd1.fsf@jidanni.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104635>

jidanni@jidanni.org wrote:
> git-completion.bash seems to be missing --help. Hitting TAB just shows e.g.,
> $ git add --<TAB>
> --dry-run --ignore-errors --interactive --patch --refresh --update
> Only for plain
> $ git --<TAB>
> is one able to complete --help.

Adding completion for --help to every command we have long option
completion on is just annoying.

Doesn't it complete "git he<TAB> ad<TAB>"?

-- 
Shawn.
