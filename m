From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] push: Fully test --recurse-submodules on command line overrides config
Date: Wed, 16 Dec 2015 14:41:46 -0800
Message-ID: <xmqqio3yc8yd.fsf@gitster.mtv.corp.google.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<CAGZ79kb3XCkabxUq6Sh-aLa=a6kzRZtR6WG+wTk1SQY9_Mehog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Crowe <mac@mcrowe.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 23:41:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Kle-0004bg-LG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 23:41:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739AbbLPWlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 17:41:50 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:59299 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752170AbbLPWlt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 17:41:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D0608333A9;
	Wed, 16 Dec 2015 17:41:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bb/ELCYGnNvj3NOgEoPPGoYYAxE=; b=F7ecAS
	Enu1JuAYfQHdP1Ozy4nvZC+d1Fbakh1qchcOh7z/m80+TGdrH8g0/dL41h8ExDOn
	2Qyss2KJFT5tqN5DWfDsbPRJ+041ZDGK9yQfxnBnmBostWYFp84A+b/Zu/vn0SiM
	vwuRX/D6om62HJxLHrHWiLQqj8pAWXzfDvIHo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SdZuuKZn+iKzBDcBevhtw6tygw+J+VUI
	a0A4p5B3fnc0dQQvX/kRVCDFPoQA3yC6D6IYfaJl+NPfPxV0O2Nz1EyDzo3cvOZ2
	oZwRmyc0EV1VcThYuwuICBYO3PzHJODixosRFAskUkFJdAX9q9NfTLoQScRNGoNU
	i1qUAmDUdzw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C8B52333A8;
	Wed, 16 Dec 2015 17:41:48 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 43FCE333A6;
	Wed, 16 Dec 2015 17:41:48 -0500 (EST)
In-Reply-To: <CAGZ79kb3XCkabxUq6Sh-aLa=a6kzRZtR6WG+wTk1SQY9_Mehog@mail.gmail.com>
	(Stefan Beller's message of "Wed, 16 Dec 2015 12:48:56 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 31175B44-A446-11E5-ADF2-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282617>

Stefan Beller <sbeller@google.com> writes:

> On Thu, Dec 3, 2015 at 5:10 AM, Mike Crowe <mac@mcrowe.com> wrote:
>> t5531 only checked that the push.recurseSubmodules config option was
>> overridden by passing --recurse-submodules=check on the command line.
>> Add new tests for overriding with --recurse-submodules=no,
>> --no-recurse-submodules and --recurse-submodules=push too.
>>
>> Also correct minor typo in test commit message.
>>
>> Signed-off-by: Mike Crowe <mac@mcrowe.com>
>
> This looks good to me.
>
> Thanks,
> Stefan

Thanks.  Does "This" refer to 1/2 alone or the whole series?
