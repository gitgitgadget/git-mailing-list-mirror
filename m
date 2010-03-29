From: Junio C Hamano <gitster@pobox.com>
Subject: Re: asciidoc problem, and a possible fix
Date: Sun, 28 Mar 2010 23:38:47 -0700
Message-ID: <7vaatrbpjc.fsf@alter.siamese.dyndns.org>
References: <4ABB29E2-6DB1-4712-A3E8-CD524983FB0B@kuiki.net>
 <7vljdhjk9r.fsf@alter.siamese.dyndns.org>
 <167EA641-2D5F-4553-909C-DF5D050CEDFB@kuiki.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hachi <hachi@kuiki.net>
X-From: git-owner@vger.kernel.org Mon Mar 29 08:39:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nw8cn-0007gk-20
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 08:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339Ab0C2Giz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 02:38:55 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36605 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab0C2Giz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 02:38:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 56AADA6AA0;
	Mon, 29 Mar 2010 02:38:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFcAsxEey3XmqYrsn4+IX0aWUW8=; b=E1b37H
	cwUcq4YO1w4XIpyI3zTWfGGZsEkLvrsGcgc8UfuWpLb4dWJl+P2NJLCx+RT4S1fd
	Q6SgazJlP6aTPe8NYLNxA4Rc1Rsdzg5uI1zp+QIO6yKBUPG19Kx1taxGbxIpFXD8
	hm9MeYSFASUGob0mBSiK8q7yxQhz4d0XPMsuY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CY9lB5J9MHv3rJND3qedqPuh6Dz2XnHe
	brZYA2QmSTcCncm9d9moKuEoZJOYQN26oa1midV4alkHUaOuxrqq6lD1tekBwT8J
	ulCRbq1rKzcqWXVAsbxGRVwD4bWAtCkjohJnEZmnmT9f8hcKOuIYIG0pyVRcRzws
	bovLms7R0VE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 040B3A6A9F;
	Mon, 29 Mar 2010 02:38:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 42465A6A9E; Mon, 29 Mar
 2010 02:38:49 -0400 (EDT)
In-Reply-To: <167EA641-2D5F-4553-909C-DF5D050CEDFB@kuiki.net>
 (hachi@kuiki.net's message of "Thu\, 25 Mar 2010 02\:15\:21 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BD2A8AEC-3AFD-11DF-986B-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143443>

hachi <hachi@kuiki.net> writes:

> The long version:
> ...
> End conclusion:

Thanks.  The above analysis would be a good foundation for you to write a
proper commit message when you submit a patch for application.  Please see
Documentation/SubmittingPatches.

> * Option 1
>
> My patch is correct because nested inline passthrough doesn't do
> anything other than confuse the asciidoc parser. However, this means
> that prior to asciidoc 8.4.1 the inside of backtick strings are not
> inline passthrough. I have no idea if this is a bad thing, but it seems
> to not actually matter in my test using asciidoc 8.2.6.

I'd really want to avoid anything that does not work with AsciiDoc 8.2.5,
as that is what is used to format the html/man branches at k.org.
