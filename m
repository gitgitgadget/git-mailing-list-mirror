From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect problems/ideas
Date: Wed, 19 Jan 2011 11:29:41 -0800
Message-ID: <7vzkqwsndm.fsf@alter.siamese.dyndns.org>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
 <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
 <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
 <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
 <7vd3nukqn8.fsf@alter.siamese.dyndns.org>
 <0F4E18EC-E67D-4C3E-BB5C-C8D8BA326C1D@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
To: "Aaron S. Meurer" <asmeurer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 20:29:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfdjB-0006KF-0k
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 20:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752863Ab1AST3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jan 2011 14:29:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984Ab1AST3u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jan 2011 14:29:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1F794C02;
	Wed, 19 Jan 2011 14:30:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEO+xaZy4KF15bDJelj8Zqvl7bs=; b=FKWeX4
	2svYjyDk9qNDcgeW/vKjK+OHTk9dyGQgIOMgS+iVq36wjeQacXPV9M54Zy2xQkHG
	vCd79hGfv40Qnm2bVwpvCh06yAoZNlb8ZzeJl6sjAO41JN8/n63MkDTZb9IeRNsO
	xDMjkWJClIWlyv/VwGM6Ok6jUrzwM2JVvys7M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=myvfsKOT6RYDKQGwuHHuzdKPCN670giE
	O5hKEMv/gBl9GnX4w48tbY+OsVph88iOixKs7cGvo319G+vjgRaGrUN0FLMhprmo
	bQOj5x1yywACXPBbf6dLXf43TlOiSAE63/LFuytyNe9Ya7AXcsjmuiZ09mB6KQsW
	sD2tnqNqqOE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9AB654C01;
	Wed, 19 Jan 2011 14:30:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 738F64C00; Wed, 19 Jan 2011
 14:30:28 -0500 (EST)
In-Reply-To: <0F4E18EC-E67D-4C3E-BB5C-C8D8BA326C1D@gmail.com> (Aaron S.
 Meurer's message of "Wed\, 19 Jan 2011 12\:15\:15 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 94CA714A-2402-11E0-91CE-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165281>

"Aaron S. Meurer" <asmeurer@gmail.com> writes:

> So if I care about this issue I should keep bumping it until it gets fixed?

Depends on your definition of "bumping".  If it means "whining repeatedly
without adding anything to help resolving the issue", then no.

I thought the previous discussion was stuck after a small step by Dscho in
the right direction because nobody followed through?
