From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: Add AUTH LOGIN support
Date: Fri, 19 Aug 2011 16:09:19 -0700
Message-ID: <7v1uwh0zj4.fsf@alter.siamese.dyndns.org>
References: <c1be0c3bd05779897fdc92907fe65d84c88ac72b.1312591104.git.joe@perches.com>
 <7vzkjn16n6.fsf@alter.siamese.dyndns.org>
 <1312608114.6419.18.camel@Joe-Laptop> <1313716585.11178.2.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Graham Barr <gbarr@pobox.com>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 01:09:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuYBs-00035D-P8
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 01:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756501Ab1HSXJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 19:09:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58109 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756244Ab1HSXJW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 19:09:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 95FB35100;
	Fri, 19 Aug 2011 19:09:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vJBOIol41qskH/PN7m3Pbb5llOk=; b=TDEXlp
	xWwhb4ojg2uKxCM8Cpqj0LQXdZwVMQt+gefzR/XSHy4R5NeC7t441FHRgbrD714U
	zOCZgXqfowknJBf3JSy45ZGsfQSP2WnxFu7Crvqij/qYGVCzlEE2wOfblT4UBFu1
	1ZVy+kf4iArpXzNdJMVop9GASWjFmYFVEQ+GY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V/SMhs+5VFeWIkGMl8INM+LFZIkMI3Ye
	RQdU1EkCL/dz8v/dVwufuB8119jhCLvzPq3R0tAeaoGmElD6NjzNXXwq5aLHKsda
	/qOBh2eG/169mcNWVtUYBUOI9x9WLpWf4cCXu770afghqofXrpAe6loM+ZmZbHkK
	R4vFDm7dT/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D5F150FF;
	Fri, 19 Aug 2011 19:09:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E7C0250FE; Fri, 19 Aug 2011
 19:09:20 -0400 (EDT)
In-Reply-To: <1313716585.11178.2.camel@Joe-Laptop> (Joe Perches's message of
 "Thu, 18 Aug 2011 18:16:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 457B4B2A-CAB8-11E0-8865-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179744>

Joe Perches <joe@perches.com> writes:

> On Fri, 2011-08-05 at 22:21 -0700, Joe Perches wrote:
>> 
>> I needed something now.
>> 
>> You are right but I believe it would take too long
>> to get updates to Net::SMTP in place. Doing this
>> admitted ugliness in git-send-email works for me and
>> seems to me to be appropriate for now.
>> 
>> I looked, there isn't a method to force a particular
>> AUTH type documented.  I also didn't care to rewrite
>> Net::SMTP right now.  This "works for me"...

Good for you ;-)

>> > It probably is not as simple as installing Authen::SASL::*::LOGIN, but
>> > still...
>
> I think my patch should be applied until Net::SMTP is updated.

And you already have applied to your copy, no?

I understand you needed something _now_ and that is why you wrote it, but
the thing is, I don't need the ugliness nor an ability to force AUTH LOGIN
right now, so I do not necessarily agree with you that the patch _should_
be applied to my tree.
