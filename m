From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: don't link to example mail addresses
Date: Mon, 17 Dec 2012 11:57:33 -0800
Message-ID: <7vr4moladu.fsf@alter.siamese.dyndns.org>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
 <20121216120405.GA14320@sigill.intra.peff.net>
 <20121216140029.GE2725@river.lan> <7vehippg91.fsf@alter.siamese.dyndns.org>
 <20121217120253.GA21858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 20:58:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkgp4-0002PG-RV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 20:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753658Ab2LQT5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 14:57:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47820 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753410Ab2LQT5g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 14:57:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B3D294C7;
	Mon, 17 Dec 2012 14:57:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fv57JZK06RvRTpcQAr9cIdLsZPY=; b=oglFw1
	GonidRYB2JFysZvMhlJ2dyNhnMzsk2qDKOawgIMc4PpbFAHY8KiI3aWSnW8Zh2OG
	LOmZjKNac4EqNb+Jh+ovnd2wRuM9ItgZbHk2AuzYSFQ54fj/8ELM3ioL6NdaWpE/
	34dS0bPNbPySylZhZ94KKepATgH1cXV8sfovM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G1zWRMq89jgA9t2yhHNrrz6GU69XT6Yl
	zB5VXJTyp7TWjiOemd5v9nqXTCeyCMgDg7OMLP1Gi6DuG8S7FTSM/lcc5WLzzmAo
	opVG6G000kVWkwGBbMhhSPnGpsChpgolZ4BerK2LFN797g0YaSBzvtT7sptg5lBn
	0EBBP8J1+7c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB6B194C6;
	Mon, 17 Dec 2012 14:57:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 52DD294C4; Mon, 17 Dec 2012
 14:57:35 -0500 (EST)
In-Reply-To: <20121217120253.GA21858@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Dec 2012 07:02:54 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 005C4C88-4884-11E2-ADEE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211696>

Jeff King <peff@peff.net> writes:

> On Sun, Dec 16, 2012 at 06:24:58PM -0800, Junio C Hamano wrote:
>
>> I seem to be getting
>> 
>> (<tt>`\cm@example.com'').  `LT</tt> and <tt>GT</tt> are the literal less-than (\x3c)
>> 
>> out of this part in the resulting HTML output, which is probably not
>> what you wanted to see.
>> 
>> I have a feeling that it might be a better solution to stop using
>> these pretty quotes.  It's not like we use them a lot and a quick
>> scanning of "git grep '``'" output seems to tell me that many of
>> them should be `monospace output`, and the rest (mostly references
>> to section headers) can be "Section".
>
> Typographically speaking, I would also be just as happy to use regular
> double-quotes throughout.  But here's an example where they also caused
> a problem (which was fixed by moving to smart-quotes in f34e9ed):
>
>   http://thread.gmane.org/gmane.comp.version-control.git/163067

I agree with the typography argument.

Many monospaced fonts used in the windows where the programmers view
the source of the docmentation, a 'normal' single quote does not
slant by the same amount to the `opposite` quote, so ``a pair does
not balance'' visually in the source.  And the whole point of
writing documentation in AsciiDoc is to keep the source readable.
The use of pretty quote throws discards that primary benefit of
choosing AsciiDoc in the first place.
