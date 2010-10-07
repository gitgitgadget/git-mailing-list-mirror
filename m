From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/6] Add string comparison functions that respect the
 ignore_case variable.
Date: Wed, 06 Oct 2010 21:13:23 -0700
Message-ID: <7vzkuqy718.fsf@alter.siamese.dyndns.org>
References: <20101003043221.1960.73178.stgit@SlamDunk>
 <20101003043228.1960.88989.stgit@SlamDunk>
 <AANLkTikU7D5dWAc-04cVUnjPPrC7rjaqjPe_j3rEvn0u@mail.gmail.com>
 <4CA847D5.4000903@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, j6t@kdbg.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Thu Oct 07 06:13:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3hra-0007aZ-Og
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 06:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0JGENl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Oct 2010 00:13:41 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496Ab0JGENk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Oct 2010 00:13:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4163FDC6D1;
	Thu,  7 Oct 2010 00:13:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=G/PNxrDNjLuWbYbfdygzlMJJQ
	Wo=; b=uBUw8pw1BFLxHvpwLFPej9txLw2G/+YqyiPIUSHvTm+29lOAisH7a1abP
	Jx2Ab8jnnTiFg61YtieW1XeWiB2q+fi0gaA53HvXEgCq3NZbmQi0mbOW8wcVQTWH
	BOiovJP0mUNNx/0r0mE4lu2JXvoL6E5wsc6iNEEwWGNUYrAx60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Z/6T0yCZy9E1noeuTO+
	3L9312Dy9sp0LmcuxfaeDFshcNaVkQq3rf0TdMOQUsjykJNELWmTtd1FEilyZAEk
	P1Jf4EhFOETcyurMDQPxGULaFBEvGYEc3jUxfAHza14c5+HlL04697LI69VlHpJD
	OriFUr4y+I91Oy+FjGEcNXNg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F38C2DC6CE;
	Thu,  7 Oct 2010 00:13:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23A79DC6CD; Thu,  7 Oct
 2010 00:13:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40C5328C-D1C9-11DF-9C71-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158365>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> In any case, I'd like to find a solution to get this series working
> for everyone.  I've been out of commission for a month (deploying Git
> to 80+ programmers at an organization, by the way), but I'm back now
> and can work this until it is complete.

Thanks; I'll queue =C3=86var's v3 (with [v4 2/8]) for now.
