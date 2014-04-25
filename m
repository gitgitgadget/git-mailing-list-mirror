From: David Kastrup <dak@gnu.org>
Subject: Re: Harmful LESS flags
Date: Fri, 25 Apr 2014 17:32:51 +0200
Message-ID: <8761lxa0gs.fsf@fencepost.gnu.org>
References: <4dc69237123e8962b2b2b901692ea78e.id@mailtor>
	<87lhuvb9kr.fsf@fencepost.gnu.org>
	<xmqqha5iv9eb.fsf@gitster.dls.corp.google.com>
	<vpqfvl1rj7i.fsf@anie.imag.fr> <20140425151124.GA11479@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, d9ba@mailtor.net,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 17:34:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wdi9A-0008Ix-4k
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 17:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592AbaDYPeF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 11:34:05 -0400
Received: from fencepost.gnu.org ([208.118.235.10]:35662 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbaDYPeA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2014 11:34:00 -0400
Received: from localhost ([127.0.0.1]:34702 helo=lola)
	by fencepost.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dak@gnu.org>)
	id 1Wdi8U-0004T8-Du; Fri, 25 Apr 2014 11:33:58 -0400
Received: by lola (Postfix, from userid 1000)
	id 6ACA5DF3E1; Fri, 25 Apr 2014 17:32:51 +0200 (CEST)
In-Reply-To: <20140425151124.GA11479@google.com> (Jonathan Nieder's message of
	"Fri, 25 Apr 2014 08:11:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247045>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Matthieu Moy wrote:
>
>> I am personally in favor of changing the default to drop the S. Silently
>> hiding stuff from the user's eyes is really bad. With good coding
>> standard and reasonable terminal size, it actually doesn't matter.
>
> Just for clarity: no, when we are talking about well formatted code,
> -S is actually a way better interface.

When we are talking about well-formatted code, -S does not matter either
which way.

> That's because indentation matters and makes it easy to take in code
> structure at a glance, long lines that get cut off by the margin stick
> out like a sore thumb already, and lines wrapped at an arbitrary
> character are even more distracting to the point of being useless.

Lines which are cut off are not "to the point of being useless", they
_are_ useless.

I am not arguing that wrapped lines are pretty.  And I also consider the
"malicious" or "hiding" angle at best a marginal concern.

Overriding less' defaults should only be done for unequivocal benefits,
and in this case I consider the result actually more of a detriment than
anything else.

-- 
David Kastrup
