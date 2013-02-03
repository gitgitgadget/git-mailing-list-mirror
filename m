From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #01; Fri, 1)
Date: Sun, 03 Feb 2013 11:43:55 -0800
Message-ID: <7v8v759o90.fsf@alter.siamese.dyndns.org>
References: <7vwqur8z4s.fsf@alter.siamese.dyndns.org>
 <7vlib69cjh.fsf@alter.siamese.dyndns.org>
 <CAJDDKr6bPjKwe3NitvGCec2LyesY3yL=UtN85Bsox-bGWN=qeA@mail.gmail.com>
 <20130203130237.GS1342@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Feb 03 20:44:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U25UJ-0004Y7-1a
	for gcvg-git-2@plane.gmane.org; Sun, 03 Feb 2013 20:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab3BCToE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2013 14:44:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431Ab3BCToD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2013 14:44:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7ED4BD24;
	Sun,  3 Feb 2013 14:44:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QjrKpER4mflXECfcFW62aES1a7U=; b=gbKX6H
	VDehYzACa3fVP+JvHO8Hu96/iiS0Mgp3n4YGElvPRSBwxJsc4WxzFI8js9bvbdtI
	VYGoRfsrrKJrK8aX7UjOwn+/rE7uj5BWtGrjkhXjGdq+RhyCXgDYYvHWGwQXR8Je
	sxuWfgp6FhFfKo5Xz29BETo3SMD8qd31rPKmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YxfPtFWnqEHt0FUbuyNfikF5hhD6JbZH
	sXJOKe+Z3U34VymilyOartFzt3ckzhTHK0phpGBIt2RMghqihPE4NzQolSShiBi2
	QtbB3T5LRsXRtx0jYrcHekFiOXDNnoapqBrAbqiEmddznN7ZYLiXxRVsZsBCLVwi
	qG6TWXxgJ0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A4269BD23;
	Sun,  3 Feb 2013 14:44:01 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 78550BD22; Sun,  3 Feb 2013
 14:44:00 -0500 (EST)
In-Reply-To: <20130203130237.GS1342@serenity.lan> (John Keeping's message of
 "Sun, 3 Feb 2013 13:02:37 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E80A3DC-6E3A-11E2-A5D5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215326>

John Keeping <john@keeping.me.uk> writes:

> On Sun, Feb 03, 2013 at 04:13:22AM -0800, David Aguilar wrote:
>> It looks good to go.  The additional "|| :" in the makefile is a nice
>> touchup that made it more robust too.
>
> Looks good to me as well.

Thanks, both.
