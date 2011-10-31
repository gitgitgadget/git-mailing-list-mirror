From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Mon, 31 Oct 2011 15:44:25 -0700
Message-ID: <7vzkggok6u.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <4EAF1F40.3030907@zytor.com>
 <CA+55aFxprv9JR4gtt_UDXheHR5G8PrUA3-Mj0CPsU6E5EzNYeg@mail.gmail.com>
 <4EAF2245.90308@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Mon Oct 31 23:44:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL0am-0008Er-CL
	for gcvg-git-2@lo.gmane.org; Mon, 31 Oct 2011 23:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934690Ab1JaWoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Oct 2011 18:44:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934441Ab1JaWo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Oct 2011 18:44:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80FB66CC2;
	Mon, 31 Oct 2011 18:44:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cnHL1araHZtygn3PksdS/JPrbvE=; b=j73O7w
	g1eAkLOK8uEeE9/E2+mujw7J0fN6zXtM7TNpTEQKcw3EVD2pBFwfcTLOlwFlgoeB
	UfgVLBL12uP5+bn2dHqyyYY/ZmuBVGzKxuXtKjVq+NGvWo7vJzL1Y06Chd/zqoRv
	gdixg9Lsmb4+x6j3wOBgQpe6D37g1i/PJpfO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yr6FhON2Yyi9/QA/E3WF7UhK1nySIKJk
	EEo5uSbmOAH6gr0yyzJEsvdkRoKpD6Qwmz8N+aCcbPomKO2kZcwQPWJBgJmigreU
	vdaq0FDYzkAJtXNHBYSY7J8C2U1Rl2hz5RpF9TM/7ENDiBukmGkDE0Df+mL4tgt6
	hJJSYQU6vtA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74DCE6CC1;
	Mon, 31 Oct 2011 18:44:27 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EFB046CC0; Mon, 31 Oct 2011
 18:44:26 -0400 (EDT)
In-Reply-To: <4EAF2245.90308@zytor.com> (H. Peter Anvin's message of "Mon, 31
 Oct 2011 15:33:41 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E32F54AA-0411-11E1-A693-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184534>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 10/31/2011 03:30 PM, Linus Torvalds wrote:
>> 
>> But if you do the normal "git pull git://git.kernel.org/name/of/repo"
>> - which is how things happen as a result of a pull request - you won't
>> get tags at all - you have to ask for them by name or use "--tags" to
>> get them all.
>> 
>
> Didn't realize that... I guess I'm too used to named remotes.
>
> If so, just using a tag should be fine, no?

So nobody is worried about this (quoting from my earlier message)?

   On the other hand, the consumers of "Linus kernel" may want to say that
   they trust your tree and your tags because they can verify them with your
   GPG signature, but also they can independently verify the lieutenants'
   trees you pulled from are genuine.

A signed emphemeral tag is usable as means to verify authenticity in a
hop-by-hop fashion, but that does not leave a permanent trail that can be
used for auditing.
