From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-tar-tree: Lift path length limit
Date: Sat, 07 May 2005 11:42:55 -0700
Message-ID: <7vpsw2andc.fsf@assigned-by-dhcp.cox.net>
References: <20050507002527.GA5082@lsrfire.ath.cx>
	<20050507005706.GA6093@lsrfire.ath.cx>
	<20050507120935.GB9495@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 07 20:36:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUU9k-00035W-HW
	for gcvg-git@gmane.org; Sat, 07 May 2005 20:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbVEGSm7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 May 2005 14:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262739AbVEGSm7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 May 2005 14:42:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:50117 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262738AbVEGSm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2005 14:42:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050507184255.MPCG7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 7 May 2005 14:42:55 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050507120935.GB9495@pasky.ji.cz> (Petr Baudis's message of
 "Sat, 7 May 2005 14:09:35 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Dear diary, on Sat, May 07, 2005 at 02:57:06AM CEST, I got a letter
PB> where Rene Scharfe <rene.scharfe@lsrfire.ath.cx> told me that...
>> On Sat, May 07, 2005 at 02:25:27AM +0200, Rene Scharfe wrote:
>> > Last minute patch?
>> 
>> This leaks memory.  D'oh!
>> 
>> Petr, would you add the (hopefully) fixed version below to your tree now
>> that Linus is on vacation?  (Patch applies to tip of GIT tree.)

PB> It appears to me that the patch currently in the git tree is this
PB> (correct) one?

Yes it was merged before Linus left the machine last night.

