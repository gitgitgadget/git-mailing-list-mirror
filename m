From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] commit: allow partial commits with relative paths
Date: Wed, 03 Aug 2011 15:07:28 -0700
Message-ID: <7vwreu9mjj.fsf@alter.siamese.dyndns.org>
References: <CAOnWdohKfwEOMx=wr_PKiW+ucYBK2ZWykm_7dqr7hy4xGRM02A@mail.gmail.com>
 <19b908142567fcfafe4da3d0fd60b134d30c613a.1311579663.git.git@drmicha.warpmail.net> <20110729133551.GA8707@toss.lan> <4E343534.8000604@drmicha.warpmail.net> <20110730170045.GA9900@toss.lan> <4E34399C.2080109@drmicha.warpmail.net> <20110730171347.GA10432@toss.lan> <7vbow7ebzw.fsf@alter.siamese.dyndns.org> <20110803192828.GA4228@toss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Reuben Thomas <rrt@sc3d.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Thu Aug 04 00:07:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QojbF-0003EK-4l
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590Ab1HCWHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 18:07:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754772Ab1HCWHb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 18:07:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B38B47DC;
	Wed,  3 Aug 2011 18:07:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SWvw2Offwd8LXZzATrtmrNNHxTQ=; b=h1m3Rr
	8yH+I3vGrAA4j/FrJSvpwMK24GKrvGSF0xkVvSBgH6/U0x22qBj08RJHc7fZeual
	EH1Ma0f00nEgyhPRX6qhjNOfGvnFtNHHwpHo06RCm6CWH8vraYzM6J4mAPf8TtS6
	RcJ1Js3xrNL87mma5U6vIgvrmg9s45d5XXVow=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iyxJKXjyj0G2fDQuQ3C1qlK2WHnJEymK
	Rgk1w2Sia1j1JWa+D0cYRQyd7TTkuxUolsC3vj0RLfUX69If5OF9zOsRFMvnql8t
	Gi+xrhdN6JGgmi40yaeawOSL5a8auuBvyo5Rx5AZ+9nftFosE2ruMADrrF34nw8P
	8C7O7LgoaiM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 332D647DB;
	Wed,  3 Aug 2011 18:07:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9441D47D8; Wed,  3 Aug 2011
 18:07:30 -0400 (EDT)
In-Reply-To: <20110803192828.GA4228@toss> (Clemens Buchacher's message of
 "Wed, 3 Aug 2011 21:28:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB565226-BE1C-11E0-8841-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178637>

Clemens Buchacher <drizzd@aon.at> writes:

> On Tue, Aug 02, 2011 at 02:31:47PM -0700, Junio C Hamano wrote:
>> 
>> Perhaps "common_prefix()"?
>
> Yes, I was thinking the same thing actually.
>
>> Don't you also want to consolidate dir.c:common_prefix() with this?
>
> I wasn't aware of it. I'm really swamped right now, but I'll take a
> look at it soon.

It is not too big a deal, though, so I'll merge this one to next and we
can fix it up in-tree later.

Thanks.
