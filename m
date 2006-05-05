From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] binary patch.
Date: Thu, 04 May 2006 23:47:54 -0700
Message-ID: <7vwtd10xyd.fsf@assigned-by-dhcp.cox.net>
References: <7vodyd2vqn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 05 08:48:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fbu6a-0002hA-0T
	for gcvg-git@gmane.org; Fri, 05 May 2006 08:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWEEGr4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 May 2006 02:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWEEGr4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 May 2006 02:47:56 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:3798 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751533AbWEEGrz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 May 2006 02:47:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060505064755.HREI21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 5 May 2006 02:47:55 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0605042241240.28543@localhost.localdomain>
	(Nicolas Pitre's message of "Thu, 04 May 2006 22:47:29 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19602>

Nicolas Pitre <nico@cam.org> writes:

> On Thu, 4 May 2006, Junio C Hamano wrote:
>
>> This adds "binary patch" to the diff output and teaches apply
>> what to do with them.
>
> This is nice.
>
> However I'd deflate the delta data before encoding it with base85.

Yeah, things still to be done are deflating both delta and
optionally perhaps use just deflate without delta for "new file"
codepath.

And testsuite.
