From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] i18n: Not add stripped contents for translation
Date: Mon, 05 Mar 2012 12:08:37 -0800
Message-ID: <7v62ei24l6.fsf@alter.siamese.dyndns.org>
References: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
 <7v7gyz7pei.fsf@alter.siamese.dyndns.org>
 <CANYiYbGdJ0yFmPnsK_JdABwmFraVdNi08QgFKRmGzJt-DA9tBw@mail.gmail.com>
 <7vobsb67dn.fsf@alter.siamese.dyndns.org> <4F55155A.3050309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 05 21:08:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4eD7-0005QG-Q6
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 21:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615Ab2CEUIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 15:08:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757536Ab2CEUIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 15:08:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BA346BD9;
	Mon,  5 Mar 2012 15:08:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XkNf4vh+hk0rVFDZiZUKMHhkhPs=; b=mluKRv
	WgINf15sGRwxgmpm3MkpgMZabpPntzqnxwW5v3LKX2wOqc5Wwg7FMFs9vk1NwCZL
	zxqy7expwch8b4Qfi6tyED/NVD+pjJBqSbv9Rlj/rDFD3E+VWzxO9gpWTVJ3F23o
	1oJl+iMJhAnFrO9wPQSKSYM/RMXcnujMkPFoY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Po7MDcrU7zF0cJNbNT4OqwKpxZ3xuk+2
	R79F9lyDjEv0EX8e90puJN45fWAbxKLGjs/SDqOQyZ4qt/Az5HCd3smwAmpv6OND
	dDmG3gxoM2K6mE259Wt5//TfcJ80373bE9WjBPGBJr92RTA9AkjXhE8pZRxzaoiQ
	GAMojBNi5vg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 435006BD8;
	Mon,  5 Mar 2012 15:08:39 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B51996BD6; Mon,  5 Mar 2012
 15:08:38 -0500 (EST)
In-Reply-To: <4F55155A.3050309@web.de> (Jens Lehmann's message of "Mon, 05
 Mar 2012 20:34:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF39B9D8-66FE-11E1-B3AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192270>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I have no objections at all against changing the code that way to make it
> possible to translate it in a sane way. This code predates the i18n effort
> by a few months, so it didn't take this kind of problem into account.

Ah, Ok, that explains it.
