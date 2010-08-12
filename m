From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 16/17] Add tests for line history browser
Date: Thu, 12 Aug 2010 13:37:54 -0700
Message-ID: <7v1va3sh25.fsf@alter.siamese.dyndns.org>
References: <1281539022-31616-1-git-send-email-struggleyb.nku@gmail.com>
 <1281539022-31616-17-git-send-email-struggleyb.nku@gmail.com>
 <AANLkTi=qvywaiwYpr7ZZ6Gf0i_curaLr0E8gRLD5WTK-@mail.gmail.com>
 <AANLkTinYaOhNNBj9_6mFF3azaFAwUJgeLVkyax2ZbVOm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jens.Lehmann@web.de, trast@student.ethz.ch,
	gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeXj-00087l-6r
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933998Ab0HLUiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Aug 2010 16:38:16 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36259 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933996Ab0HLUiN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Aug 2010 16:38:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 94533CD71B;
	Thu, 12 Aug 2010 16:38:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o2VsjQ0vtiJ7QZn+u/wUx+R0Q58=; b=dRcvmO
	hgdqc8n+6gRTnNkuhzOc6O81ocmZqnob9YZGY3nHMtk1S1Ma/rWt8fUN4RoWch7a
	CrNSaTxz4c7jyEzRobQJ91Ic2KUdhlwmw+hp27T4yzLhqOVxmAi/q9VXlUv61Dsg
	Jn163fn6OOoKaFpZG/1xzlUSD5dd0iuYRK+qE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sGfk8yt14uwpjcsvZOjLEaqgKEUDJrkE
	Ww4lyBXAIMTEle6nbxLABUENnkx5qzsOH0/e9alLADMGheczFOFJ8jWj45D3sAQ/
	MSqz8veMYmUYrWrultLTbuGeLbR3zjB77YItZnZ/Dnj3pD+dMI/9ys8+aB8KFPG2
	PKw0gf98DIs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 41A54CD719;
	Thu, 12 Aug 2010 16:38:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0BCFCD702; Thu, 12 Aug
 2010 16:37:55 -0400 (EDT)
In-Reply-To: <AANLkTinYaOhNNBj9_6mFF3azaFAwUJgeLVkyax2ZbVOm@mail.gmail.com>
 (Bo Yang's message of "Thu\, 12 Aug 2010 20\:24\:15 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83749094-A651-11DF-A00F-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153414>

Bo Yang <struggleyb.nku@gmail.com> writes:

>    Seems this is the SP problem. Do you apply this series with
> --whitespace=fix ? This will erase some spaces in the diff files,
> so...

That probably is it.  Your patches have other whitespace breakages (mostly
"new blank line at EOF") that I had to use --whitespace=fix to correct
them.
