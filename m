From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] nd/clear-gitenv-upon-use-of-alias
Date: Mon, 21 Dec 2015 13:18:25 -0800
Message-ID: <xmqq4mfbfqla.fsf@gitster.mtv.corp.google.com>
References: <1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1450597819-26278-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sbeller@google.com, asottile@umich.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 22:18:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB7qi-0006gX-SK
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 22:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbbLUVS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 16:18:29 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751195AbbLUVS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 16:18:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F4D735008;
	Mon, 21 Dec 2015 16:18:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uYVpaA4kBAwZg1EHc7hNox3NLNg=; b=C2wmE9
	XGz1i2Ny/AC+ZS6Whq1oD3XzzhetptG2itXFPBZiGC2Vnh478YDDqCl8YRiHnjO/
	hxfmF3aa2w9fQVdHq6y9oAFyBZfMirNhWng0Nkh51izYX6qBPZE16VOylgElWmb0
	9ByKTZwHj7e9PmvATbBBLTak+AnC86rJgb9H0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQ9I9otosv3nnnZA9irTKveNUUGHTHez
	sfqaK70HRp8Cii+KF8N68Wl3ORtdkUSxdZOyjPAIGwVZRkeifSzY3YEkuIbWNJnt
	D9n6LiH7C+a0z+C0oSyONk6hCdeJKqKXA1ogPdDN8mmlNDV9bL9k55NIYkyX4BRE
	Lg/CQKmKkhM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8ACD835006;
	Mon, 21 Dec 2015 16:18:27 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0EC1235005;
	Mon, 21 Dec 2015 16:18:26 -0500 (EST)
In-Reply-To: <1450597819-26278-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 20
 Dec 2015 14:50:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 60329E76-A828-11E5-A9DC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282819>

Thanks.  I wiggled these three on top of the "Revert the earlier
one"; while I think the result is correct, I'd appreciate if you can
double check the result when I push the topic out later today.
