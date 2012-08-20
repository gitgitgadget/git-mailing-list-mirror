From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Comparing the working tree with a commit should be independent
 of the index
Date: Mon, 20 Aug 2012 12:16:19 -0700
Message-ID: <7vfw7hjrwc.fsf@alter.siamese.dyndns.org>
References: <502FE0C6.6050106@seznam.cz>
 <7vvcgfrj8q.fsf@alter.siamese.dyndns.org> <503285A5.1010708@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar@seznam.cz>
X-From: git-owner@vger.kernel.org Mon Aug 20 21:16:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3XSf-0001ya-VZ
	for gcvg-git-2@plane.gmane.org; Mon, 20 Aug 2012 21:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753885Ab2HTTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Aug 2012 15:16:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753612Ab2HTTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2012 15:16:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D65D60F7;
	Mon, 20 Aug 2012 15:16:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RaQsV8X5BWd+qeibfCYa2LlRHNc=; b=vFfxvO
	41tA/jJW6gPLuso5rtII6AeyGtWhCfwXvKpeHO4hmmMVKK9Wb6FuC42mLCQMvOqI
	ARVHtzCnA1u+GNCdB+BPzUfN4edL2jy0dqWPi7zS0R9cAIpuAut+Z9vOHUIaqdFa
	lKvIbnpyUyLESYw/uNLExHm6tUxO0jzeCt+r8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Qb5mmYkTES21DRI1wzfGH3fJ/qF6ufvV
	DzcF6e9DRrJIknjD1yzSShpKu7yI947aAhQwfowKRo0LN3jqchhfNPo/WM8WVyyX
	hHln9b0McXqSbaLdFWTb77Hfz45F9qE4KzvWEk1n5wcoJdxIybSGaUYlE+bKWJHZ
	dzIC+IcBYgw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A69260F6;
	Mon, 20 Aug 2012 15:16:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F092E60F5; Mon, 20 Aug 2012
 15:16:20 -0400 (EDT)
In-Reply-To: <503285A5.1010708@seznam.cz> (Maaartin's message of "Mon, 20 Aug
 2012 20:44:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 865F984E-EAFB-11E1-8BDC-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203868>

Maaartin <grajcar@seznam.cz> writes:

> On 08/18/2012 11:19 PM, Junio C Hamano wrote:
> ...
>> In short, I do not think there is a bug in the current behaviour.
>
> I can live with it. Many thanks for your answer.
>
> Do you care to copy-paste something to [1], so I could accept your answer?

I never post to that site, and it has been a long time since I even
visited there (I got an impression that nonnegliglble percentage of
accepted answers were mere crap, and I stopped visiting).

If you think it would help others, just go ahead and give them a
copy and paste with credits.  Everything I write here is Open
Source, so no need to ask for permission.

It may help them in the longer term to include

  http://thread.gmane.org/gmane.comp.version-control.git/203689/focus=203702

to point them to where things happen and where people who matter
hang around.
