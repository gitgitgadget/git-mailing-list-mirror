From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 07/16] t3600 (rm): add lots of missing &&
Date: Sun, 03 Oct 2010 16:32:28 -0700
Message-ID: <7vmxquettf.fsf@alter.siamese.dyndns.org>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>
 <1286136014-7728-8-git-send-email-newren@gmail.com>
 <20101003205615.GB22743@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	avarab@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 01:32:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2Y2v-0005eG-Vi
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 01:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751745Ab0JCXcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Oct 2010 19:32:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45189 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab0JCXck (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Oct 2010 19:32:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA222DB222;
	Sun,  3 Oct 2010 19:32:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+MKtQ7kiItXRKRfQOPzP0FVtOiE=; b=kIMA2T
	xlOTE/3NNPPHLrNlOqp4k+93G/Cu2N/x3Ld+j6RDLIbrTgIFrhFRj/+QzvrEQ9g9
	+yV2vacaUiFTfB9En4HM4lH+galC7FvACETkm7vBHersMTtjirGCIJ+otx9RtTwS
	Lq6/CEIhgsHKUKPLdosip1waJVhd3WODVoMTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HvKgSg0oru8LwDAsJ/eF/J9X+37iMdTt
	O5WGYKb65nFoxnNAKFpkT1BYZkFsvmHnB73TKrp3MBoWwSqdj/d6infbVJgGhgeN
	4atLSAW9/j+w6WDD2V0lx9LSbnk91FcR8otel0kKK2F5xLwumv5gMF9Mk4R72VUd
	li6rwdYmyH0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 19548DB21E;
	Sun,  3 Oct 2010 19:32:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4D685DB21C; Sun,  3 Oct
 2010 19:32:30 -0400 (EDT)
In-Reply-To: <20101003205615.GB22743@burratino> (Jonathan Nieder's message of
 "Sun\, 3 Oct 2010 15\:56\:15 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 80404FC6-CF46-11DF-A8B5-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157948>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Maybe you would prefer something like this on top?  My only concern is
> to make sure the test is robust (even if people add new tests before
> these without paying much attention) and easy to read.
>
> I suppose I am nitpicking excessively because I do not like to see
> regressions, even in out-of-the-way code like this.

I do not think you are nitpicking at all; it is a key to maintainability
to make sure that the code is unlikely to be broken by future changes that
are not perfectly diligent.

Thanks.
