From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.10-rc3
Date: Thu, 29 Mar 2012 18:54:51 -0700
Message-ID: <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 30 03:54:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDR3K-0003Il-CW
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 03:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759208Ab2C3Byz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 21:54:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39788 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739Ab2C3Byx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 21:54:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E5BA6FCC;
	Thu, 29 Mar 2012 21:54:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3wp4Fo0pxy2V5AnGEfBv7HO7KyY=; b=fzicOZ
	gbqv6Mh61Cf1nOSYZRe4sPbY3hwaoAxqwnkoVSBwy5Re5sctvNFg37qCHcxf05rK
	3MDU5j2fTRpo6kgSB7ryTwEYViKdw3HrfYhrEB/ta6meIIzQaOmS+cPxbG5lg28h
	+CkJV3jXZGW1qLAQI7lnNVdSrVWRnh/M3KVEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h5orCXG2WYKQ5t+eSvsinYPSsRk1N59k
	bUZpLNbWiR6w/hhu9zkaHmNHDS+FPdKzPMwBSLzSl5X5+TQWN7owXF5SZ79SjH1w
	KcO1hgofsqV0SHY3MT8nxRGTu2ZXHMSfI0vI/fzpMtJB45RJ5UFUWOPSaZBq0RZ+
	IdFhDqNdtEs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 46DBD6FCB;
	Thu, 29 Mar 2012 21:54:53 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CD8E66FC6; Thu, 29 Mar 2012
 21:54:52 -0400 (EDT)
In-Reply-To: <20120329221154.GA1413@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 29 Mar 2012 18:11:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57779F42-7A0B-11E1-B38C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194311>

Jeff King <peff@peff.net> writes:

> But I would withhold a decision on "upstream" versus "current" until
> those bugs are ironed out, because what people think of as "upstream"
> (today's current behavior) may not be exactly what it ends up as.
> ...
> Anyway, I didn't exactly want to re-open the upstream versus current
> debate at this point ...

Actually I did want to ;-) An announcement "We would be switching but we
don't know what to" does not make sense.
