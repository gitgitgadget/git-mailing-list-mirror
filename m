From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Detect renames in diff family.
Date: Thu, 19 May 2005 11:47:28 -0700
Message-ID: <7voeb7yrwf.fsf@assigned-by-dhcp.cox.net>
References: <7vu0kz1p6k.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505190901340.2322@ppc970.osdl.org>
	<7v4qcz16n6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.62.0505191426000.20274@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 20:48:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYq3C-0001Li-P5
	for gcvg-git@gmane.org; Thu, 19 May 2005 20:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVESSrk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 May 2005 14:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVESSrk
	(ORCPT <rfc822;git-outgoing>); Thu, 19 May 2005 14:47:40 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:16796 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261219AbVESSrc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2005 14:47:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050519184730.CMYH7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 19 May 2005 14:47:30 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.62.0505191426000.20274@localhost.localdomain> (Nicolas
 Pitre's message of "Thu, 19 May 2005 14:29:46 -0400 (EDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "NP" == Nicolas Pitre <nico@cam.org> writes:

>> - I have been assuming that diff_delta uses its two input
>> read-only but have not verified that myself yet.

NP> It does.

Thanks (also thanks to Linus for pointing out the PROT_READ in
the test program).

