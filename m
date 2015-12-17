From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] push: Fully test --recurse-submodules on command line overrides config
Date: Thu, 17 Dec 2015 08:41:52 -0800
Message-ID: <xmqqa8p9c9in.fsf@gitster.mtv.corp.google.com>
References: <20151203131006.GA5119@mcrowe.com>
	<1449148235-29569-1-git-send-email-mac@mcrowe.com>
	<CAGZ79kb3XCkabxUq6Sh-aLa=a6kzRZtR6WG+wTk1SQY9_Mehog@mail.gmail.com>
	<xmqqio3yc8yd.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZpCPp6CrfknQRDObKvuNnCe2+bZwCAF8XKrkkVNS+e3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike Crowe <mac@mcrowe.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 17:42:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9bcu-000879-KA
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 17:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbbLQQl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 11:41:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755883AbbLQQlz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 11:41:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAE9430162;
	Thu, 17 Dec 2015 11:41:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dnhJ/Vn5fOpQTnjrLAsdlTxIiJ8=; b=SbQJVu
	7waKCIp6bHrT1zFox0MynuWWiI7GVJtc8BMxS1BWBbpN1bMHzm3wQZES+TRX7ZPl
	vrQD+DDJouIMm+D89AVmM1gG9T6HzdVu9zy0E8PeMOxf3TXjQvAaOTFrqyzokEO5
	wVKJzZ/4Me58AJAVag2mrej8dTrFUvobFYKAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ke9ZVOq3ehhH6zOL43QJbFMSVKcj0wQc
	sj+0j9tFslk0ZAiv//W20i4KmaWL1YPftDSdsRdtlyf2xiPmS+9Q9z6rk/Pr85P2
	VXxFz3wFrLNK8wGQYRt2L8XyVVM6ZxXjbC/Qj1vlkLxuW5+f0bosZWgYKME4t/fD
	HzGIxb2t954=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B329830161;
	Thu, 17 Dec 2015 11:41:54 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 259D53015D;
	Thu, 17 Dec 2015 11:41:54 -0500 (EST)
In-Reply-To: <CAGZ79kZpCPp6CrfknQRDObKvuNnCe2+bZwCAF8XKrkkVNS+e3w@mail.gmail.com>
	(Stefan Beller's message of "Wed, 16 Dec 2015 14:46:23 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 146684B0-A4DD-11E5-8EB7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282657>

Stefan Beller <sbeller@google.com> writes:

>>> This looks good to me.
>>>
>> Thanks.  Does "This" refer to 1/2 alone or the whole series?
>
> Yes. :)
>
> "This" is applicable to both patches. We had the discussion on 2/2 about me
> misreading a line a few days earlier, but apart from that it looked good, too.

Thanks.
