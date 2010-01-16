From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] difftool: Add '-x' and as an alias for '--extcmd'
Date: Fri, 15 Jan 2010 17:05:17 -0800
Message-ID: <7vbpguoo4y.fsf@alter.siamese.dyndns.org>
References: <1263539762-8269-1-git-send-email-davvid@gmail.com>
 <1263539762-8269-2-git-send-email-davvid@gmail.com>
 <7vvdf3xiav.fsf@alter.siamese.dyndns.org>
 <19280.51182.981853.561841@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 02:05:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVx6j-0008S9-9p
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 02:05:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543Ab0APBFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 20:05:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758527Ab0APBF3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 20:05:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35989 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758525Ab0APBFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 20:05:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 630C891264;
	Fri, 15 Jan 2010 20:05:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mh9xdC79Wt+ihY6pZsfJ7UIEdpc=; b=s6uuqft7RGIMj/W1dsgiQKb
	Swua887771kQBXzga0A7T4bPxAZJsuQQ/Tk/2+HuXcLc9FmTKOk9eCTkyzUsdJMj
	qO5JDs0wYXUTsK6cPThf05zJhlip5FaPKDOls5Nvy4EuiXK+YkEb4vVtj8XolNPb
	ck8xMbdQmJ79n8m35VdA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=ihnmzraGttGJGP9cqkfy+jdPKrsBlELhFjVTF0IvziJaG52NW
	m+M9+4t6/YyJZQ+1ryWyhDsc0G1Ek3CplSs8DsRYA9crEV5gG6eXJ4e8GXey5bp8
	sO74sezxW2sZFkAk29Uc6Uhj0INQRZiIc95yf5P19SEO/+p9vy4cUQTMYI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AC0691262;
	Fri, 15 Jan 2010 20:05:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5630E91261; Fri, 15 Jan
 2010 20:05:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38AB09E0-023B-11DF-BADD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137182>

Bill Lear <rael@zopyra.com> writes:

> On Friday, January 15, 2010 at 11:46:32 (-0800) Junio C Hamano writes:
>>David Aguilar <davvid@gmail.com> writes:
>>
>>> -# Copyright (c) 2009 David Aguilar
>>> +# Copyright (c) 2009-2010 David Aguilar
>>
>>Just a very minor issue.  I'd prefer to see:
>>
>>	Copyright (c) 2008, 2009, 2010
>>
>>over
>>
>>	Copyright (c) 2008-2010
>
> Why?

I learned this from <http://www.gnu.org/licenses/gpl-howto.html>.  The
advice doesn't say _why_, but my understanding of the rationale behind it
is that the international convention that governs this copyright
notice specifically mentions "the year of publication", not "range of
years" (UCC Geneva text, Sept. 06, 1952, Article III 1.).

Berne convention does not require such a copyright notice, and many
countries are signatories of both treaties, so the whole copyright notice
may be a moot point in many countries, but it matters in some.  As long as
the file (and the GNU advice cited above) is being cautious by having the
notice, it would be better to be equally cautious and spell the years of
publication out.

But I am not a lawyer.
