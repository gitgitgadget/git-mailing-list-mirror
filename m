From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [git patches] libata updates, GPG signed (but see admin notes)
Date: Wed, 02 Nov 2011 14:13:26 -0700
Message-ID: <7vipn2i5xl.fsf@alter.siamese.dyndns.org>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jeff Garzik <jeff@garzik.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-ide@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Nov 02 22:13:37 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RLi7s-0005hH-Ce
	for glk-linux-kernel-3@lo.gmane.org; Wed, 02 Nov 2011 22:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab1KBVNd (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 2 Nov 2011 17:13:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52631 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886Ab1KBVN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2011 17:13:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF776524E;
	Wed,  2 Nov 2011 17:13:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=og8IA0fpMkcxj19UVH/XnkqxxzQ=; b=AkmmH5
	AtPa79zQAMLDnyCICv/VIPmsyTrXrUHPTMLzckP9J44WfRFlSb9Bq+BtIjlD27pa
	V1T+WNAKeMliDwZ3eG4qJBgpjJHwBs7cPIW+zB+a74vzSfkg+RaaZLojuPIqkiWC
	jLGk7NkzloX3PotUxAnKy0Uo5s+9OhtMx1WVY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JnWNVHhAQtzkLQ86p0P6ztGPR8I9tB3I
	SgX8E70CPcSvfgSnDe6EModKzz51m+VyzX9aWWhbAuaYonMPHcHhTj/AdmrzeE3p
	i4Jzgh/5K7w8zdc/4/7tDKP3V+Z5IchRKhMUzPgTYbsAn499JTG7DPH4bjrg0k+z
	mK4qfP/9oiI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B4146524D;
	Wed,  2 Nov 2011 17:13:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 38A98524B; Wed,  2 Nov 2011
 17:13:28 -0400 (EDT)
In-Reply-To: <CA+55aFz7TeQQH3D4Tpp31cZYZoQKeK37jouo+2Kh61Wa07knfw@mail.gmail.com> (Linus
 Torvalds's message of "Wed, 2 Nov 2011 13:04:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 825746EC-0597-11E1-B687-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184670>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And "add a fake empty commit just for the signature" is not the answer
> either - because that is clearly inferior to the tags we already had.
>
> I dunno. Did I miss something? As far as I can tell, the signed tags
> that we've had since day one are *clearly* much better in very
> fundamental ways.

Ok, back to the drawing board (which is not a loss as I wasn't expecting
this to be in the official release in upcoming 1.7.8 anyway).
