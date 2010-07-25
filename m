From: Junio C Hamano <gitster@pobox.com>
Subject: Re: new platform & S_IFGITLINK problem
Date: Sun, 25 Jul 2010 10:29:09 -0700
Message-ID: <7vwrsjcvx6.fsf@alter.siamese.dyndns.org>
References: <1272756555.13488.1314.camel@jetpack.demon.co.uk>
 <7vfx2b2ft5.fsf@alter.siamese.dyndns.org>
 <1279815812.7796.5499.camel@jetpack.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alan Hourihane <alanh@fairlite.co.uk>
X-From: git-owner@vger.kernel.org Sun Jul 25 19:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Od50x-0001Vc-Nr
	for gcvg-git-2@lo.gmane.org; Sun, 25 Jul 2010 19:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab0GYR3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jul 2010 13:29:20 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab0GYR3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jul 2010 13:29:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AC82C7E18;
	Sun, 25 Jul 2010 13:29:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dM5sYE1+Q9PntDtiU5I4mgMplos=; b=ZYPNHj
	p0Q278lsFe04NT2KYzMRaJRpGjf9jdgwE5XREEFj2q1Ov6dpE4v5pAJzQU0GiKMm
	FrKwuvCrIGxF8PTUPdDySzxoQ76l138+hGrRh+RLpAxzpZEDn10i9BNoiAb/uL75
	olvhV2+dY2PK52z6Eidfz4fcKfMhrMOlR6NII=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XiDP233+zPCYghqDS4Hyr9IeT7NwB0Os
	+ijNzLsZecpnPEZng2jUOwUqtOyM+zBdWNwk9e8LMHLGdmDcYhwZ3dXrW4lXa7Kg
	Ip/KNfmQPsE9Qja9pJ2yV25yGDt3Pry0L1/JNB+F6lQvsyNGcX3vq/WD0xQmEafS
	e9eh2jN0IjI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 68179C7E17;
	Sun, 25 Jul 2010 13:29:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBD2CC7E16; Sun, 25 Jul
 2010 13:29:10 -0400 (EDT)
In-Reply-To: <1279815812.7796.5499.camel@jetpack.demon.co.uk> (Alan
 Hourihane's message of "Thu\, 22 Jul 2010 17\:23\:32 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2485ECD8-9812-11DF-AB9D-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151765>

Alan Hourihane <alanh@fairlite.co.uk> writes:

> Is there any ETA on fixing this up ?

I don't think so, as I didn't see anybody who has a testable system
volunteered to do this nor heard that somebody started doing it.
