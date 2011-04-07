From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: allow "-" as a short-hand for "previous branch"
Date: Thu, 07 Apr 2011 16:26:55 -0700
Message-ID: <7vbp0h63sw.fsf@alter.siamese.dyndns.org>
References: <7vmxk164wd.fsf@alter.siamese.dyndns.org>
 <BANLkTikA3dFQpZWC=TC3+zp2FS=uBBxf0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Adam <thomas@xteddy.org>
X-From: git-owner@vger.kernel.org Fri Apr 08 01:27:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7ybY-0000zq-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 01:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757183Ab1DGX1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Apr 2011 19:27:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870Ab1DGX1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Apr 2011 19:27:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FB405AB0;
	Thu,  7 Apr 2011 19:28:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sO+EqZIUUj6SoyYfr8kd9A0WVCM=; b=D2KhCU
	IjOPQdkNzAh3LfBSTNBnwYyB3fHW9LKwGe/HL7XdqWYPX/B+o8JHyl06E3mbldxn
	ymAahMx3xSeT3LfKNvwIRupsRcJZBmtyQ3fhHLQe2+3aK67kJMkFH5UQ6363wNm1
	eoxTGgsxIyYQ60Cp7LXValb/ucabjrSQZMtmc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=REfX+7YiCw356h25ZuMTUhmmJUTzbLyk
	9FKRKrE2Q+4iROn0A+5KYQllI2DGv/mTPRfobKL3rCgr31ePM7faRjekpYrCS/Fk
	no/uVgIvOrE26U8qCdAQGwUCnkClnofiE8NgtRNYH2IvCw9UCqe7Ez05DYM9yKzv
	AFWql94C/lw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D2305AAF;
	Thu,  7 Apr 2011 19:28:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 701D75AAE; Thu,  7 Apr 2011
 19:28:53 -0400 (EDT)
In-Reply-To: <BANLkTikA3dFQpZWC=TC3+zp2FS=uBBxf0Q@mail.gmail.com> (Thomas
 Adam's message of "Fri, 8 Apr 2011 00:13:30 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CEB8DA78-616E-11E0-8DA0-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171096>

Thomas Adam <thomas@xteddy.org> writes:

> I agree this is is useful, but is there a danger of this being a
> common typo, and people merging in previous branches a lot more often
> than they ever intended?  In the case of "git checkout -" that's not
> as fatal, but if I ever mistype "git merge -" -- I'm now left with an
> unraveling exercise to do.

Just like you can checkout the previous branch back if you found you
checked out a wrong branch by a typo, if you found that you merged a wrong
branch, you can just reset it away back to ORIG_HEAD, no?

Or am I missing something more obvious?
