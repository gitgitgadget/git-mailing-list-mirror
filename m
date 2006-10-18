From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-imap-send: Strip smtp From_ header from imap message.
Date: Wed, 18 Oct 2006 03:28:11 -0700
Message-ID: <7vejt53olg.fsf@assigned-by-dhcp.cox.net>
References: <452EBF77.7040301@oribi.org>
	<7vlknegnwk.fsf@assigned-by-dhcp.cox.net>
	<45367A5F.7060507@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Markus Amsler <markus.amsler@oribi.org>
X-From: git-owner@vger.kernel.org Wed Oct 18 12:28:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ga8f7-0004Ck-CZ
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 12:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030183AbWJRK2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 06:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWJRK2a
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 06:28:30 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:51428 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030183AbWJRK23 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Oct 2006 06:28:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061018102828.KKTD12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Oct 2006 06:28:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id bmTz1V0091kojtg0000000
	Wed, 18 Oct 2006 06:28:15 -0400
To: Mike McCormack <mike@codeweavers.com>
In-Reply-To: <45367A5F.7060507@codeweavers.com> (Mike McCormack's message of
	"Thu, 19 Oct 2006 04:02:55 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29219>

Mike McCormack <mike@codeweavers.com> writes:

> Junio C Hamano wrote:
>> Markus Amsler <markus.amsler@oribi.org> writes:
>>
>>> Cyrus imap refuses messages with a 'From ' Header.
>>>
>>> Signed-off-by: Markus Amsler <markus.amsler@oribi.org>
>>
>> Do you know if this change does not upset other implementations
>> of imap servers?
>>
>> Mike, are you Ok with this change?
>
> Works for me with Courier IMAP.  I'm no expert on mail headers either,
> so no objections from me.
>
> Mike

Thanks; then will apply.

By the way, Markus, did you send the patch with imap-send?  It
had a funny whitespace corruptions.
