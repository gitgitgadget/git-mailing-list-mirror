From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2011, #09; Tue, 27)
Date: Thu, 29 Dec 2011 14:49:09 -0800
Message-ID: <7vipkzvvru.fsf@alter.siamese.dyndns.org>
References: <7v62h14mdt.fsf@alter.siamese.dyndns.org>
 <CACsJy8A=xg_c9xbNvZH19LamEBsKSOO_X-KP2-wFMAARbeq3Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 23:49:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgOmj-0004fl-Iv
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 23:49:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754793Ab1L2WtO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 17:49:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39472 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754741Ab1L2WtM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2011 17:49:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D0F6612F;
	Thu, 29 Dec 2011 17:49:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=AGMfMNThtVVI
	yxwwgMrb8kzgS3I=; b=nvHNjILPvRhtQwy5iIrL3INFC1OikU/npWvaZEAOseGi
	bCWNMTRfwqrYgDNJb4yUpcfeGriZ1TckP5Zgo5RXdZ3pzUY2SveV9qWvP00Bcbpc
	tx4BM2lp+qywbyRnQGg7lVATVrFjn+/quySZ7SZz9Ndxw2xmVnqZiWVOKFZ1LkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=qYVT8z
	AgfGWndUiUZkFZ2VrCpLHH0F6xkD9a4u/gGZuAX40ld4nfbk4hAhGVQkxhkvd6bZ
	PPEFugdYWBrC+XOFw2/QJicd+/LC6PFYfV/7aWv4rUKbpkbuXJxHioFIvO3VWetH
	tJ404P9x8k6Au1GEsORQz83Srd3MaeT1uE0ks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 034BB6129;
	Thu, 29 Dec 2011 17:49:12 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 731806124; Thu, 29 Dec 2011
 17:49:11 -0500 (EST)
In-Reply-To: <CACsJy8A=xg_c9xbNvZH19LamEBsKSOO_X-KP2-wFMAARbeq3Fw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 29 Dec 2011 18:46:52 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 531A7688-326F-11E1-925F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187788>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Dec 28, 2011 at 6:37 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> * nd/index-pack-no-recurse (2011-12-27) 4 commits
>> =C2=A0- fixup! 3413d4d
>> =C2=A0- index-pack: eliminate unlimited recursion in get_delta_base(=
)
>> =C2=A0- index-pack: eliminate recursion in find_unresolved_deltas
>> =C2=A0- Eliminate recursion in setting/clearing marks in commit list
>>
>> Expecting a reroll.
>
> Hmm.. I thought you could easily squash the fixup in. Any reasons for
> a reroll besides the fixup?

The parts that needed fix-ups are the only parts I read. I didn't see a=
ny
comments on the list from the reviewers, and I think it is because nobo=
dy
read to comment on a series that needs such a quick fix-ups to compile =
and
run.
