From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] commit-tree: disallow an empty single-parent commit.
Date: Fri, 24 Feb 2006 05:58:34 -0700
Message-ID: <m1y800dibp.fsf@ebiederm.dsl.xmission.com>
References: <m1slqahyxt.fsf@ebiederm.dsl.xmission.com>
	<7v1wxtgv02.fsf@assigned-by-dhcp.cox.net>
	<m18xs1dmp3.fsf@ebiederm.dsl.xmission.com>
	<7vy8019d44.fsf@assigned-by-dhcp.cox.net>
	<7vslq99cd5.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ebiederm@xmission.com (Eric W. Biederman), git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 24 14:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCcXv-0004XW-Sg
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 13:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWBXM7k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 07:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBXM7k
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 07:59:40 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63651 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750875AbWBXM7k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 07:59:40 -0500
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k1OCwZ4P024455;
	Fri, 24 Feb 2006 05:58:35 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k1OCwZed024454;
	Fri, 24 Feb 2006 05:58:35 -0700
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslq99cd5.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Fri, 24 Feb 2006 04:20:54 -0800")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16699>

Junio C Hamano <junkio@cox.net> writes:

> Allow "git-commit-tree v2.6.15^{tree} -p HEAD", instead of
> requiring "git-commit-tree `git rev-parse v2.6.15^{tree}` -p
> HEAD".  The parent parameter that follows -p uses get_sha1() to
> understand the extended notation, and there is little reason not
> to allow it for the tree object name parameter.
>
> Also make the check_valid() function simpler.  This function
> which predates sha1_object_info() so it had to do things by hand
> but there is no reason to read the data just to discard anymore.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>

Looks good to me. The logic at least looks complete.

Eric
