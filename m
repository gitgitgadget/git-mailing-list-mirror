From: Michael G Schwern <schwern@pobox.com>
Subject: Re: OT: mail-based interfaces and web-based interfaces (Re: Extract
Date: Wed, 25 Jul 2012 19:33:31 -0700
Message-ID: <5010AC7B.6020805@pobox.com>
References: <5004B772.3090806@pobox.com> <20120717174446.GA14244@burratino>
 <5005F139.8050205@pobox.com> <20120717233125.GF25325@burratino>
 <7vy5mhwrdl.fsf@alter.siamese.dyndns.org> <500F23E4.9090306@pobox.com>
 <20120725025507.GB13236@dcvr.yhbt.net> <500F860E.5010909@pobox.com>
 <20120725234838.GA16020@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	robbat2@gentoo.org, Ben Walton <bwalton@artsci.utoronto.ca>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 26 04:33:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuDtT-0004u1-VN
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 04:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752321Ab2GZCde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 22:33:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53606 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab2GZCde (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 22:33:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 610889491;
	Wed, 25 Jul 2012 22:33:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sasl; bh=+cKV7GUGEjkX
	CwbV+WRDb4LLV1A=; b=dOydcKlNX/0qcOxP/wPIeWM1JfjSH3gVKaAOt+CTgvjr
	4FQLWTpH9NZ7osBdS6dvkwxrsgvVyyyvV9EvL9erOwtAFtemLewZiIApViylbJYK
	gLZTYRzQWjieu9u00J7VEixU7Mb77/AULwUmxBEV1oEdDtOnwIkabaPfwg3kGYM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=JVghZl
	A/JltXZh6WsZ5t12BFYlBA+J6rMHHKrrvn240KnCVciH44i+Ylu7pYqmKHNQmC94
	YmNOpn+oHyfz7hBxeUBgxxIe+PYl/3HWbk4Wyfbqv4+8UJ/+bytZIMkFlIi0dfNt
	MOCDWWUoK/UVDCwFbxeYGddaNsb9SbNkqv/Vs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D3589490;
	Wed, 25 Jul 2012 22:33:33 -0400 (EDT)
Received: from windhund.local (unknown [71.236.173.173]) (using TLSv1 with
 cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested)
 by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E8B8948F; Wed, 25 Jul
 2012 22:33:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.7; rv:14.0)
 Gecko/20120713 Thunderbird/14.0
In-Reply-To: <20120725234838.GA16020@dcvr.yhbt.net>
X-Enigmail-Version: 1.4.3
X-Pobox-Relay-ID: 4B1E9798-D6CA-11E1-A9CD-01B42E706CDE-02258300!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202221>

On 2012.7.25 4:48 PM, Eric Wong wrote:
> We need to use something.  Right now our choice of mailer is the best
> choice for _existing_ contributors.

I believe this entire discussion can be reduced to that right there.

If your process is optimized for existing contributors, it will work well for
existing contributors, who will want to optimize it for themselves.  Repeat.
If the main way you evaluate your process is asking "is this more convenient
for me" then you're probably in that spiral.

This creates a process very well tuned to the existing contributors, and its
very convenient for them.  But the consequence is it becomes more and more
work for a new contributor to join.

Before talking about anything else, the existing contributors have to ask
themselves a simple question:  Do we care about getting new contributors?

The answer can be "no" ("yes, but not if I'm inconvenienced" is a no).  Maybe
you're happy with the people you've got.  But there's no point in getting into
detail until that's settled.

That's mostly a rhetorical question.  I want to wrap up the meta-discussion
and focus on getting patches in.


-- 
100. Claymore mines are not filled with yummy candy, and it is wrong
     to tell new soldiers that they are.
    -- The 213 Things Skippy Is No Longer Allowed To Do In The U.S. Army
           http://skippyslist.com/list/
