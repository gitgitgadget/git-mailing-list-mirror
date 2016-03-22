From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
Date: Tue, 22 Mar 2016 13:29:28 -0700
Message-ID: <xmqqk2kugst3.fsf@gitster.mtv.corp.google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
	<20160322185628.GA19993@google.com>
	<20160322192309.GA9782@sigill.intra.peff.net>
	<20160322195051.GA20563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 22 21:29:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiSw4-0007K2-1y
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 21:29:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998AbcCVU3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 16:29:39 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:63325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752666AbcCVU3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 16:29:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D93A94E85F;
	Tue, 22 Mar 2016 16:29:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULjPkNd+hiuR5dZ+C6n8RtYFVZA=; b=PzQvcU
	3p/TG9POoCEYVW6PHB9omaTu32hL380HFKucQlPGcWUoocu7sYccbsXXrKwojono
	Qa8bHopFDliBEif2NadC6GFGaQpTXPw8c4GImrdkYsXMvLftsZNV32mpfVgKtjEA
	cSLMkk+YbESb7AnJ9gb/YLRyGKc4W1WNMXKiQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mYLw2Z65nwyeZbkxx//jLeEfLesLyQrc
	LUvF6Q97BMbMBOds9IqRzUp65hoUTpGS9Md/tMiMw8ThlhbMwtMGbVnUV7A3OYqu
	FAagATmakfXQ8HMIbceAnKcYadz7HtAujRKxp50a2pH8J/l4XQk7Amkw/CSiyq8P
	rJZT8SVlN6k=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D12E14E85E;
	Tue, 22 Mar 2016 16:29:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A9E44E85C;
	Tue, 22 Mar 2016 16:29:29 -0400 (EDT)
In-Reply-To: <20160322195051.GA20563@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 22 Mar 2016 15:50:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C733A192-F06C-11E5-BDF5-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289555>

Jeff King <peff@peff.net> writes:

> Obviously another option would be to make the parsing side more liberal
> (which has the added effect that if anybody _else_ ever wants to
> generate $GIT_CONFIG_PARAMETERS, they will not get annoyed). But I took
> this route for now because it's the simplest way to fix the regression.
> And even if we do later make the parser more liberal, it's still a good
> idea to keep the output from the generating side as clean as possible.

Sounds sensible.  Will queue.  Thanks.  

> I just did this on master, and it is standalone. But for the reasons
> above I think it would also be fine to stick on the tip of the
> jk/submodule-c-credential topic.

Yup, I think that is fine.
