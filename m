From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How do I get a list of all unmerged files?
Date: Tue, 26 Oct 2010 09:05:44 -0700
Message-ID: <7v1v7dhrc7.fsf@alter.siamese.dyndns.org>
References: <20101026143245.11433.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "George Spelvin" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 18:06:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAm2A-00017L-Uv
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 18:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759948Ab0JZQFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Oct 2010 12:05:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52751 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755517Ab0JZQFx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Oct 2010 12:05:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7CB80E1D8F;
	Tue, 26 Oct 2010 12:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GTjVWS6EIZHfs84MpQLeAmp4KM4=; b=TY25qq
	nujv61YnwDWQbRy06XdYnA+HmyTOXQwDhAgdtB848ToPu5N6rd6kX3tIgJ78Xn75
	/6Mi1ImiiDFni8PcZRbvPC6cySDxVPrnFy6I24kRg0uT1CXpeG8sU38qYswbbtHR
	PMSKGCl4STnZO2L71FKOid0fmjoxr5amqKn2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MFpkOM1MQfAu4NduYatN8hmbDl8fijcQ
	EebF9gkUJX+HuoGXEM+ReYjPGWDhR88zkggCt+2x/7xXRFYZsxoUp8mVamkcf+pd
	DZjwFDjSBFUGT54dCPN1WLK86B/2guy5bZTUrjH/A6QjGKNSCR2rg2bomncMgA9r
	Ucpd4LuMaKA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5914EE1D8B;
	Tue, 26 Oct 2010 12:05:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AE721E1D8A; Tue, 26 Oct
 2010 12:05:46 -0400 (EDT)
In-Reply-To: <20101026143245.11433.qmail@science.horizon.com> (George
 Spelvin's message of "26 Oct 2010 10\:32\:45 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E64962FE-E11A-11DF-A746-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159996>

"George Spelvin" <linux@horizon.com> writes:

> After a merge with conflicts, mostly resolved by rerere, I want to pass a list of
> all unmerged files to the editor for manual review.
>
> I can see the list (wrapped in a bunch of inconvenient human-readable cruft)
> in "git status".  I can also get a list (again with a bunch of extraneous
> info) from "git ls-files -u".  What I can't figure out is how to get
> "git ls-files -u" with --stage turned *off*.

"rerere status"?
