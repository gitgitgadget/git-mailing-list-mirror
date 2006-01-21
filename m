From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] AsciiDoc fixes for the git-svnimport manpage
Date: Sat, 21 Jan 2006 11:24:59 -0800
Message-ID: <7vslrho038.fsf@assigned-by-dhcp.cox.net>
References: <E1F0O43-0002pn-7O@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:25:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OMJ-0002Vh-ME
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbWAUTZE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWAUTZD
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:25:03 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44214 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932261AbWAUTZB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:25:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121192505.FSWC25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 14:25:05 -0500
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <E1F0O43-0002pn-7O@mid.deneb.enyo.de> (Florian Weimer's message
	of "Sat, 21 Jan 2006 20:06:19 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15006>

Florian Weimer <fw@deneb.enyo.de> writes:

> Change "SVN:: Perl" to "SVN::Perl", wrap a long line, and clean up the
> description of positional arguments.

Thanks.  Is this the part you mean by "positional arguments"?

> -<SVN_repository_URL>::
> -	The URL of the SVN module you want to import. For local
> -	repositories, use "file:///absolute/path".
> -
> -<path>
> +<path>::
>  	The path to the module you want to check out.

This looks to me as if we do not allow non file:/// URL like
svn:// anymore, or we never supported it but the documentation
pretended we did.  Is that what you intended to fix?

I am a bit confused...
