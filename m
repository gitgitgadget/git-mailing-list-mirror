From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v10 12/12] trailer: add blank line before the trailers if needed
Date: Mon, 07 Apr 2014 14:38:29 -0700
Message-ID: <xmqqvbuklt0q.fsf@gitster.dls.corp.google.com>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>
	<20140406170204.15116.15100.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 07 23:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXHGA-0005ON-5y
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 23:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbaDGViz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2014 17:38:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54294 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753771AbaDGViy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2014 17:38:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DF097B323;
	Mon,  7 Apr 2014 17:38:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/PBZUYlTGKA7lzMsofpXTMeOgfE=; b=tooloc
	4kqx/nn0SHL4PZ57Ts7VhKD1emBRv9hr7GElWnj/TXnjtFRJRySDKkzd1DeECvt3
	rNUbQPD/NJbzBoY7wKNctCLeqDa1MKjOkdTG7J1vtDqJ0cAMXlKz468insK1xXSH
	bM76Opikb+2u/1deIGTiytEPrrDyByJEIHdeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZE8NVXTa3JITF+7/EbPobogLKHRBSi1e
	8JFMb6PUjv0AYem1QPWmVhdkeBaSLq8PLVcbSzodR0Qpp7NIVvYOpyKkKJEV+7HW
	1+g/Njnbj7T2YIJlC2srRzYWCJ4ps1zj0Ql4eqf7tIKkrJsvQLwsTv4APYW+UGy3
	7fotDUJHEbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 768127B322;
	Mon,  7 Apr 2014 17:38:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 69C2F7B321;
	Mon,  7 Apr 2014 17:38:31 -0400 (EDT)
In-Reply-To: <20140406170204.15116.15100.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 06 Apr 2014 19:02:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F6BEDF2A-BE9C-11E3-B301-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245906>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

Hmph, this is more fixing a mistake made earlier in the series at
the end than adding a new feature or something.  Can you start from
a version that does not have the mistake from the beginning?
