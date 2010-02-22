From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2010, #05; Sun, 21)
Date: Sun, 21 Feb 2010 23:49:15 -0800
Message-ID: <7v4ol9lngk.fsf@alter.siamese.dyndns.org>
References: <7vtytacebd.fsf@alter.siamese.dyndns.org>
 <4B8233DE.7050106@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Feb 22 09:31:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjT2p-0003y4-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 08:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab0BVHtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 02:49:25 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352Ab0BVHtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 02:49:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 903469C0C6;
	Mon, 22 Feb 2010 02:49:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9SmxgUavaYVxY43B9MbbJmZFBy8=; b=jkM1iq
	z7QpLkwI2Vxv7eutRnGNK7NhPJNsUGzQaUsG6t401OC/OGxZBL6BFUB7YjAWjsC+
	A8F3zZepXQWCcaAkkmC1tCI1mjV5A69TSx+qprnwxDBNMTfzG4325kpB+q9zYPVi
	6SD6SMUf6iXRbFwPA1qKf3+o3xTLyHyIPu9x0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i43Ehx7zpSW22KQB8rO9IHYupmfdbSpb
	UBxNCa9TOPPyAPpO5Drcjr7ms/CSEIgxZElgjN/iBIfXnaFSXswaS8ECyhIBj5b5
	S0k712PWfafoYSxepOSIO/PQewjIWGgHPv4+IxraaGtwBMcTdM0F3Jdlmuncb6+J
	8Z7vN7QzAOI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 18EF39C0C4;
	Mon, 22 Feb 2010 02:49:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA62D9C0C3; Mon, 22 Feb
 2010 02:49:17 -0500 (EST)
In-Reply-To: <4B8233DE.7050106@viscovery.net> (Johannes Sixt's message of
 "Mon\, 22 Feb 2010 08\:35\:58 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C93E72FE-1F86-11DF-9899-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140641>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Since you do not publish your topic branches, I'd appreciate if you could
> include the SHA1 of the topic heads in the headlines, for example:
>
> * jn/maint-fix-pager 2d3ca21 (2010-02-20) 7 commits
>
> This way I could copy-paste the branch name and SHA1 to a 'git branch -f'
> command to track the topic manually.

That is understandable, but I do not foresee it happening anytime soon, as
it would involve quite a lot of changes to the generate-compare-update
infrastructure, and I wouldn't be touching it unless I have absolutely
nothing else to do.

In the meantime, please run "git log --oneline --first-parent master..pu",
pick "ce8d258 Merge 'jn/maint-fix-pager'" from the output, and use the
second parent ce8d258^2 instead.
