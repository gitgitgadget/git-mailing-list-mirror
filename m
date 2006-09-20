From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsimport move over to using git for each ref to read refs V3
Date: Wed, 20 Sep 2006 10:17:18 -0700
Message-ID: <7v64fiihk1.fsf@assigned-by-dhcp.cox.net>
References: <45116888.4050806@shadowen.org>
	<20060920163704.GA27407@shadowen.org>
	<7vodtaiijt.fsf@assigned-by-dhcp.cox.net>
	<451173B1.4060305@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 19:19:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5hP-0001zc-P5
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 19:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWITRRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 13:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWITRRV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 13:17:21 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:8851 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932069AbWITRRU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 13:17:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920171719.YXRP21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 13:17:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QhH51V0011kojtg0000000
	Wed, 20 Sep 2006 13:17:05 -0400
To: Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <451173B1.4060305@shadowen.org> (Andy Whitcroft's message of
	"Wed, 20 Sep 2006 18:00:33 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27383>

Andy Whitcroft <apw@shadowen.org> writes:

> Junio C Hamano wrote:
>> 
>> for-each-ref let's you limit the refs by leading path, so I do
>> not think "next if" inside the loop is needed if you say
>> 
>> 	for-each-ref --perl --format=$fmt refs/heads
>
> Stupid boy :)
>> 
>> Any reason you did not like my version that allows you to get
>> rid of the while() loop altogether?  (hint: replace eval in my
>> example with "print" and see what you are evaling)
>
> To my mind we avoid the 'mozilla repo' issue of 1000's of heads
> busting some string length limit, or requiring some _vast_ string to
> hold it (as perl is likely to cope).  Given we are sifting a small
> percentage of the data out of it.

Quite valid reasoning.

Will apply V3 with refs/heads filtering added; no need to
resend.
