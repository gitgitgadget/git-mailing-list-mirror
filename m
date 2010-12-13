From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please pull gitk.git master branch
Date: Mon, 13 Dec 2010 13:45:14 -0800
Message-ID: <7vy67txs7p.fsf@alter.siamese.dyndns.org>
References: <20101212063135.GA7677@brick.ozlabs.ibm.com>
 <7vwrne8tow.fsf@alter.siamese.dyndns.org>
 <7v7hfe74ea.fsf@alter.siamese.dyndns.org>
 <7vbp4q5ddo.fsf@alter.siamese.dyndns.org>
 <20101213210317.GA10027@brick.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexandre Erwin Ittner <alexandre@ittner.com.br>,
	git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Dec 13 22:45:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSGD6-00068k-5b
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 22:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab0LMVp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 16:45:27 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40007 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab0LMVp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 16:45:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 49C812FBD;
	Mon, 13 Dec 2010 16:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6+pPI+UjsxAy7VxXF3CMtoeE774=; b=AV+aGF
	Q9pfOL4oGGAjaCwEP6V4Dgdrm+Bc8u7vfPDubKvb4J23N5cx78y0XQ4/slVWSOL/
	gF24nYAJ8JAPBwLCBKytaPTCI6tV5iX446WE2qrtGkWcnWzZWlfnLf+wQVTyO/pn
	F1uF7Q2fSLTHCats6FmMbz+O751/xIXQmlwQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nr0m92GRjzu5FbCY4TmH9V6KWf+PtX2D
	qrBlSQFH/Z+zUDf+5cP2Zo3zbg1c/IR9W4O5YXb9urhCl8IR9EHr9gMs7QLYfX+a
	nnk1ca1rf4amkxOBbK94vvXeeVVw3hEbbVnd/tF/vJhUsJESfqUbBUEwi1NMa5Tg
	AJB1MgTggus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0858E2FBC;
	Mon, 13 Dec 2010 16:45:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9D9E92FBB; Mon, 13 Dec 2010
 16:45:41 -0500 (EST)
In-Reply-To: <20101213210317.GA10027@brick.ozlabs.ibm.com> (Paul Mackerras's
 message of "Tue\, 14 Dec 2010 08\:03\:17 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 57784258-0702-11E0-95E3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163596>

Paul Mackerras <paulus@samba.org> writes:

> Sorry about the glitch.  The renaming seems like the best idea, since
> all the other .po files have lowercase names.

Usually people spell language in lower and region in upper, e.g. ja_JP, so
to eyes trained in i18n renaming doesn't look very nice.  I just wanted to
know that Tcl folks do not care about that ;-)

> If I apply this patch in my repo, is that going to cause problems in
> yours?  Or, since the commit that adds this file is the head commit, I
> could just rewind it and reapply with the lowercase name.  Do you see
> problems with that?

Either way is fine by me, as the merge I pushed out last night is only on
'pu' that is advertised as unstable.

Thanks.
