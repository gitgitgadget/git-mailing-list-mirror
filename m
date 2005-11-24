From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH 1/3] git-find-git: a new helper.
Date: Wed, 23 Nov 2005 22:21:11 -0800
Message-ID: <7viruiy3ag.fsf@assigned-by-dhcp.cox.net>
References: <7vmzjuzphl.fsf@assigned-by-dhcp.cox.net>
	<4385528D.7010203@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 07:27:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfATr-0006yn-M5
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 07:21:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161015AbVKXGVN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 01:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161017AbVKXGVN
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 01:21:13 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:63675 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1161015AbVKXGVM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 01:21:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124062031.GFFA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 01:20:31 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <4385528D.7010203@yahoo.it> (Marco Costalba's message of "Thu, 24
	Nov 2005 06:41:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12678>

Marco Costalba <mcostalba@yahoo.it> writes:

> Junio C Hamano wrote:
>
>>  git-find-git uses it to find the
>> top-level, and if it was run from a subdirectory, outputs shell
>> script fragments that can be evaled to define the two variables:
>>     GIT_DIR_PREFIX is a string to be prepended to cwd relative
>>     paths to make them repository relative.
>>     GIT_DIR_UPLEVEL is a string (e.g. "../") for the command to
>>     use to cd to the top-level of repository.
>>
> Sounds very good.
>
> I did't had the time to test it but I think I can now
> easily update qgit to run from a subdirectory with this new helper.

The helper might be good, but it turns out that the idea of
using it from git-sh-setup was not that great, so please
disregard the third part of the patch.  I think I need a bit
more thinking about this.
