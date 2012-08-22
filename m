From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2012, #06; Tue, 21)
Date: Wed, 22 Aug 2012 10:25:55 -0700
Message-ID: <7vzk5m96u4.fsf@alter.siamese.dyndns.org>
References: <7vk3wrc04o.fsf@alter.siamese.dyndns.org>
 <CACsJy8CVe53URvheehhGnxpOdhhidd67UY6OD5KD-X-f9hGBQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Egu-0005mI-8k
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:26:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950Ab2HVRZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:25:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964824Ab2HVRZ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:25:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 41FB89244;
	Wed, 22 Aug 2012 13:25:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nGmToX/6DEDDoRezN9NL9QpaeCQ=; b=KYD7PA
	AEypuE7460NPn2kawRbic0yrqXzJGnF2RsumDCs3WWiQgIL/EZt7kC029ZRfgRtb
	JuzcF2KfflA0JTYRJrVvyZYgP8vtlV/G6hsfofwQ7ApZ7oCtJmrZA7fXB8TIkXgp
	/V+RlWaHSWX1Y/2q9mWnEEjEWHU6Eu1zWzuzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=N2QhgQ+NsOVks6I+hDL458o69P7S11bV
	gyLDIRXfN2BbmrS5VG9Fh8yZ7d4YcUXPiZq1W+GgGxyr4hSKTpKsfR41+CAXOEDO
	0iJjn3rPoruGf8BzpkWT4NRJzD5NAlUxsbp1XYOE9OTlbImp6IggF2EDQgEeZCff
	0dfRSiTdcDw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E1749243;
	Wed, 22 Aug 2012 13:25:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D7969242; Wed, 22 Aug 2012
 13:25:56 -0400 (EDT)
In-Reply-To: <CACsJy8CVe53URvheehhGnxpOdhhidd67UY6OD5KD-X-f9hGBQg@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 22 Aug 2012 20:51:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6EC8E86E-EC7E-11E1-9C3B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204039>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Aug 22, 2012 at 6:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * nd/i18n-parseopt-help (2012-08-20) 54 commits
>>  - i18n: shortlog: mark parseopt strings for translation
>> ...
>>  - i18n: mark "style" in OPT_COLUMN() for translation
>>
>> A lot of i18n mark-up for the help text from "git <cmd> -h".
>
> It's a 66 patch series, but only 54 here. 55/66 [1] to 66/66 [2] did
> not make it to your inbox?
>
> [1] http://article.gmane.org/gmane.comp.version-control.git/203827
> [2] http://article.gmane.org/gmane.comp.version-control.git/203838

I do recall discarding one (the one about _(" tracked")), but
otherwise no I didn't throw anything else away on purpose.

Let me recheck.  Thanks for letting me know.
