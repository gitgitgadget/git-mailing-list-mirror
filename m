From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Mon, 29 Apr 2013 14:16:57 -0700
Message-ID: <7vhaipghpy.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
	<7vli81ghsf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:17:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvRa-00063s-8U
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759933Ab3D2VRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:17:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53155 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758142Ab3D2VQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BE9C1A479;
	Mon, 29 Apr 2013 21:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAE4qCTNPSiGjv2Jb0acdmAQ5uI=; b=iY9hlh
	NDT04Mlr2UmTRbu0T3JJWKo4fNnilCj3EMX+3NQ8EVsd+WzpHQh7MyVeF5f65Gvh
	vdlJGAQteJqw27kCFbDRBxKiGJNjfkgMRUOCuQYa44eJ/BzfHHg25FJF0b20fEbP
	rMPInwwJQ+bM2w3+hSlMNp14AqViIO6NWl9AU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VCtQuVh6kZe7+a4lMW8suGk4gxLWoR7s
	yZs/Rv7hzCID0uhz+aTCgippFjlwAkFjN69urlL27LLSg/GJMSAmdbAP9pSrvLB2
	BM2uPAjDfw7fg5kN4fSMmQc0wjp/S/p9Rkf8AtNbUpjRvoUh8vMexaAe62/SdzaJ
	i6d5k7rHlAo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3421A1A476;
	Mon, 29 Apr 2013 21:16:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9870F1A474;
	Mon, 29 Apr 2013 21:16:58 +0000 (UTC)
In-Reply-To: <7vli81ghsf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Mon, 29 Apr 2013 14:15:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 207098F2-B112-11E2-8971-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222866>

Junio C Hamano <gitster@pobox.com> writes:

> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> This started out as an attempt to make the backward compatibility notes
>> more parsable, but then I just kept going...
>
> Thanks.
>
>>   * "git bundle" did not like a bundle created using a commit without
>> -   any message as its one of the prerequistes.
>> +   any message, as it is one of the prerequistes.
>
> This is actually saying a different thing.  
>
> When you create a bundle, you can say "you can only unbundle this in
> a repository that has commit X", with "git bundle create $name ^X Y
> Z".  Such a commit X is called the bundle's prerequisite.  You can
> have more than one prerequisite, e.g. "... ^X ^W Y Z".
>
> But if you create a bundle by using a commit that does not have any
> message as X (i.e. the bundle's prerequisite), the "git bundle" did
> not like to read the resulting bundle output.
>
> So <a commit <without any message> as its (bundle's) one of the
> prerequisites> is what the original wanted to say.  The rewrite
> makes it read like "For a commit, having a message is a requirement
> to be used in a bundle", at least to me.
>
>>   * "index-pack --fix-thin" used an uninitialized value to compute

Please disregard everything below this line; the message was sent
unfinished by accident.
