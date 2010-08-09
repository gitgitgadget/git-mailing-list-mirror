From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-log: Clarify --full-diff
Date: Mon, 09 Aug 2010 12:57:51 -0700
Message-ID: <7vmxsv4kzk.fsf@alter.siamese.dyndns.org>
References: <yf9ocddut4h.fsf@chiyo.mc.pp.se>
 <4acdfd58d0ff4aa6b55dab4d4233f55c1b753b5e.1281281303.git.git@drmicha.warpmail.net> <vpqy6cgdybg.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Lars Hjemli <hjemli@gmail.com>,
	Marcus Comstedt <marcus@mc.pp.se>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Aug 09 21:58:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiYUC-0001KF-Qi
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 21:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446Ab0HIT6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 15:58:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754295Ab0HIT6K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 15:58:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A77FFCCBE2;
	Mon,  9 Aug 2010 15:58:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Lnr110qjfipDycgPVfQhobFaBXg=; b=bXSfVAMqMxweyh5Ij9MRysR
	TxGUjCyFZdj9ihl8slJ91cM6EcvbJ57m7klKekzm6L20Y5iBjogdJNX/2YmTV+Oi
	LXrbDCrYTo1KPj26NG463EjXUsryV0dRr9d8Z1SEG0P+4Oa8Eaf+yESWAvJc9HGA
	+Ms1AfLFAJR0nW1B3yIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=OEFR30U+hy+RPKf9EaNHl8SBwqQ5h6PA28Rv/4n2g3o781wNP
	xP65Fepx9R9vjObaBVb4HMoLZ3eky4MqjswjvC3YYHs6gSg+00YUpt9SgCmGS+eo
	T986t0Tu4VewrC7pRAblYJoUFEZnna1NjCSledXPe/nWsbzWmm3pB0jSns=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C320CCBDC;
	Mon,  9 Aug 2010 15:58:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.126]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 338D3CCBDB; Mon,  9 Aug
 2010 15:57:56 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6B4E0350-A3F0-11DF-9176-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153011>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
>
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -55,6 +55,9 @@ OPTIONS
>>  	paths.  With this, the full diff is shown for commits that touch
>>  	the specified paths; this means that "<path>..." limits only
>>  	commits, and doesn't limit diff for those commits.
>> ++
>> +Note that this affects all diff-based output types, e.g. those
>> +produced by --stat etc.
>
> +1.
>
> This also help people grepping for "--stat" to find "--full-diff".

Yeah, I think this is a good change especially to help new people that
come to git community every day.

Thanks.
