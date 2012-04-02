From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 13:50:17 -0700
Message-ID: <7vmx6teu46.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <7vlimegjw9.fsf@alter.siamese.dyndns.org> <vpqy5qejbjl.fsf@bauges.imag.fr>
 <7vobraf057.fsf@alter.siamese.dyndns.org> <vpqwr5ydkqt.fsf@bauges.imag.fr>
 <7vzkatex02.fsf@alter.siamese.dyndns.org> <vpqiphhdfzw.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 02 22:50:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoCp-0003mk-IM
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 22:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752538Ab2DBUuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 16:50:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34361 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752425Ab2DBUuV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 16:50:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0D9B735F;
	Mon,  2 Apr 2012 16:50:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TMo9xMA4KO0nE9yV+geePelINJk=; b=LvK9Gd
	i2d6XrB7Ur+Oo0cdgMZI429pqq9rrerMtoLkUXHLQIHx+/Ll10Iq3il6knBe2nBR
	91msoISuE6AubyfOF8WW9Aap8ziYJnnl/5cJv0TMYEEuM7n9gI6PhQkU+1SZAxFK
	ZSWnQgwPxbpUaDGzjZ57p4J+vYLIHaoi8BDbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T6OhNw26sR0iODNkw/lDwB8Q9V2Twwmu
	MP+T82wAKGgAnu5hUckN82k/nfx0bpFPgCi88w4R+vwoqM0jQnZp2pSNzVNerByN
	GBHkVFvFpqFNWuv1aDB+ZN1Kw3uIfAkc68id/PaDiUatz/jFriy8yjh5egllumIj
	Srbbr9Tt9AQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9845E735E;
	Mon,  2 Apr 2012 16:50:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 32D087357; Mon,  2 Apr 2012
 16:50:19 -0400 (EDT)
In-Reply-To: <vpqiphhdfzw.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 02 Apr 2012 22:40:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 752FBC8E-7D05-11E1-A48E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194559>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> No more words from me on this subthread.
>
> It's a pity. I still have no answer to my question:

That's OK.

The above is not "I hate you enough that I won't talk to you", but "I
realize that I am not the best person to explain".  You'll hopefully get
responses from those who prefer to see 'current' over 'upstream' ;-).
