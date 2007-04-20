From: Olivier Galibert <galibert@pobox.com>
Subject: Re: How to make a repository config up-to-date
Date: Fri, 20 Apr 2007 14:34:55 +0200
Message-ID: <20070420123455.GA62110@dspnet.fr.eu.org>
References: <20070419234532.GA38838@dspnet.fr.eu.org> <7v7is76h8c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 14:35:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HesKk-0002OU-Lg
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 14:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992588AbXDTMe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 08:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992592AbXDTMe7
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 08:34:59 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:2998 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992588AbXDTMe7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 08:34:59 -0400
Received: by dspnet.fr.eu.org (Postfix, from userid 1007)
	id CEAB6A3601; Fri, 20 Apr 2007 14:34:55 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v7is76h8c.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45096>

On Thu, Apr 19, 2007 at 05:07:31PM -0700, Junio C Hamano wrote:
> A better question to ask before that is "do I need to change to
> take advantage of any bells-and-whistles", I think.

Indeed.


> * To enable reflog in your repository with working-tree, you do
>   not have to do anything.  It's on by default.

Ah nice :-)


> * $GIT_DIR/remotes/origin is still consulted for a pull/fetch.
>   If you do not do complicated multi-branch workflow, you do not
>   gain much by moving that information to .git/config.
> 
> There is a contrib/remotes2config.sh script that copies
> information from remotes/origin into .git/config if you are
> interested.

Excellent, I'll check the result and decide whether it seems worth it.

  OG.
