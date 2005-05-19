From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Thu, 19 May 2005 09:40:07 +0200
Message-ID: <20050519074007.GI4738@cip.informatik.uni-erlangen.de>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz> <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net> <20050517203500.GH7136@pasky.ji.cz> <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net> <20050517213752.GO7136@pasky.ji.cz> <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net> <20050518213309.GD10358@pasky.ji.cz> <7vekc4nom5.fsf@assigned-by-dhcp.cox.net> <20050518232408.GA18281@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu May 19 09:40:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYfd1-0008JI-Vf
	for gcvg-git@gmane.org; Thu, 19 May 2005 09:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVESHkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 03:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVESHkO
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 03:40:14 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:44760 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262440AbVESHkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 03:40:08 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4J7e7S8027259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 19 May 2005 07:40:07 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4J7e7nK027258
	for git@vger.kernel.org; Thu, 19 May 2005 09:40:07 +0200 (CEST)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050518232408.GA18281@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> > <http://members.cox.net/junkio/per-file-commit.txt> ;-).

> I think the workflow that involves per-file commit is
> fundamentally broken at two levels.

I disagree here. We at FAUmachine often have FLAGS to turn on specific
features or debugging output by tweaking a headerfile. However we commit
often and work in small steps (at the moment using CVS because every
developer has write access). And we definitely don't want to tweak the
header file every time we commit, so I often do a:

cvs diff > diff
vim diff
lsdiff diff
cvs commit <interesting files here>

	Thomas
