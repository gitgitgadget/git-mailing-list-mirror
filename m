From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] blame-options.txt: place each -L option variation on its own line
Date: Mon, 22 Jul 2013 10:25:04 -0700
Message-ID: <7vmwpecxsf.fsf@alter.siamese.dyndns.org>
References: <1374096332-7891-1-git-send-email-sunshine@sunshineco.com>
	<1374096332-7891-6-git-send-email-sunshine@sunshineco.com>
	<87hafs84jc.fsf@linux-k42r.v.cablecom.net>
	<7vvc473gfe.fsf@alter.siamese.dyndns.org>
	<87txjr4tzx.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <tr@thomasrast.ch>,
	Eric Sunshine <sunshine@sunshineco.com>, <git@vger.kernel.org>,
	Bo Yang <struggleyb.nku@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 22 19:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1JrG-00059S-2p
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 19:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932512Ab3GVRZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 13:25:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58439 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932409Ab3GVRZH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 13:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD04F326E1;
	Mon, 22 Jul 2013 17:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uATj88rBpasl59pNojkWr4m/f1s=; b=VqQE4W
	RWkJk8FosVyLhCAatI7us5jdqUFS22C7N/9xxEWXdXrKsYZfUlRQrT3wqLMtnuoF
	nC7Msiou6CMoFE/6/4J5jIZlPdX3WhrKOi0LeCTg0uU0rotmy7huELYRXffn2+7y
	7xJ0bG3A7Ti2qd48ffVgMH6GPKeZRelRDFO2U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g/xXzvCAXpkego8KWbNOtF0XwJrJ2701
	REivvzHkKm6aFHfYJls9bb23NsKarWGQbVTML6BsUh5GXTMp2N4kzF9pFsXL/aiN
	+O2hflnrEPccg54yho1c9lDnGITayXDPKu34cj8nYTYx4BPgpxxFT9+pqJbzD88m
	Jo/NzJCJzZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3CE2326DF;
	Mon, 22 Jul 2013 17:25:06 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06B47326DC;
	Mon, 22 Jul 2013 17:25:05 +0000 (UTC)
In-Reply-To: <87txjr4tzx.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Mon, 22 Jul 2013 12:38:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A6965D22-F2F3-11E2-AB38-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230983>

Thomas Rast <trast@inf.ethz.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Also I wonder if this one Documentation/git-log.txt:156
>>
>>     git log -L '/int main/',/^}/:main.c
>>
>> should be more like one of these:
>>
>>     git log -L '/int main/,/^}/':main.c
>>     git log -L '/int main/,/^}/:main.c'
>>
>> I find it somewhat hard to spot the closing sq in the middle of a
>> string.
>
> There's a distinct advantage to keeping the sq before the colon, at
> least in my config (and I think I haven't changed the defaults as far as
> this goes): bash will try to complete a filename if you type
>
>   git log -L '...':mai<TAB>
>
> but not if you instead do
>
>   git log -L '...:'mai<TAB>

Interesting.
