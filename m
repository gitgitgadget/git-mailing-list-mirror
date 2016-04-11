From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Hardcoded #!/bin/sh in t5532 causes problems on Solaris
Date: Mon, 11 Apr 2016 09:42:02 -0700
Message-ID: <xmqqpotwrtb9.fsf@gitster.mtv.corp.google.com>
References: <570965B9.9040207@jupiterrise.com>
	<20160409210429.GB18989@sigill.intra.peff.net>
	<57098259.1060608@jupiterrise.com>
	<20160409223738.GA1738@sigill.intra.peff.net>
	<xmqqmvp2ti20.fsf@gitster.mtv.corp.google.com>
	<xmqq37qtthit.fsf@gitster.mtv.corp.google.com>
	<CAPig+cQzGmohkyshwi+yhQHPT_VVb2fr52OK_1Axw4Q2vLxRHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	"Tom G. Christensen" <tgc@jupiterrise.com>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 18:42:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apeuh-0006Jt-Mn
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 18:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbcDKQmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2016 12:42:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60526 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754403AbcDKQmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 12:42:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8BD4053C80;
	Mon, 11 Apr 2016 12:42:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BAvZbYsf7aAtiqLV9yuu0laTgXg=; b=GMc2Hw
	siUK0DWqTnMuLSIRb4lnEC6qS2ZTUj5Lspw86mXOs7HtvK5KC2HiNgjWCAMCky1P
	xMC4PeAJIb3Ys/lq0qNDxSEBAvnSJ2ZlzCgMGlOvpUxAswYT18/ZFEPmnUazGr6F
	f6Sq/4dDF71rW7kj+PpyYehOW5CF0yVj2C4Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ReRaiPuPZrEKqLMXeffVCjO0AX42i5Rf
	o0QgXfeepySmP8t/j9GH5R8YJBkgb6RPhpmPIWkualOp3m7nInx2IhLNjvS61SQc
	p7Sgu0jbjFe9gbsv+JXQGExUpvsT86Fp3hvZ08GIhptxDOGt0dppEeIr3R2LfV2Q
	fhqRXeR9CVM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8072B53C7F;
	Mon, 11 Apr 2016 12:42:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4CA153C7B;
	Mon, 11 Apr 2016 12:42:03 -0400 (EDT)
In-Reply-To: <CAPig+cQzGmohkyshwi+yhQHPT_VVb2fr52OK_1Axw4Q2vLxRHw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 10 Apr 2016 17:51:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5226B8F6-0004-11E6-88AC-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291221>

Eric Sunshine <sunshine@sunshineco.com> writes:

>> with "printf".  The output from the latter is compared with an
>> expected output, again prepared with "printf" hance lacking the
>
> s/hance/hence/

Thanks
