From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is the default refspec for fetch?
Date: Tue, 11 Nov 2014 15:04:45 -0800
Message-ID: <xmqqegt95ofm.fsf@gitster.dls.corp.google.com>
References: <CAENte7inZ5fm2SzNPq=HNPKnPco9tM4T_es5Dphnpbia-uiLdg@mail.gmail.com>
	<20141108105221.GA20750@peff.net> <545E2A2D.2040205@gmail.com>
	<xmqq7fz4e18x.fsf@gitster.dls.corp.google.com>
	<CAENte7ggGPgNktH_ArVsjN2yDLADHQApDCzWbQLo_bbCiduk6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jeff King <peff@peff.net>, Git <git@vger.kernel.org>
To: Christian Halstrick <christian.halstrick@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 00:04:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoKUX-0000nn-Hn
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 00:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366AbaKKXEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 18:04:50 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752252AbaKKXEt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 18:04:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AF5881DD40;
	Tue, 11 Nov 2014 18:04:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f/bcRSqsMS7IEK4w511oeR/OxSw=; b=yLScx9
	GNfFJUWavJEeeme30RcE+5f11nnORBceUUUnwlICDYc7p5v7CJGDf6hMihN59Pbu
	AZ77emQDd9mvSuFNnmxqzapGRRFZxKWQgjsJNykDfxMn8LJdwz1avhi4N5K3SIIp
	FT+QaXjpbuthnI3yUz71FjgWHIlhW7rhBGC3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ATSJXnbRaibGQVfBT65FutBQksNqg2DW
	BPuKB/miLJR53mX5m1J1kVukgZYqul144uUuvQRihlCaS4ddGLzzWM7UZ5GZZ05u
	wR6NP54hBWtDS2vgj1FiZh11VljR24GcSgZWaBbPl6mUSNf522r/fH9d39vBJHJ0
	GWgCcrwsSDc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A63941DD3F;
	Tue, 11 Nov 2014 18:04:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F2521DD3E;
	Tue, 11 Nov 2014 18:04:46 -0500 (EST)
In-Reply-To: <CAENte7ggGPgNktH_ArVsjN2yDLADHQApDCzWbQLo_bbCiduk6w@mail.gmail.com>
	(Christian Halstrick's message of "Wed, 12 Nov 2014 00:01:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 21AC4794-69F7-11E4-8331-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Halstrick <christian.halstrick@gmail.com> writes:

> ok, thanks. Then I'll teach JGit to fetch at least "HEAD" if nothing
> is configured and nothing explicitly specified as refspec.

Sounds like a sensible thing to do to match what JGit does to what
we did from the time immemorial ;-)

Thanks.
