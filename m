From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4] git-p4: add initial support for RCS keywords
Date: Wed, 22 Feb 2012 11:29:53 -0800
Message-ID: <7vy5ruacpa.fsf@alter.siamese.dyndns.org>
References: <1329905741-2092-1-git-send-email-luke@diamand.org>
 <1329905741-2092-2-git-send-email-luke@diamand.org>
 <20120222125327.GA2292@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Scouten <eric@scouten.com>,
	Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Feb 22 20:30:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0Ht4-0005N6-Tl
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 20:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755277Ab2BVT35 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 14:29:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51371 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754734Ab2BVT34 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 14:29:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 20EC97933;
	Wed, 22 Feb 2012 14:29:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qwBKU2NWClCUPys4liEssAE0L30=; b=JzdFaf
	J+x2fdz7tEGUjYJxSRURBIWCS6aJlU20VoDZAzCFqdiw3QMk6d5R0IIxPiBolbPp
	9pbWPRRA1m+Vty4z+nANHqRUnt8poPD7tHd1y3t45P0aUmDNzkM34YjV1Ee20NTw
	y9e+/sTp5Bhl/0yB8weF5hbhc+ori62FuZm44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J46oIiJoTlzrSAikV9h1RV/sbPoSEG2m
	CDtpanq3pvPl789RmqQEBAQ00NjxMIxZ1HQHBVY5re9UsFxPJ52OSyQZI/E2Qkm/
	pf9RwjxFoxWtRDhXh/x5P0ZG91nddYRokpp5ikRH2lGkVFCIO0rrsN+JOK839xrD
	NdERfkewDUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 170187932;
	Wed, 22 Feb 2012 14:29:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F1D27931; Wed, 22 Feb 2012
 14:29:54 -0500 (EST)
In-Reply-To: <20120222125327.GA2292@padd.com> (Pete Wyckoff's message of
 "Wed, 22 Feb 2012 07:53:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9900FC8E-5D8B-11E1-89A5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191270>

Pete Wyckoff <pw@padd.com> writes:

>> Improved-by: Pete Wyckoff <pw@padd.com>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>
> Looks brilliant.  Ack.  Thanks for suffering through N rounds of
> review.  :)

Well, I hate to say that I need to ask another round, to redo this patch
on top of ld/git-p4-expanded-keywords topic that has already been in
'next'; a patch that replaces what is in 'next' will lose fix-ups for
issues I pointed out in the first round that you forgot to follow and were
fixed up locally by me when I queued the existing one.

When working on an improvement to what you have sent out, please make it a
habit of comparing your result with what are already queued, even when the
earlier patches are still in 'pu'.  They often are polished with trivial
improvements (both to the patch and the log message) based on review
comments from people when they are queued, which you do not want to lose.

Thanks.
