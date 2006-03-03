From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] cg-mv doesn't work with bash 3.1.7 due to excessive quotes
Date: Thu, 02 Mar 2006 21:27:39 -0800
Message-ID: <7vbqwo3xo4.fsf@assigned-by-dhcp.cox.net>
References: <20060303011154.14619.71590.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 06:27:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF2pN-00030I-DX
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 06:27:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWCCF1m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 00:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWCCF1m
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 00:27:42 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53461 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750858AbWCCF1m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Mar 2006 00:27:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060303052747.CNB25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Mar 2006 00:27:47 -0500
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060303011154.14619.71590.stgit@dv.roinet.com> (Pavel Roskin's
	message of "Thu, 02 Mar 2006 20:11:54 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17136>

Pavel Roskin <proski@gnu.org> writes:

> -	ARGS2["${#ARGS2[@]}"]="$_git_relpath${arg%/}"
> +	ARGS2[${#ARGS2[@]}]="$_git_relpath${arg%/}"

Is this an application bug?  It looks like a workaround for a
bug in the shell...

Not that I care too much either way -- I do not use shell arrays
myself ;-).
