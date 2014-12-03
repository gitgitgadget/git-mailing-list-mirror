From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/14] config: use message from lockfile API when locking config file fails
Date: Wed, 03 Dec 2014 11:59:49 -0800
Message-ID: <xmqqvblsh5ca.fsf@gitster.dls.corp.google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com> <20141203052124.GS6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:00:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwG5e-0000Tz-Rb
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 20:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaLCT7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 14:59:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64182 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751164AbaLCT7x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 14:59:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0391A24604;
	Wed,  3 Dec 2014 14:59:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IizfclJWufDpB1SghDQDc3X6C7U=; b=PDxMsp
	zdDKVDjurNhX3Xs+88dmtqYKm8elGsghUAV+HTCruK1NFG9Ogey91yrVnN4csI+O
	ojpb41iS8p6NOh7N/OATie4sVI4nDE86l01/WFse6UQVDFym2qiHG9YD32DKqFIq
	xgo1Lxe8NNbhTmRw2eb7OqDzoZ6ycej7ARFSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SuMeevR0b0RAOqKbWezQTIWC6xkJn6DC
	Ih0a43Z9VCrcjs/CSg5w7ynWoTnyGtydQjGrZwXfBUG8T3ie/IhEW7vZ4BCoOjlh
	CiXGxEcl74wbcSU4aQ5XxOrjw77INRwo4tV7OpiuXpQJFYk4YzvJ4T+sZVNgI9aH
	hWrZP3Wrfgs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEC0124603;
	Wed,  3 Dec 2014 14:59:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 780F924602;
	Wed,  3 Dec 2014 14:59:50 -0500 (EST)
In-Reply-To: <20141203052124.GS6527@google.com> (Jonathan Nieder's message of
	"Tue, 2 Dec 2014 21:21:24 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F0B0CEA8-7B26-11E4-94F2-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260682>

Up to this point the patches looked sensible (I am not saying that
the remainder is junk---I haven't looked at them yet is all I am
saying).

Thanks.
