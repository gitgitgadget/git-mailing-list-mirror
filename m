From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git format-patch should honor notes
Date: Tue, 07 Dec 2010 14:10:43 -0800
Message-ID: <7vmxohnsik.fsf@alter.siamese.dyndns.org>
References: <4CFEACC5.70005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Blake <eblake@redhat.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 23:11:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ5kS-000691-2Y
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 23:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab0LGWKz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 17:10:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423Ab0LGWKy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 17:10:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C4062AE8;
	Tue,  7 Dec 2010 17:11:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=izbou1NH29EKRhcZDIBJX3Xu3ws=; b=gofj1K
	oBhvp0eiw2cOGfUyAXAq5qLIpWw6qMxmjpsHhFhX+e9MZkBA/KCT1zYzGWuAlQsj
	pz0PpUp1o8PiEEBncldpV1ZirboerNUMsMuLxagKudzk/d5VH3s21uKrt1CXUq4E
	JO7YMPAeidm/BO7hFHGzoy/7taC39eXetzGqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bgvE+MVGQ8lw9QmV4xFcRJxYad3tl4Ce
	s3kQH9Q6B6oYml8K9PQ4O/M0Pr+ecQCNdSL3zrOC3IeGGD7Hj5iIebuWwVJTnAIq
	M8x+QMDrfgeDUGXY6AMCM/CaA+oNqDjixN3KBZO6txdxBhwaZsK7IEmYcaKt6GqO
	A5klVbLo15A=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 072842ADC;
	Tue,  7 Dec 2010 17:11:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 15AF22AD8; Tue,  7 Dec 2010
 17:11:07 -0500 (EST)
In-Reply-To: <4CFEACC5.70005@redhat.com> (Eric Blake's message of "Tue\, 07
 Dec 2010 14\:53\:09 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E5F53738-024E-11E0-B7D7-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163143>

Eric Blake <eblake@redhat.com> writes:

> So, what I'm missing is the ability for 'git send-email' (or more
> fundamentally, 'git format-patch') to be able to include contents of a
> particular (set of) notes reference in each patch file it generates,
> where the note falls in the informative portion of the email, and is
> intentionally omitted from the upstream commit when someone else runs
> 'git am' on my email.

I do not know if "should" is the right word, but it certainly sounds like
it would be nice to have such an option for the usecase you described.
