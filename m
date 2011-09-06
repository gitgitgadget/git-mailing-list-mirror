From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add option -h
Date: Tue, 06 Sep 2011 09:04:00 -0700
Message-ID: <7vty8pac9b.fsf@alter.siamese.dyndns.org>
References: <20110903170612.GA3536@ecki>
 <7vk49mbvlk.fsf@alter.siamese.dyndns.org> <20110906063236.GA4923@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:04:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0y8B-0000fk-5A
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:04:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090Ab1IFQEG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:04:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754951Ab1IFQED (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 12:04:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 346F14E83;
	Tue,  6 Sep 2011 12:04:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MA3ZzRAEf+WJMo+Vug6w71kNFEM=; b=Npcemu
	ircdMJhHlzEobH+zIfwfxcHTFs6FTjAoiLpxwX9hHfBuYhRrayJSIBSiNa1etiLw
	8dGnz2V4hrpty/pZnnR8x6z/4/TFJVD4Tl5rfusysGoqqNG/cj5sywzIacsvKHQa
	fLQ5XOF7nng3D0cLRFrbnzmfv5dkdVbo8XRH4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VL5XMfAWLpxRTQK6H6VE/iBwt/7lvNUU
	kXQD/7R/d0WA2WTRhnOnPFrRSIvlFwa0SjQ2IfignYCGA5Mjm5pFk63bD1PdUdCS
	YVlFm3PKQvd/0CBebGOXNkiUqxrO/14tey+OLRIv+0w6/9Epvfd8LCrsHeEaORs5
	UDGfVarJNfA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C5314E82;
	Tue,  6 Sep 2011 12:04:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 988124E81; Tue,  6 Sep 2011
 12:04:01 -0400 (EDT)
In-Reply-To: <20110906063236.GA4923@ecki> (Clemens Buchacher's message of
 "Tue, 6 Sep 2011 08:32:36 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6368F34-D8A1-11E0-B14B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180808>

Clemens Buchacher <drizzd@aon.at> writes:

> Just found a few more places, so how about this on top?

Yeah, something like that, except for git-send-email bits on side instead,
perhaps. There is no poing in adding a known bad version first and then
fix with a follow-up ;-).

Also I notice that "git-pull" parses "--help-all" but does not seem to do
anything useful (it gives the one-line "Usage: " message and exits with 0)
which probably deserves a patch separate from other commands.
