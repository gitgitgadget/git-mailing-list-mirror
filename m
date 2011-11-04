From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Fri, 04 Nov 2011 13:16:08 -0700
Message-ID: <7vlirvbq47.fsf@alter.siamese.dyndns.org>
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
 <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Fri Nov 04 21:16:23 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RMQBZ-000275-Tv
	for glk-linux-kernel-3@lo.gmane.org; Fri, 04 Nov 2011 21:16:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874Ab1KDUQN (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 4 Nov 2011 16:16:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750916Ab1KDUQL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2011 16:16:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6D85A5262;
	Fri,  4 Nov 2011 16:16:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XSYrqZ4AvX5aoxET+i1mQ87q9BU=; b=d0wiwo
	40VKidYlmGpV8wZXTIX7yRbZuRo0+P8Mwp6B+2BK0Y/Ep/zvyHFxugTv+G537jR4
	9QGtVkZvP0bPcLMJ9VvjKL1VwVmOe/JA+oIr8Q8288rzTgCgTIOfqCNn8nFqQ/+8
	gQtNkkaaABWdncpvDBankzDUcjjJOeTkHZxRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LAOqvAm+lBBSNX9pzo86HAPXBJbnd1uV
	qy3sis3aZd62IfXm4u49fctUgK37sr8mrYCUuFe2MunO+82OsjmjM8SabQgtBJ44
	8gnXRZ/0hYyCa6a1rBDESQgoV2VEBm2JZkNHuAtG0+zIKLsgVhcptz2Fqb8HfeIP
	UatoVOrQILM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F3D55261;
	Fri,  4 Nov 2011 16:16:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DDF65257; Fri,  4 Nov 2011
 16:16:09 -0400 (EDT)
In-Reply-To: <CA+55aFzstE-+NzfSAWMEokB7-rYsZOcZe9Ez-LxPNOKnciJ3UQ@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 2 Nov 2011 19:19:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D588C0D0-0721-11E1-AC50-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184802>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I suspect we should just apply this patch, but I didn't check
> exacty what the failed tests are - except for the first one, that just
> compares against a canned response (and the canned response should
> just be changed).

After applying your patch and running

$ perl -pi -e 'if (/\ttag /) {
    s/754b754407bf032e9a2f9d5a9ad05ca79a6b228f/6c9dec2b923228c9ff994c6cfe4ae16c12408dc5/;
    s/0567da4d5edd2ff4bb292a465ba9e64dcad9536b/c61a82b60967180544e3c19f819ddbd0c9f89899/;
    s/6134ee8f857693b96ff1cc98d3e2fd62b199e5a8/525b7fb068d59950d185a8779dc957c77eed73ba/;
}' t/t5515/fetch.*

to unpeel the three tags used in the test 5515 that used to expect
FETCH_HEAD to have peeled tags to expect tag objects themselves instead,
all tests passes.

> although I suspect it was just a fairly mindless case of "make it a
> commit, because the merge needs the commit" - never mind that the
> merge would peel it anyway.

I am 100% sure the machinery that comes up with the tree (or half-merged
conflicted state) does not mind being fed tags. After all they need to
peel them down to commits for common ancestor discovery, and they need to
further peel them down to trees to perform three-way merges.

However we would need to audit so that we do not accidentally record the
tag object names in the "parent" headers in the merge commits, which is
what I'll be doing next.
