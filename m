From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Thu, 03 Nov 2011 11:52:12 -0700
Message-ID: <7vvcr1f38j.fsf@alter.siamese.dyndns.org>
References: <20111026202235.GA20928@havoc.gtf.org>
 <1319969101.5215.20.camel@dabdike>
 <CA+55aFx1NGWfNJAKDTvZfsHDDKiEtS4t4RydSgHurBeyGPyhXg@mail.gmail.com>
 <1320049150.8283.19.camel@dabdike>
 <CA+55aFz3=cbciRfTYodNhdEetXYxTARGTfpP9GL9RZK222XmKQ@mail.gmail.com>
 <7vy5w1ow90.fsf@alter.siamese.dyndns.org>
 <CA+55aFwL_s=DcT46dprcYVWEAm_=WkuTV6K9dAn3wc_bDQU8vA@mail.gmail.com>
 <7vwrbjlj5r.fsf@alter.siamese.dyndns.org>
 <CA+55aFx_rAA6TJkZn1Zvu6u9UjxnmTVt0HpMnvaE_q9Sx-jzPg@mail.gmail.com>
 <7vk47jld5s.fsf@alter.siamese.dyndns.org>
 <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com>
 <CAJo=hJv5nAKH_ptYSWfMvFQv0Dj+naPXK35wSzKYkfPOYsWkxg@mail.gmail.com>
 <CA+55aFx0oCd6-sh0psYxho-s=sHAK0RHXJHfLewRuUcdXzxZbg@mail.gmail.com>
 <CA+55aFwXu=+HdQ5nW11Ts5p-V=KgpxjyagKqB+Xv+qBOEEWXvQ@mail.gmail.com>
 <7v62j1gitn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Ts'o <tytso@mit.edu>, Shawn Pearce <spearce@spearce.org>,
	git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-ide-owner@vger.kernel.org Thu Nov 03 19:52:18 2011
Return-path: <linux-ide-owner@vger.kernel.org>
Envelope-to: lnx-linux-ide@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-ide-owner@vger.kernel.org>)
	id 1RM2Of-00056D-DX
	for lnx-linux-ide@lo.gmane.org; Thu, 03 Nov 2011 19:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756467Ab1KCSwP (ORCPT <rfc822;lnx-linux-ide@m.gmane.org>);
	Thu, 3 Nov 2011 14:52:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46745 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445Ab1KCSwO (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 3 Nov 2011 14:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BFFF6050;
	Thu,  3 Nov 2011 14:52:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F+IoN+dwkm0xU5DWVVy11VYPcLk=; b=GrS/La
	Zd6uv/U2dPErG7Mz0O5PDjgNZABc+ZV9Wv3fM+TeU2vz7XHT7jqVmMdRXxCU2lSW
	ybZqQA6DTa4EyUUyJXDoKVSwEVBxJtxxwu6B2gbAkrU8EOQG1ObdiCVnZuLRVRw2
	hydgOsazgMuHLtD01yjsGwCo+rE7rGgN1KlcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K/giS9ICtPB/+ootIm9MAtxjFQdgU1cM
	gWdK+edcQ2YHk9f8P3rv/gyNfXGsFkphsVx52EsbyQyxYyCY3hXSDbpRYFFhgrdd
	AiRMHktMSEmjXlJLYdyqqAQLlMdKVbXneipEKToKDYHIHyQTTEzRJlIHZOiAT6jO
	f93fgx2FVSg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4317A604F;
	Thu,  3 Nov 2011 14:52:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C19CA604C; Thu,  3 Nov 2011
 14:52:13 -0400 (EDT)
In-Reply-To: <7v62j1gitn.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 03 Nov 2011 11:16:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F197FABE-064C-11E1-8263-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184735>

Junio C Hamano <gitster@pobox.com> writes:

> BUT.

Ahh, sorry for the noise. I realize that we already have a winner, namely,
the proposal outlined in your message I was responding to.

It just didn't click to me that you were replacing "signed material from
pull request copied into the merge" with "contents of signed tag copied
into the merge".

So forget everything I said in the later parts of my response that talks
about refs/audit/*, and the other message except for gpgsig header being a
stronger form of existing committer line.



