From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach "log -F --author=<match>" to behave better
Date: Thu, 04 Sep 2008 18:04:50 -0700
Message-ID: <7vvdxbz9l9.fsf@gitster.siamese.dyndns.org>
References: <g9o0ac$qig$1@ger.gmane.org>
 <7v4p4w75b7.fsf@gitster.siamese.dyndns.org>
 <7vprnk5n3c.fsf_-_@gitster.siamese.dyndns.org>
 <20080904133344.GA3197@mithlond.arda.local>
 <7vk5dr3f4x.fsf@gitster.siamese.dyndns.org>
 <20080904192529.GA3443@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri Sep 05 03:06:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbPm7-0000m6-NJ
	for gcvg-git-2@gmane.org; Fri, 05 Sep 2008 03:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbYIEBFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 21:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751868AbYIEBFA
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 21:05:00 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:55114 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbYIEBE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 21:04:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 438B174414;
	Thu,  4 Sep 2008 21:04:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3DE3B7440F; Thu,  4 Sep 2008 21:04:53 -0400 (EDT)
In-Reply-To: <20080904192529.GA3443@mithlond.arda.local> (Teemu Likonen's
 message of "Thu, 4 Sep 2008 22:25:29 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8B7DDF4-7AE6-11DD-8AA4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94985>

Teemu Likonen <tlikonen@iki.fi> writes:

> Junio C Hamano wrote (2008-09-04 12:06 -0700):
>
>> I think Jeff fixed that one already on 'maint'.
>
> You think right, it's indeed fixed. Great!

I went back to your list, and I think all of them now have solutions.

 1. Option order changes the behaviour. "git log -E --author" ...

Jeff fixed this when he did "log -i --author".

 2. ... --author='@iki.fi>$'

$gmane/94900 would be a fix; needs commit log, documentation and tests.

 3. ... -F (--fixed-strings) when combined with --author= ?

We just talked about it; the patch should go to 'maint' with tests.

 4. Logical AND/OR operation. ... combined together do not limit ...

$gmane/94953 look for --all-match.
