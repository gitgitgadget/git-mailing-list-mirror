From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Sep 2013, #03; Wed, 11)
Date: Thu, 12 Sep 2013 08:24:21 -0700
Message-ID: <xmqqa9jiqd0a.fsf@gitster.dls.corp.google.com>
References: <xmqqzjrjq6ig.fsf@gitster.dls.corp.google.com>
	<52315D02.9060206@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 12 17:24:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VK8ku-00037E-Lb
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753306Ab3ILPYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 11:24:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47783 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752077Ab3ILPYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 11:24:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B18541227;
	Thu, 12 Sep 2013 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tzUuUn6zo439CaKL+XEL27kjzaw=; b=GsfB7i
	+LPA5FsmPJjCH3alD8w7VB56OcXTxDd8HMt5F1Ab8bLSvPxCGSG2cmaVYihtOrVt
	nWviAtOxc1ejlEkQVsL/TOzqIiIbRrg8ZeLKbPlHIxVUVsTvEhgnmkOfjQX4sXWW
	cRF3hvsBKl6gR4Tzwp2BvGVVh7VXVAtHg2MS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLFdEfbf7Xxopfg1h72uwNpodJK1LYxp
	0UWnmOSlhFYl+skHa3mImadCKzJ7+xHZKixN7O8trOeIB6C8VQiD8su7t+VLTkFD
	qWqbFFsOCMMhBqRYjHWps6yC+kPeWBoesy+fRnrI0D9LpaSAxF/RRV2mkFJmi2J7
	J9W/q7T3pA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E2EC41226;
	Thu, 12 Sep 2013 15:24:23 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC4464121E;
	Thu, 12 Sep 2013 15:24:22 +0000 (UTC)
In-Reply-To: <52315D02.9060206@viscovery.net> (Johannes Sixt's message of
	"Thu, 12 Sep 2013 08:19:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 66B5D67A-1BBF-11E3-BA4E-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234653>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/12/2013 1:32, schrieb Junio C Hamano:
>> * jc/ref-excludes (2013-09-03) 2 commits
>>  - document --exclude option
>>  - revision: introduce --exclude=<glob> to tame wildcards
>> 
>>  People often wished a way to tell "git log --branches" (and "git
>>  log --remotes --not --branches") to exclude some local branches
>>  from the expansion of "--branches" (similarly for "--tags", "--all"
>>  and "--glob=<pattern>").  Now they have one.
>> 
>>  Will merge to 'next'.
>
> Please don't. This is by far not ready. It needs a different approach to
> support --exclude= in rev-parse.

Thanks for a dose of sanity. I didn't look at rev-parse. I vaguely
recall somebody offered follow-ups (was it you?) and at that point
I placed this on the back-burner.
