From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add new options to git format-patch: --cover-subject and
 --cover-blurb
Date: Fri, 05 Feb 2010 14:33:23 -0800
Message-ID: <7vfx5fwbws.fsf@alter.siamese.dyndns.org>
References: <1265405973-5670-1-git-send-email-larry@elder-gods.org>
 <201002051526.18205.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Larry D'Anna" <larry@elder-gods.org>, git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:33:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdWk5-00074q-8a
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 23:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933943Ab0BEWdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 17:33:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933852Ab0BEWdb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 17:33:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53B9497F21;
	Fri,  5 Feb 2010 17:33:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3Nq3yjpVkza1oNE5zc3Qq+Tz42Y=; b=Br11Lh
	IaFj0X682qpG6LnyUJ88GE2tYvAjDFq8EMnyx69AtCTY2RxW8N1GO1hxxqd1tzoW
	8GW3SSMMGSdkM4NU/hVvmeYrqQfHdMs7UyeJ0HHr3WbOvi4O6y0NdzDaNA1XSUUR
	Dwbx+k2x7V50M+e5k/qdbcjzksgQm139B8LO8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=im/UOAtrukOrQpv+9cwg9x98e3oD1KyP
	iwM0PIO4OT77PJdFj2tI/B+QmsUHl8/idS+5F1xKFQsbamIAsLX59bxOiIhP1Zoa
	UkV0rSSYR/goY4SGaXqqp+3HZlCQsrt/LocXLMyUWrSbvH2lMchOjaYliqKsvZfb
	JwpFQPFxh8I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 205B597F20;
	Fri,  5 Feb 2010 17:33:28 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6787F97F1B; Fri,  5 Feb
 2010 17:33:24 -0500 (EST)
In-Reply-To: <201002051526.18205.wjl@icecavern.net> (Wesley J. Landaker's
 message of "Fri\, 5 Feb 2010 15\:26\:17 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AF31380-12A6-11DF-B61F-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139103>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> On Friday 05 February 2010 14:39:33 Larry D'Anna wrote:
>> This is useful because if you're preparing a patch series with a cover
>>  letter you can easily put together one line to format and email the
>>  whole thing to yourself.  You check to make sure everything is right,
>>  and then just change the recipient address and run it again.
>> 
>> git send-email --to my@mydomain.org  master..HEAD --cover-letter \
>>     --cover-subject "this is my patch series" --cover-blurb "$(cat
>>  blurb.txt)"
>
> One (minor?) issue is that the cover blub would be limited to the maximum 
> allowed length of the command-line arguments set by the shell or OS. Since 
> you are just catting a file, maybe "--cover-blub-file" would be better?
>
> Just a thought.

The placeholder in particular and the cover letter itself in general are
meant to be edited.  I do not see much point in forcing people to edit yet
another file and have them specify with an cover-blurb option.

Not very interested.
