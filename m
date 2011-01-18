From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bisect problems/ideas
Date: Tue, 18 Jan 2011 10:34:03 -0800
Message-ID: <7vd3nukqn8.fsf@alter.siamese.dyndns.org>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com>
 <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
 <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
 <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Aaron S. Meurer" <asmeurer@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 19:34:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfGNp-00005j-06
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 19:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430Ab1ARSeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 13:34:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042Ab1ARSeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 13:34:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D86E2914;
	Tue, 18 Jan 2011 13:34:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XRYceHKBfOveY/TF/OQ3iOON2LI=; b=gUtTMo
	6QpX9J7dOoBEZIPBQFiZNW/X00D0BQ3rJRzipZjvDwNgALr54APT1SdNBOyr1BcN
	3/zNmbuBnzLUsWU3ytxHa8kIspK5BC2NnXaE1HeEUSv7IOa4cQGy2LdxYV/mUzJa
	K5B4ryqwvc7mgkL0laxnaajN0x4lBmrTiPyo0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kzkZ23wwdD2CbRBQXCOq9akRua94Bxm7
	ZwNYW9PHJQL8QrA0GnElV01RCTWCzQRquUnpzXRtU96VX2wL+gthdpLIsyX+HBd6
	2htle4Ne32qcB/HMcsXrEFBjMv3F9qf+f84YD4dAPvil1tD+1MuUQZYlwQn6XByS
	piBhYrlJWus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CD3552913;
	Tue, 18 Jan 2011 13:34:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A84172910; Tue, 18 Jan 2011
 13:34:49 -0500 (EST)
In-Reply-To: <AANLkTi=A2Twepg3Jo_VYxtvghkhx6ixcpRH3332BoRQo@mail.gmail.com>
 (Christian Couder's message of "Tue\, 18 Jan 2011 10\:04\:29 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A44C7C3E-2331-11E0-8F57-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165209>

Christian Couder <christian.couder@gmail.com> writes:

> Well, bugs are usually fixed within days after they have been
> reported. Otherwise they are usually documented in the code or in the
> documentation or in the test suite (with test_expect_failure).
>
> For the rest we rely on people remembering what happened and on
> people's mailing list searching skills ;-)

Not really.

What we do is to take advantage of the fact that issues people do care
about are important ones, and others that nobody cares about are not worth
pursuing.

In a sense, "people forgetting" is a lot more important than "people
remembering" to filter unimportant issues (issues that are so unimportant
that even the original complainer does not bother to come back and
re-raise it).
