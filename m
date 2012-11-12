From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Patch 1/1] Wire html for all files in ./technical and ./howto
 in Makefile
Date: Mon, 12 Nov 2012 12:13:16 -0800
Message-ID: <7vvcdah95v.fsf@alter.siamese.dyndns.org>
References: <20121025094205.GI8390@sigill.intra.peff.net>
 <139737172.296334.1351014913982.JavaMail.ngmail@webmail16.arcor-online.net>
 <1531209463.296427.1351015084181.JavaMail.ngmail@webmail16.arcor-online.net>
 <884264929.71955.1351535627736.JavaMail.ngmail@webmail09.arcor-online.net>
 <20121029215739.GG20513@sigill.intra.peff.net>
 <7vpq3iiukk.fsf@alter.siamese.dyndns.org>
 <20121112191953.GA4623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Ackermann <th.acker66@arcor.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TY0Nw-0002sN-Nu
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 21:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721Ab2KLUNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 15:13:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41560 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752085Ab2KLUNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 15:13:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 651419DDB;
	Mon, 12 Nov 2012 15:13:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qPoEg8zLWFsNukbsjqLRsBBM54Y=; b=Q1GE5O
	QvxiGn5xRXNX2UkNIaK1LIOlUeANhrtm1xpFiAtyZMW6qwFyQq87j9KFfidYHbGn
	EREQtdXTr/0B2gqYPXZxoHEW3MtSNg10h9iDZXcP+rF68qVCg9esCNYSHrQfIIyN
	8egc4bviLwsY4r5ewfNaXsgqYFkMlAsGB0RcA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jZQZ0bTSp6VKbrjZTSchrHd6h3/SZCW8
	8yh+mdDrMhyCUrcgmDS0flxKBaRkt1VaZKYd451ngF0+F0oJRD1A4Ch5sJkxIK6O
	c4Ky2dk8o4uHuL4ip+DoQarlpnpeD+0w7abRLWNlrMLV09ju6TYM0lb+Wu2MPExa
	LiTuv3OgolE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F2C9DDA;
	Mon, 12 Nov 2012 15:13:18 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AC9FE9DD8; Mon, 12 Nov 2012
 15:13:17 -0500 (EST)
In-Reply-To: <20121112191953.GA4623@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 12 Nov 2012 14:19:53 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 659915F8-2D05-11E2-9BA9-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209517>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 12, 2012 at 09:45:31AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Mon, Oct 29, 2012 at 07:33:47PM +0100, Thomas Ackermann wrote:
>> >
>> >> This patch addresses Junios comment in WC:
>> >> "Misapplication of a patch fixed; the ones near the tip needs to
>> >>  update the links to point at the html files, though."
>> >> 
>> >> See older mail in this thread:
>> >> [...]
>> >> That means that for the patch [6/8], which adds content-type to the
>> >> text files, to be complete, it needs to update Makefile to produce
>> >> html files from them.
>> >> [...]
>> >> So IMHO no open issues with this patch.
>> >
>> > OK, that explains the situation. Thanks, I'll merge it to master in the
>> > next iteration.
>> 
>> What happened to this topic?
>
> I mistyped in the above response; it should have been "next" not
> "master".

Ah, ok, I was just wondering why I didn't see it in your 'master'.
Thanks.

> But then I forgot to merge it to next in the last iteration; it is
> ta/doc-cleanup in pu, and is marked in "What's Cooking" to be merged to
> next.
>
> -Peff
