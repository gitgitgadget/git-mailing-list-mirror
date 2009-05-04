From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] git-am.txt: Use date instead of time or timestamp
Date: Mon, 04 May 2009 00:23:52 -0700
Message-ID: <7vprep49h3.fsf@alter.siamese.dyndns.org>
References: <1241419618-20304-1-git-send-email-bebarino@gmail.com>
	<1241419618-20304-2-git-send-email-bebarino@gmail.com>
	<1241419618-20304-3-git-send-email-bebarino@gmail.com>
	<20090504071534.GB12654@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 04 09:24:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0sXE-0007RK-Ny
	for gcvg-git-2@gmane.org; Mon, 04 May 2009 09:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752851AbZEDHYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2009 03:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752763AbZEDHYL
	(ORCPT <rfc822;git-outgoing>); Mon, 4 May 2009 03:24:11 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:55479 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZEDHYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2009 03:24:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090504072411.YWLA17135.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 4 May 2009 03:24:11 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id nKPy1b0014aMwMQ04KPy7D; Mon, 04 May 2009 03:24:10 -0400
X-Authority-Analysis: v=1.0 c=1 a=LKMg52t06iAA:10 a=1J4JI9G3AAwA:10
 a=PKzvZo6CAAAA:8 a=rk97aaxaaFrZp01LBqUA:9 a=QJQBzJF3TNxAM2oKYWScltFhqOEA:4
 a=OdWmie4EkE0A:10
X-CM-Score: 0.00
In-Reply-To: <20090504071534.GB12654@coredump.intra.peff.net> (Jeff King's message of "Mon\, 4 May 2009 03\:15\:34 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118216>

Jeff King <peff@peff.net> writes:

> On Sun, May 03, 2009 at 11:46:57PM -0700, Stephen Boyd wrote:
>
>> diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
>> index 715531b..c141261 100644
>> --- a/Documentation/git-am.txt
>> +++ b/Documentation/git-am.txt
>> @@ -85,7 +85,7 @@ default.   You can use `--no-utf8` to override this.
>>  	By default the command records the date from the e-mail
>>  	message as the commit author date, and uses the time of
>>  	commit creation as the committer date. This allows the
>> -	user to lie about author timestamp by using the same
>> +	user to lie about the author date by using the same
>>  	timestamp as the committer date.
>
> But you leave the "timestamp" in the next context line?
>
> The other two patches in the series look fine to me, though.

Likewise.  Perhaps "using the same value as the committer date" sounds
better?
