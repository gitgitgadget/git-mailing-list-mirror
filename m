From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2013, #04; Fri, 18)
Date: Tue, 22 Oct 2013 08:20:15 -0700
Message-ID: <xmqqli1luyc0.fsf@gitster.dls.corp.google.com>
References: <xmqq38nyw7ja.fsf@gitster.dls.corp.google.com>
	<20131019063447.GA18977@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 22 17:20:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYdku-0005T7-1E
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 17:20:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab3JVPUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 11:20:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752541Ab3JVPUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 11:20:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 530084A36E;
	Tue, 22 Oct 2013 15:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J//nparcCWpbnaOnUCPCVG8ZYAo=; b=VVwnyR
	bKfAvIC90VsOUfljYC0SCI/9bufqXoDA0mQb44Cws1vN/ZL2ZVPX1Vg7KpBVshRb
	fe4kAToRUQDcaaOb99UXbFbRpDh3JLy8t3rnPj/o9gKPSM+6vOzcicnZxlatISct
	yZ+DFUX5iYSyuZyRa7RxSxwSaYcWrFEahiX3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jef7rWczMocjNxOOon0Ei1PCSP3qFLL0
	0+xD84MPyEN6jAr1KLbPkEsOCofK0IHv1vu/vmQ/K1i5zh3RJi3lo++88tMqs8wF
	Po9U/Hr5TZyWufwQ8w8OMkNK7B9ttrTMDPZ/WY3MPcA5ZILwpMXJXh6MEMAlb2Mb
	e94F29pbA6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42FC34A36D;
	Tue, 22 Oct 2013 15:20:18 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96BC14A369;
	Tue, 22 Oct 2013 15:20:17 +0000 (UTC)
In-Reply-To: <20131019063447.GA18977@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 19 Oct 2013 02:34:48 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7526B5E8-3B2D-11E3-914C-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236475>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 18, 2013 at 03:14:49PM -0700, Junio C Hamano wrote:
>
>> * jn/add-2.0-u-A-sans-pathspec (2013-04-26) 1 commit
>> * jc/push-2.0-default-to-simple (2013-06-18) 1 commit
>> * jc/add-2.0-ignore-removal (2013-04-22) 1 commit
>>  ...
>>  Will cook in 'next' until Git 2.0.
>
> I notice that these are not actually in 'next', despite the
> descriptions.  Should they be, to give them wider exposure?

We have been running with their respective preparatory migration
steps in the released versions, so we are ready to do so.  These
last steps of the multi-step transition should probably cook in
'next' for a cycle or two before the final 2.0 development cycle.
