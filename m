From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fmt-merge-msg: detached HEAD
Date: Fri, 26 Jan 2007 15:45:59 -0800
Message-ID: <7v64atuzbc.fsf@assigned-by-dhcp.cox.net>
References: <87zm875d9u.fsf@gmail.com>
	<7vireu63rg.fsf@assigned-by-dhcp.cox.net>
	<8aa486160701260145i4c50d564n90967a07f7ee62a9@mail.gmail.com>
	<7vveiuyup7.fsf@assigned-by-dhcp.cox.net>
	<8aa486160701260215p6a0af653qf110aa2679452c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAalj-0007by-6Y
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:46:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752187AbXAZXqD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 26 Jan 2007 18:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXAZXqD
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:46:03 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:61092 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXAZXqB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jan 2007 18:46:01 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126234600.GOAA18767.fed1rmmtao09.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 18:46:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fzl21W00R1kojtg0000000; Fri, 26 Jan 2007 18:45:03 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37900>

"Santi B=E9jar" <sbejar@gmail.com> writes:

>> > For me, 'Merge ... into master' and 'Merge ... into HEAD' are equa=
lly
>> > useful, so do not show them by default. And git always merges into
>> > HEAD.
>>
>> I was wondering if people might prefer rewording it to "into
>> detached HEAD".
>
> I prefer my patch, but your rewording is OK also.

I do not personally care either way -- the question is "is
merging while your head is detached a major deal, or is it just
one of the random insignificant merges and it does not matter
where it happened?"
