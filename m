From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 01 Feb 2006 12:01:36 -0800
Message-ID: <7v3bj2df1b.fsf@assigned-by-dhcp.cox.net>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
	<20060201042930.GV16557@redhat.com>
	<cc723f590601312041o1dc594c7t69418b735ef29ee@mail.gmail.com>
	<cc723f590602010328w7b4a7befr40a76620e197d00c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dave Jones <davej@redhat.com>, git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Feb 01 21:02:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4OAj-0005It-2P
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:01:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWBAUBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWBAUBl
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:01:41 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48310 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422908AbWBAUBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 15:01:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201200033.OWBD15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 15:00:33 -0500
To: Aneesh Kumar <aneesh.kumar@gmail.com>
In-Reply-To: <cc723f590602010328w7b4a7befr40a76620e197d00c@mail.gmail.com>
	(Aneesh Kumar's message of "Wed, 1 Feb 2006 16:58:32 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15438>

Aneesh Kumar <aneesh.kumar@gmail.com> writes:

> for parent_id in  parent_sha1 parent_sha2 parent_sha3 .......
> commit_diff = commit_diff + git diff tree -p parent_id commit_sha1
>
> is this the correct way ?

Are parent_sha$N true parents of commit_sha1?  If you want to
get three independent diffs, "git diff-tree -m -p $commit_sha1"
would give that to you in one go.
