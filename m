From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin: move builtin retrieval to get_builtin()
Date: Mon, 17 Nov 2014 08:42:36 -0800
Message-ID: <xmqq7fytzslf.fsf@gitster.dls.corp.google.com>
References: <5463DA20.3080703@inventati.org>
	<xmqq389n2cac.fsf@gitster.dls.corp.google.com>
	<54693454.1040704@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Slavomir Vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Mon Nov 17 17:42:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqPO2-0002rw-46
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 17:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbaKQQmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 11:42:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51982 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751751AbaKQQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 11:42:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F8CB1DC2A;
	Mon, 17 Nov 2014 11:42:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lX/2keZe+MOlKL8hrUYfQ7d9zLs=; b=YDojvg
	cvH+EhAT3N+4mDfc5a1pVCUz42r8LvcxfFjHIBKx7DCV7SzxFM5J8Gp2nOTtfaBd
	JjoHMgBaGv2XXzHP3yW+FwyFgcVT09KSzKEQOtN5m8u4ebudkGNCXDHPSErTpL8j
	U4/dY9AlW5KnwH3tSbdaWE4Rf6GJaO/O0L6aA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h2cy13VTbpEorp+a5gSFT4eKvRCtYf3b
	msyOEL9u52fPkwu04jBC7gHOjffmwdBnYLEw3/XSdpeIis/RstMKEsQud72I5Krn
	5PuGWwrtl40yP/PIZJb871VsKMsNDlaLYJP3DkW20HNaTuIbfK6polQOte/34aID
	W5TlrS4b/JM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 755701DC29;
	Mon, 17 Nov 2014 11:42:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D41071DC25;
	Mon, 17 Nov 2014 11:42:39 -0500 (EST)
In-Reply-To: <54693454.1040704@inventati.org> (Slavomir Vlcek's message of
	"Mon, 17 Nov 2014 00:33:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BE7AB454-6E78-11E4-9FC3-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Slavomir Vlcek <svlc@inventati.org> writes:

> I noticed that the patch has been modified (suggested 'static'
> scope modification, commit message) and added to the 'next'
> branch. So does this mean my task is done [...]?

Even after the change hits 'next', other people may still find
problems and rooms for improvements that you and those who reviewed
the patch missed, and you may have to respond with follow-up patches
on top.  We'll usually give 3 days to a few weeks, depending on the
complexity of the change, for that to happen and call it "cooking
the patch in 'next'".  After that the change will be merged to
'master' so that it can appear in the next release.

For now, the patch you sent is "done", even though you can still
send improvements on top if you want to.

Thanks.
