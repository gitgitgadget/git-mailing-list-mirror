From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Latest master failing t7401 submodule tests
Date: Wed, 03 Mar 2010 11:45:19 -0800
Message-ID: <7vhboxqje8.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 20:45:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmuVj-0001tH-Bo
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 20:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756365Ab0CCTpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 14:45:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756334Ab0CCTp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 14:45:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0BDC09E132;
	Wed,  3 Mar 2010 14:45:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tfENAh7O5kkrBjPO6ymwTi5al58=; b=ie+OpJ
	JL1MHrgr/MjO8e/vvTAI+xIkhEIc1qNim93bCRFPHOiFVy9KRozim8V5irOOc9PW
	ZYOnn6ejweCBdIPsT8jPTUnsTR7MElBXn+G8YwtgbCD+ju/mBX2H6Uhvcmx5CJmR
	GrFgnPdcSbFVBWYE/PAQ9LAiHabiGF2h+XvmA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F4DgX8wT+OaKf95rbFBmw8xfpHK69CfM
	up7/Vy/+UdaV1rwFVSrFHNyQ8IQA8zMhcIryA4qcWRj99IuKkPlPqdUFmTyFnFxF
	HNUdtLuDYGiqi9mb/q4xuor+udlljQ4Upki8cW8Rpgq8CikDrsw1WmOGmEPJCTSo
	fRWcRAolf80=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DEBDC9E131;
	Wed,  3 Mar 2010 14:45:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57CD99E128; Wed,  3 Mar
 2010 14:45:21 -0500 (EST)
In-Reply-To: <4B8E5450.3040702@gmail.com> (A. Large Angry's message of "Wed\,
 03 Mar 2010 07\:21\:36 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4F06C990-26FD-11DF-8015-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141462>

A Large Angry SCM <gitzilla@gmail.com> writes:

> 13 to the 18 tests in t7401 submodule test jig are failing with the
> latest master this morning.

Do you mean v1.7.0.1-138-ga75bab5?

I don't see it with Debian 5.0.4 on x86_64 (my primary box), Fedora 11 nor
FreeBSD 8.0 (the latter two are kvm sandboxes pretending to be i686).
