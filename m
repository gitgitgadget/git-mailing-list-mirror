From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Revert diffstat back to English
Date: Thu, 13 Sep 2012 14:47:09 -0700
Message-ID: <7vehm561eq.fsf@alter.siamese.dyndns.org>
References: <20120913132847.GD4287@sigill.intra.peff.net>
 <1347545786-936-1-git-send-email-pclouds@gmail.com>
 <7vzk4t960y.fsf@alter.siamese.dyndns.org>
 <7va9wt9377.fsf@alter.siamese.dyndns.org>
 <20120913210111.GA16956@sigill.intra.peff.net>
 <7v627h7hny.fsf@alter.siamese.dyndns.org>
 <20120913212043.GB16968@sigill.intra.peff.net>
 <7vr4q562cg.fsf@alter.siamese.dyndns.org>
 <20120913213121.GA31426@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 23:47:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCHGB-0003zt-8I
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 23:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136Ab2IMVrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 17:47:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50015 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753836Ab2IMVrM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 17:47:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D63228D8F;
	Thu, 13 Sep 2012 17:47:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UD9mOhbziZjGmeUu8dxYuoYODfc=; b=rTsxyl
	DdQRgu+mPfoNQfnHjbZADUWP/J4bn8Im70Gv9s/dzMgA6wY4QPF9E1BqcV0M26R4
	Sc97sXXHdsir5mPCW9rT9aEzO9C9TRM1Tr0BSo5tevHCqmcJHkDU1TuzAm3/4gcP
	/Jf3RxTS3xqGHECYt3cj+sjwYzTReIAABh9Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ioEWFf+w1Hukeilfo9axjxIxXpqScxIV
	ZYZ9hdw3FlB77NwbxJD88ptaackv0kSorf9/uRGDHvXNbCcWcPsrryJA9g42srPu
	VWlGs3xJoLVKnnnKQyY+bL/LQpjT1/FNJAa44SWxvf7uUxXcMkTZbfbpb7sMh9pZ
	q0ij3mMABxM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2BDA8D8E;
	Thu, 13 Sep 2012 17:47:11 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 25FF48D8D; Thu, 13 Sep 2012
 17:47:11 -0400 (EDT)
In-Reply-To: <20120913213121.GA31426@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 17:31:21 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 929BEB0E-FDEC-11E1-8A5D-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205435>

Jeff King <peff@peff.net> writes:

> On Thu, Sep 13, 2012 at 02:26:55PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > I do not think they are incompatible if you separate it into three
>> > categories: machine readable (must never be translated), for the current
>> > user right now (current i18n), and for sharing with other humans
>> > (i18n.projectlang).
>> 
>> Anything you see as a user is potentially useful to other project
>> participants, so I do not think there is a bright line that
>> delineates the latter two classes.  The output of format-patch is
>> obviously meant as the latter, but how about the output from show or
>> log?  Is it worth trying to define the bright line somewhere, only
>> to annoy users who may want to draw the line differently?
>
> I agree that the line is not bright. I do not know if it is worthwhile
> or not. I think it will solve some practical problems, but it may also
> introduce others.  But basically having a per-repo LANG setting (which
> is what the projectlang you are talking about would do) also does not
> seem like a solution that people will use, because they will not get any
> localization benefit at all.
>
> So again, I'd rather err on the side of pushing those things that are
> near the line into the "do not translate" side, letting people use LANG
> to localize the rest, and accepting that occasionally people are going
> to accidentally show you output in a language you don't understand. But
> hopefully that keeps it to "occasionally" and not "every time you send
> out a patch".

I am confused asto what you really want.  In a Klingon-only project,
I think it is perfectly fine to localize the diffstat summary line
to Klingon.  It is not machine readble, and it is not personal, but
it is to be shared with project members, who all speak Klingon.

Pushing more things to "do not translate" side of the line means
robbing the benefit of i18n from people, no?
