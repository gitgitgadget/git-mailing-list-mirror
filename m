From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: Use curl_multi_fdset to select on curl fds
 instead of just sleeping
Date: Wed, 02 Nov 2011 02:17:54 -0700
Message-ID: <7v39e6lw71.fsf@alter.siamese.dyndns.org>
References: <1319901621-482-1-git-send-email-mika.fischer@zoopnet.de>
 <alpine.DEB.2.00.1110292230500.28196@tvnag.unkk.fr>
 <CAOs=hR+YuF+HP0n0132Ktm3RdeWsnVp0Bgt89LNn+VyT6W0mcw@mail.gmail.com>
 <CAOs=hR+u_MrHK4iNFZj4pLVhZ6-_75YpqN7tqWnSjh+di8Lzxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Mika Fischer <mika.fischer@zoopnet.de>
X-From: git-owner@vger.kernel.org Wed Nov 02 10:18:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLWxQ-0002dp-1U
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 10:18:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab1KBJR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 05:17:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35749 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115Ab1KBJR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 05:17:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6BC24956;
	Wed,  2 Nov 2011 05:17:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DhG+9p/5MrgON4HWHe4OsZG3naQ=; b=oNx1lA
	HvtUs5nQnjICAMny5Dl4K08r/AjHvHHLBobEvefPwdHeMcVLPSvyJvsv5CjTYWz5
	sigHzAwZS+cxl+BVoQel/0qEZgVilVFx8/6QaEoYziYT12ru316+kOmP/eKCM20c
	Spqj7pi2DCd1euBkcY5aYkyApAIyTbqPawEzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eDrqUpPZX5Lj//T+oYk/YoWY1KrJJYB5
	BwOUN1NjXMSMg4WewUp7km+EpyJKixLdgfRbtv3mQNI6GOzSydZl/+2A1A9h0Aod
	hlCm18ziuojXOE3S/KwW12rQhPQI3zhPlIWlUeaoEaAXqyWk489l1ieqwp/G/kqx
	ivJjGK53c/E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACAB4955;
	Wed,  2 Nov 2011 05:17:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1ABFD4953; Wed,  2 Nov 2011
 05:17:56 -0400 (EDT)
In-Reply-To: <CAOs=hR+u_MrHK4iNFZj4pLVhZ6-_75YpqN7tqWnSjh+di8Lzxw@mail.gmail.com> (Mika
 Fischer's message of "Wed, 2 Nov 2011 09:21:37 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8CC7DF2E-0533-11E1-B600-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184619>

Mika Fischer <mika.fischer@zoopnet.de> writes:

> Since I'm new here, I don't really know what the next steps are for
> the patch, should I just wait? Or send it directly to someone?

Resend to the list for re-evaluation, and then we can take it from there.

Thanks.
