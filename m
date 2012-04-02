From: Junio C Hamano <gitster@pobox.com>
Subject: Re: push.default: current vs upstream
Date: Mon, 02 Apr 2012 12:47:57 -0700
Message-ID: <7vzkatex02.fsf@alter.siamese.dyndns.org>
References: <7vd37wv77j.fsf@alter.siamese.dyndns.org>
 <20120329095236.GA11911@sigill.intra.peff.net>
 <7vbonfqezs.fsf@alter.siamese.dyndns.org>
 <20120329221154.GA1413@sigill.intra.peff.net>
 <7vfwcqq2dw.fsf@alter.siamese.dyndns.org>
 <20120330071358.GB30656@sigill.intra.peff.net>
 <7vty15ltuo.fsf@alter.siamese.dyndns.org> <vpqty12h995.fsf@bauges.imag.fr>
 <7vlimegjw9.fsf@alter.siamese.dyndns.org> <vpqy5qejbjl.fsf@bauges.imag.fr>
 <7vobraf057.fsf@alter.siamese.dyndns.org> <vpqwr5ydkqt.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 02 21:48:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEnEV-0005T8-Hh
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 21:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458Ab2DBTsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 15:48:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42346 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab2DBTsA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 15:48:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 856F765AC;
	Mon,  2 Apr 2012 15:47:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XhT3e2MAxNa7eV7NohHX0PS6BpM=; b=fWwqHE
	Xz+qPacIRtfDv3lvTTgp3F06Y5+08lr3IR5/diZWnXUHESyHkO4JNTu+IbcLUQzx
	N7S/0/3LQ+1m7E4SsodkDmrb1DH1dTALgxE/Eua5K6iEC/hgtZ/D1hoM5jT959yv
	7niFlIhlZMhxok/8W6STbp8T9KZZ037dRkN18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LVIm31kto4CgybASC+98hKk+o9TMBl5B
	rrkPHwbHLvKuWV3qPnNmU+qwLV8pZCpnqeDTXZZkXSmOCzFKSiTApK0gdqpr9VRV
	bpYoQHKJXyvKq7jgZm9Hxf+1ss3JTiQeAgqxYkUiLo3JIzN8/Y5/l23pyOHMSGK+
	JnHPyUsLHXo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C4A565AA;
	Mon,  2 Apr 2012 15:47:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14B0965A9; Mon,  2 Apr 2012
 15:47:58 -0400 (EDT)
In-Reply-To: <vpqwr5ydkqt.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Mon, 02 Apr 2012 20:58:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BFE61E98-7CFC-11E1-A5DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194553>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> ...
>> In the former case, you may want to push it to 'topic' to work further
>> with your collaborators.  In the latter case, you would want to push it
>> back to 'master', even though you are calling it locally 'topic' for some
>> sick reason (read: because you can).
>
> I still don't see pull involved here.

Think again.  Hint: realize that these people are not working alone, and
will be keeping their topic in sync with collaborators, and then imagine
how they are doing so.

No more words from me on this subthread.
