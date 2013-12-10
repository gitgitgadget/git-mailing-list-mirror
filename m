From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Tue, 10 Dec 2013 11:44:07 -0800
Message-ID: <xmqqr49ktrso.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-5-git-send-email-krzesimir@endocode.com>
	<CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
	<xmqq4n6gv8n0.fsf@gitster.dls.corp.google.com>
	<CANQwDwdoba5SbiiF1ZA2LHCwM-5KnEkVek5ekvrrQ-minLYNew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:44:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqTEG-0002ud-98
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707Ab3LJToU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Dec 2013 14:44:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57765 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab3LJToT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Dec 2013 14:44:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB1665A9EA;
	Tue, 10 Dec 2013 14:44:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Fp6kRXYHQz8a
	Yh6mwn971RYCX8U=; b=yO8oGAAMqXiRIIChhJ6/9ynQrPYA295GB3GpJhC4SvwB
	6XX8I8Sy8QGLvPxSGaFQ5apNMfwbvrqN0iw1u6tFK57yHvgc8YY+MlSPot088WBF
	NfNFUooKPE+Wv52t+SlBSzQ5rfeofmLB0B8vpaZ+hh7n4OG4Dd+tPyVL7/pALPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xNef3J
	1jySOJeBvYZfT2FHaZZQS5BgBb/QQ9ppDoRWJcHCpJjHJR9NMNQyTURhn2u3f2sE
	pmGHyph4K6Kq3GWPhdblCr5vPYLPIGR90A10w6ERoWtWTZsWJ/oVaTDIu4jbY+Mg
	E5UPZ6GEVUCUgRhenN73GgugNfqJGgdjdmFig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 16B8D5A9E7;
	Tue, 10 Dec 2013 14:44:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 980E35A9DF;
	Tue, 10 Dec 2013 14:44:10 -0500 (EST)
In-Reply-To: <CANQwDwdoba5SbiiF1ZA2LHCwM-5KnEkVek5ekvrrQ-minLYNew@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 10 Dec 2013
 20:06:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 70992D86-61D3-11E3-9F57-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239154>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> So 'snaphot' being forgiving doesn't mean that 'check-ref-format'
> should be forgiving.

OK, thanks for clarifying.
