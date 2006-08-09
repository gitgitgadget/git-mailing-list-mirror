From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange output of git-diff-tree
Date: Wed, 09 Aug 2006 11:28:18 -0700
Message-ID: <7vbqqt4vct.fsf@assigned-by-dhcp.cox.net>
References: <ebcnml$btf$1@sea.gmane.org>
	<7vfyg54vjb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 09 20:28:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAsn7-0004yf-Tl
	for gcvg-git@gmane.org; Wed, 09 Aug 2006 20:28:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWHIS2V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Aug 2006 14:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbWHIS2V
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Aug 2006 14:28:21 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:29865 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751297AbWHIS2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Aug 2006 14:28:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060809182819.PGOE6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 9 Aug 2006 14:28:19 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vfyg54vjb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 09 Aug 2006 11:24:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25132>

Junio C Hamano <junkio@cox.net> writes:

> Jakub Narebski <jnareb@gmail.com> writes:
>
>> First (noticed by matled) is that for git-diff-tree with single tree
>> as an argument it outputs fist commit-id of commit given at input. 
>> It is not mentioned in documentation and I think totally unnecessary:
>>
>> 1038:jnareb@roke:~/git> git diff-tree --abbrev origin
>> d5dc6a76d49367cddc015e01d2e9aa22e64d7e28
>> :040000 040000 44fb36d... 1c26294... M  Documentation
>
> Working as specified as in the original version.  See
> core-tutorial and look for "git-diff-tree -p HEAD".

My mistake -- if you are talking about the first line that shows
the commit object name, I am not sure if this was from the
beginning or a recent slip-up.  Will need to look into it.

I thought you were talking about 1-argument diff-tree, sorry.
