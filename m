From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-revert with conflicts to behave as git-merge with conflicts
Date: Thu, 12 Oct 2006 17:07:57 -0700
Message-ID: <7vvempjcwy.fsf@assigned-by-dhcp.cox.net>
References: <20061012231503.78452.qmail@web31803.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 02:08:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYAao-0002Cw-0V
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 02:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWJMAH7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 20:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbWJMAH7
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 20:07:59 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:50393 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751358AbWJMAH6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 20:07:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013000758.WBQJ12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Thu, 12 Oct 2006 20:07:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Zc7n1V0081kojtg0000000
	Thu, 12 Oct 2006 20:07:47 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20061012231503.78452.qmail@web31803.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 12 Oct 2006 16:15:03 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28822>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> If you rely on MERGE_MSG then you would need to clean it after
>> commit is done.  Currently it does not and checks MERGE_HEAD,
>> and cleans up MERGE_HEAD when it is done.  MERGE_MSG is not
>> cleaned.
>
> It is cleaned in the lines of the patch you deleted, the section
> just after the "elif" above:

Ok, so I can apply that original one with your 'Oops' rolled
into one patch?
