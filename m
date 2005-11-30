From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Wed, 30 Nov 2005 01:05:52 -0800
Message-ID: <7vr78yv72n.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<7vfypey573.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 13:09:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhNuZ-00035i-3a
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 10:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVK3JFz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 04:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVK3JFz
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 04:05:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:4821 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751150AbVK3JFy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 04:05:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130090508.SVCF20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 04:05:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vfypey573.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 Nov 2005 23:18:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12996>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Tue, 29 Nov 2005, Junio C Hamano wrote:
>>> 
>>> I have actually resolved one conflicting merge with this and it
>>> was OK, except that it was a bit unpleasant when I first did
>>> "git-diff-index HEAD" without giving any path ;-),
>>
>> What does "git-diff-files" do? Just output a lot of nasty "unmerged" 
>> messages?
>
> That was not what was unpleasant.  What was unpleasant was those
> "unmerged" messages were buried under heap of normal diffs,
> showing the successfully merged entries as the result of merge.
>
> I am inclined to munge your patch to do this:

This I have done, and pushed out to "pu" for tonight.  After
doing some more test I'll have this graduate to "master"
sometime tomorrow along with other accumulated changes.
