From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Wed, 14 Apr 2010 14:34:01 -0700
Message-ID: <7viq7toh12.fsf@alter.siamese.dyndns.org>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <201004142212.33162.jnareb@gmail.com>
 <7vbpdlpy5t.fsf@alter.siamese.dyndns.org>
 <201004142329.38914.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 23:34:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2AE2-0006Ny-PG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 23:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915Ab0DNVeR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 17:34:17 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756900Ab0DNVeR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Apr 2010 17:34:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C1172AB122;
	Wed, 14 Apr 2010 17:34:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUgQX7UUW86pjfv92cfh7PEh8qo=; b=FN/hJ5
	B+4HpRNyU9NHTLLfUPRWY6eKXc8zKmqfdNMuH/LXRQ6GGxQFE1SfPA49x+Yomt/5
	fiAl7+9W1Bjqtq+dcJJL7tfld1XrqUL1BK3vYFSaE8kuzBfhRkikxJwBChw1FU/K
	prq/7AceSu9mItGoaj6MalyJi+21KZzmJCsJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dsqTFHGXPjw1xuDlPZsjhqDtYrTEG78e
	sjSfYow3fEIGuw2Q8yUtw98IITE58DWoVpVh+waODKGsXz5oh9hxe3CVdzV/BLph
	SnQqtwdgyDZuOkdKb8Ah8Rwo0MBQxeMAbIgPo+UnQV10yYvk3OPWc1Q4Pk5qk9mg
	f/fhyhf+fEA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DE48AB11C;
	Wed, 14 Apr 2010 17:34:09 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D7A2AB116; Wed, 14 Apr
 2010 17:34:02 -0400 (EDT)
In-Reply-To: <201004142329.38914.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed\, 14 Apr 2010 23\:29\:38 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75E55D66-480D-11DF-A717-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144921>

Jakub Narebski <jnareb@gmail.com> writes:

> Well, this whole idea started with the fact, that "git status --short"
> was hard (or impossible) to parse unambigously by scripts[1], and even
> "git status --porcelain -z"[2] is not that easy to parse[3].

And you apparently seem to agree with that claim, but I don't.  I think
Jeff (who did the --porcelain stuff; by the way, why did we lose him from
Cc list?) has already said that he is open to an update.
