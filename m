From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Relative ls-files
Date: Thu, 24 Mar 2011 07:47:14 -0700
Message-ID: <7v7hboa83x.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=fP+jBpLuxst2rv02pYRmj4HOkv8Yenc-dR-N_@mail.gmail.com>
 <4D89D052.5030801@drmicha.warpmail.net>
 <AANLkTimc7gNKbh3C2hyMtFK6D1OWNALD+GvzmhG5cZrn@mail.gmail.com>
 <AANLkTimdLGgGXGRNVH5+X-cnhK2NWfWx9k0apt-6rr1Z@mail.gmail.com>
 <4D89DCBE.3060400@drmicha.warpmail.net>
 <AANLkTi=BrgZe47Bt5evr_qFzKBL=MY-6NmH22gsRurVV@mail.gmail.com>
 <7v7hbqgc7g.fsf@alter.siamese.dyndns.org>
 <AANLkTi=OJ_o2WQ2W6d30HXQZrg7=W70+fZWrbQPrAs=s@mail.gmail.com>
 <7v39mdhni3.fsf@alter.siamese.dyndns.org>
 <AANLkTin=y=THaQEzgMhyBVLBriJBCa-pVvONXDnzUmew@mail.gmail.com>
 <7vaaglcv9f.fsf@alter.siamese.dyndns.org>
 <AANLkTinYB=ZUTe29Y9ibLVL5z3KhiYmnCpCGcHx=18RJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 15:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2lp3-0005DP-2h
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 15:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756972Ab1CXOr0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 10:47:26 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756968Ab1CXOrZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 10:47:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D032E461A;
	Thu, 24 Mar 2011 10:49:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=NCVK6hmyrdPRwffzYw4JBuynQ/M=; b=KuxkN6w2Yh6muH+kEvvq
	6A3bWENR4UC949H9tkFmxHaCc/GlRb132WKQw+iFEXTRQvgh3aKxk085zGolhe8q
	RP3A9WUJe8TyuPcRsfU3qGzEmZXkjjFyUGPu6tDAr7vPXX6wuONh2LrKV+AAH61I
	Jjrhy0IDqY2FpfWcBPYGnlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DltFDGfWlrkyw4qsHqeq0XpD53TX7QFtTv6B6/wNCgf+9o
	ybDKs6UiwYKgAGlWblr1oB9gJDNA37PRdOlT1dnWcgfcHU5gfBwoZ9l9QKMtJ8r9
	RhwOZ0ytraIMNdPczUoVWJVjXujs03IQshiZPM+zXlY7bLkQBgPhKmxoljmxo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 940BD45F5;
	Thu, 24 Mar 2011 10:49:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 58FF845F0; Thu, 24 Mar 2011
 10:48:57 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB5B48C8-5625-11E0-9B1D-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169920>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Mar 24, 2011 at 5:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Wouldn't it be more sensible to add a bit ("is this a glob or are we
>> expected to match it literally") to each element in the pathspec array,
>> and pass a pathspec whose elements are all marked as "literal" down from
>> ls-tree?
>>
>> The internal matcher (and traversal optimizer) would need to become aware
>> of "not a glob" match (and possibly different kinds of matches like "**/"
>> support) sooner or later, and when that happens you would need something
>> like the above on the caller side in ls-tree.
>
> I think it's possible even now. fnmatch() is only used if
> pathspec_item.has_wildcard is true. So ls-tree.c only needs to clear
> this field for all pathspecs and they will be treated literally. Let
> me try..

Thanks, that would be good.
