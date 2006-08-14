From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/9] gitweb: Great subroutines renaming
Date: Mon, 14 Aug 2006 16:28:11 -0700
Message-ID: <7v8xlqdhis.fsf@assigned-by-dhcp.cox.net>
References: <200608140202.46160.jnareb@gmail.com>
	<200608140205.47380.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClqy-0002ut-7Q
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965056AbWHNX2N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965060AbWHNX2N
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:28:13 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43906 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S965056AbWHNX2M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:28:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814232812.HOPZ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 19:28:12 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608140205.47380.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 14 Aug 2006 02:05:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25423>

Jakub Narebski <jnareb@gmail.com> writes:

> I'm not sure if to add script used to create this commit, and to
> port changes to be "post-rename". Here it is:
>
> #!/bin/bash
> if test -z "$1"; then
> 	FILE=`git rev-parse --show-cdup`gitweb/gitweb.perl
> else
> 	FILE=$1
> fi
> echo "Great subroutine renaming: $FILE"
> perl -s -p -i.re~ \
> 	-e 's/\bgit_get_referencing\b/format_ref_marker/;' \

Will apply, but I suspect all of these need g at the end as in
"s/foo/bar/g;".
