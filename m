From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] line.c output the '--graph' padding before each
 line
Date: Tue, 13 Jul 2010 13:49:42 -0700
Message-ID: <7vsk3n2jkp.fsf@alter.siamese.dyndns.org>
References: <1278829657-26607-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829657-26607-4-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 22:49:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmQQ-0000CF-M8
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 22:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0GMUty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 16:49:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60546 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0GMUtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 16:49:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B23B9C423A;
	Tue, 13 Jul 2010 16:49:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BNZMxHLGKljrqmDgSvj7nSsEm9M=; b=ITTPvP
	5cdlMbfbUI7pQQxK1IJn2MXWMIt4AhDLIxtMW9KUTqDJV7hikNVZBQplocXKl5Vo
	c7jIGK4I+Hod37iz5OwkFTyFnu0Z7HyqVf+hmVu7bHT/D3UoaubVZgN2ErZTAUee
	Ldd0addMO4cFMAJWfppMOAh4URnlKWGt+xS9o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/+ltWqiY0sZpRIwSUzN6EI0QPDV2fbo
	paMFFb9tWgc2GiUQNI5iDYKbH3q/bcenlg8IWDgGL0yRp4Uu+P4AwXKl6y8lEN9Y
	dEdMRnd8sJvk/RUHWx5gCJ/tpUIyYk8zA+c1pK48cdBltMan3VWBkCd75axqmftE
	4iz0GDoOZa4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D086C4239;
	Tue, 13 Jul 2010 16:49:48 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9A40AC4233; Tue, 13 Jul
 2010 16:49:43 -0400 (EDT)
In-Reply-To: <1278829657-26607-4-git-send-email-struggleyb.nku@gmail.com> (Bo
 Yang's message of "Sun\, 11 Jul 2010 14\:27\:36 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2CFF4112-8EC0-11DF-AB2C-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150911>

Bo Yang <struggleyb.nku@gmail.com> writes:

> Make line level log output looks well with '--graph'
> option.

This is probably better done as part of rebasing the previous line-range
series to a more recent codebase that already has the --graph fixes, not
as a separate "oops, my codebase was stale--here is a fix-up" patch.
