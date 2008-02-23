From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4014: Replace sed's non-standard 'Q' by standard 'q'
Date: Sat, 23 Feb 2008 11:34:53 -0800
Message-ID: <7vlk5b31r6.fsf@gitster.siamese.dyndns.org>
References: <12037561161987-git-send-email-prohaska@zib.de>
 <alpine.LNX.1.00.0802231426560.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat Feb 23 20:35:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JT09x-0004V3-Ro
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 20:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754218AbYBWTfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 14:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754204AbYBWTfK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 14:35:10 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48287 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYBWTfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 14:35:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 342D0186A;
	Sat, 23 Feb 2008 14:35:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 7CB681868; Sat, 23 Feb 2008 14:35:00 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0802231426560.19024@iabervon.org> (Daniel
 Barkalow's message of "Sat, 23 Feb 2008 14:28:57 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74843>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Sat, 23 Feb 2008, Steffen Prohaska wrote:
>
>> This commit should be applied on top of db/cover-letter.
>> 
>> -- >8 --
>> 
>> This commit avoids sed's 'Q' operator.  The Open Group's sed
>> man page [1] does not mention 'Q'.  sed on Mac OS X 10.4
>> does not accept Q.  'q' is sufficient for our purpose.
>> 
>> [1] http://opengroup.org/onlinepubs/007908799/xcu/sed.html
>
> Looks good to me; GNU man pages annoyingly don't tell you what's not more 
> standard.

Probably.  You have to be an old git ;-)
