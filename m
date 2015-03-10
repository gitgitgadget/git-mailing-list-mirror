From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A branch question
Date: Tue, 10 Mar 2015 16:38:45 -0700
Message-ID: <xmqqbnk0xw1m.fsf@gitster.dls.corp.google.com>
References: <6AC11CE0-764C-4CC5-89CD-05FFB6D29EA3@jrw.org>
	<xmqqoao0zhbc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: "J. R. Westmoreland" <jr@jrw.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 00:38:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVTjg-0003Qh-48
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 00:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbbCJXis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 19:38:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64771 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531AbbCJXir (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 19:38:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A53393F677;
	Tue, 10 Mar 2015 19:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UKacCICXASSBH6jGxjlghZUzhSc=; b=rhqxvm
	7V7IMH1+faPMPVQickq8LBtbHGdy54dnC/OnATYIE2rpr656B8LVaT91GHaQe2/y
	7qgdhaB/UPH8CXS89SBJiCtQ7KjYFppqG5e/H8uvBRVuDVZIsAx0pPI3keCf8g+k
	9rYlxneoX7C/pKbybIi3hP5zHZb9dfuE0/mFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FJbqYVU0Q2LRQOfMQvzzcr615XqcyfC+
	SZXLNx74h8p2+VBRu5gofi3j4sRpGO0GyJcJ7N7mNSFKSffVlOUNG5+xI4kR1nKm
	snx12p3apUB/1Ulb5bk67fEsZ/xa6i3U3clrg1QEza6xiyH8gpfSG2AN2y/O/23F
	d2gfU2dXT8g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9E0653F676;
	Tue, 10 Mar 2015 19:38:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 226D93F674;
	Tue, 10 Mar 2015 19:38:46 -0400 (EDT)
In-Reply-To: <xmqqoao0zhbc.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 10 Mar 2015 14:13:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 983753D8-C77E-11E4-BDD5-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265284>

Junio C Hamano <gitster@pobox.com> writes:

>  2. If you want to only correct what is shown at origin to the other
>     people, then you do not have to update your local repository.
>
>     $ git push origin version_1.0 v1.0
>     $ git push origin version_1.1 v1.1

Colons are missing from this one.

	git push $there $we_call_it_so:$they_call_it_so

i.e.

	git push origin version_1.0:v1.0        
	...

>  3. If these old ones are meant to be immutable, then storing them as
>     tags instead of leaving them as branches might make more sense,
>     i.e.
>
>     $ git push origin version_1.0 tags/v1.0
>     $ git push origin version_1.1 tags/v1.1

Likewise.
