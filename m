From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: Introduce diff.algorithm variable
Date: Sun, 11 Mar 2012 22:42:17 -0700
Message-ID: <7vsjhev0hy.fsf@alter.siamese.dyndns.org>
References: <06652d553040ad6b25608dc69d632f1ee38eaeca.1331300343.git.mprivozn@redhat.com>
 <7vmx7p62k1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, peff@peff.net,
	Lawrence.Holding@cubic.com
To: Michal Privoznik <mprivozn@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 12 06:42:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6y23-0001Cr-SP
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 06:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752268Ab2CLFmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Mar 2012 01:42:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2CLFmU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2012 01:42:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3339363A;
	Mon, 12 Mar 2012 01:42:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oIb6svta4fYgVDgYj0JrK16vJMI=; b=Uz9W3G
	HloUbtVA5yWCKZabrTZvidDRTOw06E6pGQUApKYuyxMxqdFpO4Fc5wmQBMi9PM7I
	bUkKW3+CDgy3XTt7u7UtRe6ZomfeZdb26Vzv7FzN/H574iqtGLWo2B8+2HoqwZhu
	A6HL27v91hoZz+8jvu0AOrsxbBVY8EtP3JAEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0cgfy3jX2ETZXY1sI4tKoQlnCMZxhcr
	vJK+p3GTOG+pzZ/FpWcKtoCU16660tc1ESs+EOneIg9eDqIpMZp7eyxvx7YdhLJJ
	u7yFMly53Q7JVQqJeIg7l6sYONS9/9Xi1+WSZFov8+WxiY+ebjAgq8mWKqsI3DTW
	lC1Yo9zPxKM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99EA93639;
	Mon, 12 Mar 2012 01:42:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2A7163637; Mon, 12 Mar 2012
 01:42:19 -0400 (EDT)
In-Reply-To: <7vmx7p62k1.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 09 Mar 2012 10:40:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 21E17EBA-6C06-11E1-9E01-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192838>

Junio C Hamano <gitster@pobox.com> writes:

> The last two hunks gives me a queasy feeling for some reason.  I
> think I recently saw a patch to clean up this area to clarify that
> PATIENCE/HISTOGRAM are not independent option bits (but I cannot
> remember where) and we probably should use the approach taken by
> that patch.

I did some digging; no wonder I remember it---it is one of the stuff
I wrote and then later discarded.

  http://thread.gmane.org/gmane.comp.version-control.git/191036/focus=191038

I think this "algorithm" thing should build on that patch, even
though the later parts of the series in that thread has turned out
to be unwanted.

Thanks.
