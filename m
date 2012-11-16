From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2012, #03; Tue, 13)
Date: Fri, 16 Nov 2012 10:52:36 -0800
Message-ID: <7vlie1mlcb.fsf@alter.siamese.dyndns.org>
References: <20121113175205.GA26960@sigill.intra.peff.net>
 <50A2B14C.9040608@web.de> <50A2F17D.4010907@gmail.com>
 <20121114190228.GA3860@sigill.intra.peff.net> <50A40978.2060504@web.de>
 <20121115001635.GA17370@sigill.intra.peff.net> <50A44A73.8020007@gmail.com>
 <20121115015608.GB19131@sigill.intra.peff.net> <50A48391.9090207@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Mark Levedahl <mlevedahl@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Nov 16 19:52:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZR26-0001cc-KO
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 19:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2KPSwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Nov 2012 13:52:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab2KPSwj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Nov 2012 13:52:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BD717AD63;
	Fri, 16 Nov 2012 13:52:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=F2fYNDYnQkhK
	cIsSaH0TpNPsSQY=; b=gDrvC2Kp69P7Vey0+KhIk4Rxv120lsxYDcPYQFzox3sC
	w4NQ5sxURs20OOj+Bg3TgNHuzJ7KHPwYstW5kEEdID6csvcGTiOsKwcuSbJFvBU7
	WWDYeWv/cC7L/y649j5GJPRNGfHJ5bhtqiksCiS9lU27nH5rwnBcaDz7tU8jD64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Si66s4
	1E/ic7K+IDkxkBKV5EG8O03FxtVvNq3Jhmpml/O9oxiUNzlNx4g7tSRib8rEfm6y
	6u+vP/+dj8x1LolBIV6YFpva7axyEMG+ZEwFVgbQ5wt5D8UzifqXAqOIyMT/6fwD
	vs5m1uEL1lyB5t3F+1Oui/311/xnSRkYl7FrQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA9B1AD60;
	Fri, 16 Nov 2012 13:52:38 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C10CAD5F; Fri, 16 Nov 2012
 13:52:38 -0500 (EST)
In-Reply-To: <50A48391.9090207@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Thu, 15 Nov 2012 06:54:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAA11CA4-301E-11E2-8AC2-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209893>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> My understanding:
> Either use people cygwin 1.5 or they use cygwin 1.7, and in this case
> the installation is updated frequently.
>
> Peff or Junio, please go ahead with the patch.
>
> If it turns out that we want to support cygwin installations like 1.7=
=2E7
> which could be upgraded, but are not upgraded since they are
> "production machines we do not dare to touch" we can still improve
> the autodetection.

OK.  I moved the topic forward but we may still want to rename the
name of the macro to have CYGWIN somewhere in the name.
