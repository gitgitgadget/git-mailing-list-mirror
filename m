From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2] Documentation: flesh out  =?utf-8?B?4oCcZ2l0?=
 =?utf-8?B?IHB1bGzigJ0=?= description
Date: Mon, 02 Aug 2010 06:30:39 -0700
Message-ID: <7v7hk9p2f4.fsf@alter.siamese.dyndns.org>
References: <20100801025439.GA9592@burratino>
 <7vbp9lprcs.fsf@alter.siamese.dyndns.org>
 <201008021434.13748.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Geoff Russell <geoffrey.russell@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 02 15:31:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ofv6b-00012A-IE
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 15:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0HBNay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 09:30:54 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39206 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab0HBNax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 09:30:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 78BD9CA493;
	Mon,  2 Aug 2010 09:30:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NmDubOilCqgBFXghVcXKV1WeM6w=; b=yPbgkf
	UEpocBiAtz9LR1ARZDcvhK5mPjB4JZHGZ9bXi7mFfFu6Zl2uapc3KXHPHJrDszN6
	NXKPoACbZgIErhBC42lk6i2Vj3HiNIQR68sQfnIXPmnV3m3G4Ee5IMyciR/qqO0o
	S3NDbWhFsNpWEKf64cj/FEK1Zu5smPZuLieME=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eS5roA+glpIjxZlTkhu+yOBrdLnFlD/c
	V2HOaGBIfpGBEpq41vXwPZH2lSkFQ4cEksZSV11Fn4ztIVhgWhXVR0zkI3UtheGx
	6kOS4wwb6RqwBzezEXvu4OyJWK1VUSvkNPnMBITSqCGpjpy854DeV56fzQxwNBlJ
	bAWARPpJwro=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 23B88CA48F;
	Mon,  2 Aug 2010 09:30:47 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 253A4CA489; Mon,  2 Aug
 2010 09:30:41 -0400 (EDT)
In-Reply-To: <201008021434.13748.trast@student.ethz.ch> (Thomas Rast's
 message of "Mon\, 2 Aug 2010 14\:34\:13 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 289E3DE2-9E3A-11DF-B007-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152409>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> > Junio: ideally for this to work, git-pull.html would need to get the
>> > same special treatment as git.html gets.  Does that seem doable?  Is
>> > Meta/dodoc.sh still the script to do it?
>> 
>> I am a bit reluctant to see stalenotes[] being abused; that ugly hack is
>> in effect _only_ while k.org documentation is being built to hang the "You
>> are reading the latest dev version, newer than anything released" sign on
>> the front door.
>> 
>> People with older git have documentation shipped with their versions, no?
>
> The problem is that google invariably turns up the 'master' docs at
> k.org when you look for a git commmand (and that we point people to
> them all the time on #git).  Hence I suggested not outright removing
> this safety warning from the docs that even people running 1.5.x will
> read.

I think the longer "In git 1.7.0 or later" with "Warning: in olden days"
can appear in everybody's version without causing any harm.  That way, it
is shown even to somebody who came to docs/v1.7.3/git-pull.html at k.org
from sideways.
