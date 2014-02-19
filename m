From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/25] Support multiple checkouts
Date: Wed, 19 Feb 2014 12:57:52 -0800
Message-ID: <xmqqtxbu7rcf.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 21:58:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGEDV-00013n-2b
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 21:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754862AbaBSU55 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Feb 2014 15:57:57 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45419 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753573AbaBSU54 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Feb 2014 15:57:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAF626C647;
	Wed, 19 Feb 2014 15:57:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=WVUhzJiiD18O
	3oKRX34NFxmKR/U=; b=UgTJ80NZ84uZE9FU0MpqxxWf8c5oG3w1Okzgc5awpIxy
	b5ByZHw8P2RHQ6hc1Pzzo3TUeawgomXPzvoI+nqJbiU482pNEiz0nO50W+drPrdd
	ec6KPCcfF8b3JVX27rnMIBXsK++s5w90412PJQMT4EbvrFPe0KLaUqsFuG9ohNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jc31dS
	/TrbFOLgLxsa6yZgMPkK+SKvY3XFDF0VOuqiCKORHdkepPPEEXFokD0RQV6kEsfj
	QoZaThMPJtCIiuCqGLyhDPT49qwIA7eXsf/1jdZebzpJyfAu4CikmjNd+LdaCwit
	35ZTVZn3/Brwo3SkGF9p+HknjHN13+GT8wCSc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C73756C646;
	Wed, 19 Feb 2014 15:57:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 236FE6C641;
	Wed, 19 Feb 2014 15:57:55 -0500 (EST)
In-Reply-To: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:39:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8125A23A-99A8-11E3-A0A2-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242411>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> In short you can attach multiple worktrees to the same git repository
> with "git checkout --to <somewhere>". This is basically what
> git-new-workdir is for.

This is exciting.

I'll be pushing this out on 'pu' (with trivial fix-ups squashed in
and/or queued on-top) for people to play with.

I'm still slowly chewing thru these patches, though. Haven't had a
chance to read them carefully yet.

Thanks.
