From: Junio C Hamano <junkio@cox.net>
Subject: Re: files are disappearing in git
Date: Thu, 24 Nov 2005 01:15:13 -0800
Message-ID: <7vfypmwgny.fsf@assigned-by-dhcp.cox.net>
References: <20051123142303.GJ22568@schottelius.org>
	<Pine.LNX.4.64.0511230917130.13959@g5.osdl.org>
	<20051124084633.GA3361@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 10:17:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfDCZ-0000ak-8C
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 10:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVKXJPR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 04:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVKXJPQ
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 04:15:16 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:25062 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932548AbVKXJPP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 04:15:15 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051124091359.HPES17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 24 Nov 2005 04:13:59 -0500
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051124084633.GA3361@schottelius.org>
	(nico-linux-git@schottelius.org's message of "Thu, 24 Nov 2005
	09:46:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12698>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> Linus Torvalds [Wed, Nov 23, 2005 at 09:20:28AM -0800]:
>> On Wed, 23 Nov 2005, Nico -telmich- Schottelius wrote:
>>...
>> I bet somebody just messed up the index before that commit.
>
> What would be the best things to corrupt the index?
> Our developers here do the following each day:
>
> - cg-update
> - <work>
> - cg-commit
> - cg-update + merge if there are changes
> - cg-push origin

Was any of the CG:F line changed/removed by the developer during
cg-commit?

Does any of the files under Code/Spikes/Statistik/ have funny
characters in their pathnames?
