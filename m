From: Junio C Hamano <gitster@pobox.com>
Subject: Re: imap.preformattedHTML and imap.sslverify
Date: Mon, 08 Feb 2010 15:05:27 -0800
Message-ID: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
References: <7v7hqqxj10.fsf@alter.siamese.dyndns.org>
 <4B7090C7.4040700@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Shearman <robertshearman@gmail.com>
To: Jeremy White <jwhite@codeweavers.com>
X-From: git-owner@vger.kernel.org Tue Feb 09 00:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Necfm-0001id-Mc
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 00:05:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859Ab0BHXFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2010 18:05:37 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49717 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750810Ab0BHXFh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2010 18:05:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFBFD9823B;
	Mon,  8 Feb 2010 18:05:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DkFOvxTgQHsKPB9nwb2TiSIgXg0=; b=NaHnAd
	GdCj1BQTX1VRix23QEK4LIl2dJMl8HFQgDRoMcr7Srsq6qo4tfxY63WVJgMXDjDm
	JGpaO8FJOQ6PzcgVEbGvdFX8BuN0ZMSdeEiV77aBFXjVBMbyrkMX9TznjskHZiab
	mQoUzt8RWr6aDeRtffk/cFyHy1U5LXIL0/GMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aVe6v1wMELVvn9/gdGqruh5/oOW29dTs
	fIY1GDtytV1VCzP2gT8RAIQPfFnREOU2KCuj9icjGuwbWZfsMr5D2Aez/9EeO901
	GCknTLKoPG1H6uLwBmkcJ8w+02kRVGBF7l3QcqIs927YLX0EEHoDw//lDcMIvMVq
	jgX7nc3tzVA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40CB498238;
	Mon,  8 Feb 2010 18:05:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F54598235; Mon,  8 Feb
 2010 18:05:29 -0500 (EST)
In-Reply-To: <4B7090C7.4040700@codeweavers.com> (Jeremy White's message of
 "Mon\, 08 Feb 2010 16\:31\:35 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75A86DAA-1506-11DF-967C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139333>

Jeremy White <jwhite@codeweavers.com> writes:

> I did confirm that your patch does work.
>
> However, I assumed that my original patch was rejected.  
> I never realized that it had been applied.
>
> That clearly means that no one has ever used this option.

Thanks.  I didn't mean to witch-hunt (did I ever say "the originally
submitted patches were untested"?), and I apologise if you took it that
way.  You were Cc'ed because as the origin of the patch you were likely
to be using that feature.

I just wanted to make sure that the problem I thought I saw was real, and
wanted to make sure that I was not overlooking subtleties in the current
code people who are using the feature are relying upon.

Will apply to maint and merge upwards.
