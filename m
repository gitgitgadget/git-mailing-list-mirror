From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] difftool--helper: Make style consistent with git
Date: Thu, 18 Aug 2011 10:31:59 -0700
Message-ID: <7vvctubp80.fsf@alter.siamese.dyndns.org>
References: <1313652227-48545-1-git-send-email-davvid@gmail.com>
 <1313652227-48545-2-git-send-email-davvid@gmail.com>
 <CAHGBnuPRsh0WDVSFr0X1Y+nb=94pJVv8=evFQCjdcd_y9ux97A@mail.gmail.com>
 <20110818090810.GA15416@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Tanguy Ortolo <tanguy+debian@ortolo.eu>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 19:32:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu6Rt-0007bb-5Z
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 19:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232Ab1HRRcE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 13:32:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46071 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896Ab1HRRcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 13:32:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C22853040;
	Thu, 18 Aug 2011 13:32:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Icrsu6NvcOfWN02VeMIDqKT/3Mw=; b=A7QF8E
	O3VJPVkKqtW17+QM298MPPUtriaQA6z78uG7jftBhDI6OE5sYy2+R6h/qRN1yw2J
	/RHJReFN4+r3QNf2ySAyMkkCEJiYYZjlhimnHknxfw0SzlbDzt0nCUdRImXHZ9iC
	DK0+lXsEhmCB+/xJoxvmMaBaMO6EnNPTg9GG8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHTISccS3QQ4I6Oe95Y0DL6m/evIDclc
	fFziLrBRibQPTjM5mQMLQBNnGo91eAB/kHlRCIIYt3FEMIlbMCVUNvd3g5Quyr5C
	NxOEvwjuHVMiwNB35nBcEL+IDqR4/01v8y1Va/W9nTrbWgozlppIwnH+DDxLL9BJ
	wLZMJ61uut8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9188303F;
	Thu, 18 Aug 2011 13:32:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F13B2303E; Thu, 18 Aug 2011
 13:32:00 -0400 (EDT)
In-Reply-To: <20110818090810.GA15416@gmail.com> (David Aguilar's message of
 "Thu, 18 Aug 2011 02:08:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FB222326-C9BF-11E0-B326-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179608>

David Aguilar <davvid@gmail.com> writes:

> I am fine reworking it either way.
> There's not a specific note about it in
> Documentation/CodingStyle.
>
> If someone wants to make the final call I can patch the docs
> and rework these patches as needed.

Please stick to (and document if not):

	if test ...
        then
        	action
	elif condition that can become looong so more &&
        	condition needs to be split to next line &&
                even more condition
	then
		action
	else
		action
	fi

Thanks.

You can think of it as "war against semicolon" if you want.
