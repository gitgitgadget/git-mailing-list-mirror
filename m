From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add-interactive: shortcut for add hunk and quit
Date: Sun, 15 May 2011 13:30:32 -0700
Message-ID: <7v7h9rpuzb.fsf@alter.siamese.dyndns.org>
References: <20110515125525.GA3014@mrq1.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hermann Gausterer <git-mailinglist@mrq1.org>
X-From: git-owner@vger.kernel.org Sun May 15 22:30:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLhxd-00013B-Pi
	for gcvg-git-2@lo.gmane.org; Sun, 15 May 2011 22:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057Ab1EOUal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2011 16:30:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46769 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab1EOUak (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2011 16:30:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 74E4B50B5;
	Sun, 15 May 2011 16:32:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=19JM9tT4ZZ3xVggnFMTaAXiTnVg=; b=agjzz5
	46OpAVMHobihwc6Km6T/ZlKDVHdvVdrJHKObc1M7BMWIqrPsHQnIBsrMseM3586B
	CyXpxLRpSZIZe7ycbigmgwlgloY/NZJP8e3y4JGJ+M3+o6jvmyM4F8KqX3JPd5RK
	XopMZQ9HAPylbFvGdAQ4BW2Uy0v+salqJaOoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f8KM+XKn0EH7ItS72MMr9gbe/t0MOw67
	sgtdB6gXrh2PdqMn2h6/DvqyuGiNQwSNn+gyABjnqYUpBCQQ8VDpQuBGpkc5sdCj
	ul+TN1nBK2SUgn0Oz7nKdLf81wSZ/uhzIRMWQlm/nGnG9Q77nnGQA71OFUMvc9jG
	VtrJv8FcC2c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5286150B4;
	Sun, 15 May 2011 16:32:43 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C4AD50B2; Sun, 15 May 2011
 16:32:40 -0400 (EDT)
In-Reply-To: <20110515125525.GA3014@mrq1.org> (Hermann Gausterer's message of
 "Sun, 15 May 2011 14:55:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C5B2858-7F32-11E0-9021-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173663>

Hermann Gausterer <git-mailinglist@mrq1.org> writes:

> combines the two commands "y"+"q" to one.
> i use this if i know that this is the last hunk to add.
>
> Signed-off-by: Hermann Gausterer <git-git-2011@mrq1.org>
> ---
>  Documentation/git-add.txt |    1 +
>  git-add--interactive.perl |   15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)

It feels a bit _too_ narrow a usecase to me.

I am personally not very interested in the feature itself, but even if I
were, I wouldn't be happy to see an implementation that duplicates a
trivial existing loop without refactoring to add maintenance burden.

Thanks.
