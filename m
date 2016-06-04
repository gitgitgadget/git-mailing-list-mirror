From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2016, #01; Thu, 2)
Date: Sat, 04 Jun 2016 09:24:36 -0700
Message-ID: <xmqqinxozzuj.fsf@gitster.mtv.corp.google.com>
References: <xmqq4m9aqn4d.fsf@gitster.mtv.corp.google.com>
	<20160603232653.GA24538@glandium.org>
	<xmqqvb1pzvfu.fsf@gitster.mtv.corp.google.com>
	<20160604051458.GA3149@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jun 04 18:28:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9ENX-0002HJ-3i
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 18:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbcFDQYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jun 2016 12:24:43 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55209 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750996AbcFDQYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jun 2016 12:24:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 12AF91E8F2;
	Sat,  4 Jun 2016 12:24:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IfUPaTgEkbg77WstW3uxfhN0sNY=; b=uEE95w
	y1PIRiQoWl/ZdmsisLab75FJbQVIt78qE7HBeQzL66gXhwuGdt5SvhpU8nnC+z9p
	JbOMzxG5/AKfabTrbWE9mr0N5VwfiLbIJ/EcxGegmohkrr/BPfn7UXqcZFJyHcZ0
	Yfe5Xabre5IOISCDOreq52haesae8aCCcUq1Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FdZobncFxtLgHbbZQKTZsfPjtwXqlQXm
	8LXryChnmYZY80+0lUXYt/5H84S/oTnVxHnU4757gdvZv5y8Jsoyp/5WInOvnUfh
	D8vgOTawU00WsAq4mv5RNORjw7BYvPfj1GFB0l1VXNogSDIy5X8NiKZQ1gppXnka
	PdjDp1ZiwK0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE8D1E8F1;
	Sat,  4 Jun 2016 12:24:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 893801E8F0;
	Sat,  4 Jun 2016 12:24:38 -0400 (EDT)
In-Reply-To: <20160604051458.GA3149@glandium.org> (Mike Hommey's message of
	"Sat, 4 Jun 2016 14:14:58 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D55CF0BE-2A70-11E6-8DA4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296446>

Mike Hommey <mh@glandium.org> writes:

> From my POV, the desired outcome from this patch series is that there is
> no change of behavior, and Torsten's fix makes
> git://[example.com:123]:/path/to/repo urls handled the same before and
> after the patch series.

OK.

I somehow suspect nobody cares too much about what happens to the
<scheme>://[<string>] syntax where [<string>] is not an IPv6
literal, but if a rewrite is meant to be a rewrite, it is very good
that you two are aiming for bug-to-bug compatible behaviour.

Can we have a final submission to be queued?  I'd rather not to
squash things in to a topic that I wasn't heavily involved in its
review discussion.

Thanks.
