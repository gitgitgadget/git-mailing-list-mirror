From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Branch Name Case Sensitivity
Date: Mon, 03 Mar 2014 09:51:52 -0800
Message-ID: <xmqqsiqzrwzr.fsf@gitster.dls.corp.google.com>
References: <CAJHY66EQD280QgXBCoZU4y_aqSEu3A1hXzeW7X-rtT6vMZ92oA@mail.gmail.com>
	<xmqqvbw0xrl6.fsf@gitster.dls.corp.google.com>
	<530FA0C1.3000109@web.de> <530FBB1D.3050505@gmail.com>
	<CAJHY66FtC03YbJrbVn+adsePkYnVD2RGH1TGkzz2pKNBoee_iQ@mail.gmail.com>
	<53102FB0.6040603@viscovery.net> <5310959D.709@gmail.com>
	<xmqqk3cfuksd.fsf@gitster.dls.corp.google.com>
	<CACsJy8A6etyFkxn3D7hjM9JgzmokPBARXrEncVuw1x+OOHJ_Lg@mail.gmail.com>
	<xmqq7g8eu891.fsf@gitster.dls.corp.google.com>
	<CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Lee Hopkins <leerhop@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:52:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKX26-0008NG-IT
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 18:52:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753078AbaCCRv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 12:51:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34096 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752855AbaCCRv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 12:51:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE58970138;
	Mon,  3 Mar 2014 12:51:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DPQVhlH1dxDa+tMZ4mZ1axeAL4A=; b=B67sbM
	rll1AIZq+hn2J3/uWJG2/0ZsvZYHc2uUxQNJHOqkf3vVRFXLe6xRaUpHx189WGB+
	00DZhjAp3nVzFg+cd+bQoCCP4CFm+kZlYVpnU2Lvwc5BJYLOa9PWfoShn1pZ2Gve
	ZjkkCKlOgbm4QwGAukmb3Zsn92l/AUsAvUUbY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Gj9FGMR/LJZieNXvkZFDyPj4IkpXNO31
	F61UqqKuJp2KqWqPiUKGCTwWvXAinZcP6tunktwXqVo9OfUF749oSQSxt17BG1ao
	RB9N8u624kRNu2eYMcf0iGKbfAKPDwVIiM5jmNLplguO+QU/4ZaEGNlcVuRQ6jjA
	tQdFBGpzG1A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99AD570137;
	Mon,  3 Mar 2014 12:51:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CDBE870133;
	Mon,  3 Mar 2014 12:51:56 -0500 (EST)
In-Reply-To: <CAJHY66EP539ZsLJcmHcnRQcOqcLqXK-M45wME9DkKkqmumg8fA@mail.gmail.com>
	(Lee Hopkins's message of "Fri, 28 Feb 2014 21:42:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 834A3460-A2FC-11E3-83F1-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243239>

Lee Hopkins <leerhop@gmail.com> writes:

> I went ahead and took a stab at a solution. My solution is more
> aggressive than a warning, I actually prevent the creation of
> ambiguous refs. My changes are also in refs.c, which may not be
> appropriate, but it seemed like the natural place.
>
> I have never contributed to Git (in fact this is my first dive into
> the source) and my C is a bit rusty, so bear with me, this is just a
> suggestion:
>
> ---
>  refs.c |   31 ++++++++++++++++++++++++-------
>  1 files changed, 24 insertions(+), 7 deletions(-)

Starting something like this from forbidding is likely to turn out
to be a very bad idea that can break existing repositories.

A new configuration

	refs.caseInsensitive = {warn|error|allow}

that defaults to "warn" and the user can choose to set to "error" to
forbid, would be more palatable, I would say.

If the variable is not in 'core.' namespace, you should implement
this check at the Porcelain level, allowing lower-level tools like
update-ref as an escape hatch that let users bypass the restriction
to be used to correct breakages; it would mean an unconditional "if
!stricmp(), it is an error" in refs.c will not work well.

I think it might be OK to have

	core.allowCaseInsentitiveRefs = {yes|no|warn}

which defaults to 'warn' (and 'yes' corresponds to 'allow', 'no'
corresponds to 'error', in the previous suggestion), instead. If we
wanted to prevent even lower-level tools like update-ref from
bypassing the check, that is.
