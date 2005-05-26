From: Junio C Hamano <junkio@cox.net>
Subject: Re: git full diff output issues..
Date: Thu, 26 May 2005 14:33:40 -0700
Message-ID: <7vis15aczv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261214140.2307@ppc970.osdl.org>
	<Pine.LNX.4.58.0505261223240.2307@ppc970.osdl.org>
	<Pine.LNX.4.60.0505262036500.16829@hermes-1.csi.cam.ac.uk>
	<Pine.LNX.4.58.0505261316250.2307@ppc970.osdl.org>
	<7v64x5bt9n.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505261402470.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Altaparmakov <aia21@cam.ac.uk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:38:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbQ2y-0003D8-88
	for gcvg-git@gmane.org; Thu, 26 May 2005 23:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261767AbVEZVi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 May 2005 17:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVEZVgF
	(ORCPT <rfc822;git-outgoing>); Thu, 26 May 2005 17:36:05 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:42659 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261796AbVEZVdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2005 17:33:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050526213340.VHCJ22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 May 2005 17:33:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505261402470.2307@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 26 May 2005 14:09:31 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> On Thu, 26 May 2005, Junio C Hamano wrote:
>> 
>> So what do you want from me at this point?  Nothing?

LT> Yeah, I'm happy. Sorry for the false alarm.

No problem.  I still kinda like Anton's proposal for conceptual
cleanness, but if the tool can cope with what we already have
then less cluttering in the output is better for human eyes.

Let me again remind you about git-external-diff-script patch.
When you encounter more gotcha in the built-in diff output
format in the future, it would be a valuable tool to experiment
and express what you would like to have git-apply to parse.

