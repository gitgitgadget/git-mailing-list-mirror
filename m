From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: support NNTP
Date: Wed, 24 Apr 2013 15:41:24 -0700
Message-ID: <7v38ufa6wb.fsf@alter.siamese.dyndns.org>
References: <1366715634-21790-1-git-send-email-l.stelmach@samsung.com>
	<87zjwofken.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
	<git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Apr 25 00:41:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV8NY-0002vy-S6
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 00:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758536Ab3DXWl2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Apr 2013 18:41:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757045Ab3DXWl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Apr 2013 18:41:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 107B6197B9;
	Wed, 24 Apr 2013 22:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hvpgRCPZRfca
	htuLREHbjDaIkPw=; b=ICtKEFwEFljGNJvHABpj8phai5q4YMWx+fxH6bhrRg2V
	WnES0BPJnzhPTSplZP7hyNdauAp6Q87XIUqkuqcw+ov206nO8rmHh7btsJWxySv5
	WOq86deqrQMoFbakvmC9kajLnyLRVRbRMpM+OEs/LLGk+oNZ0KesXxAlK78QA+E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AI551F
	Jn9Pf+lx1+J1YlPGx6tNqIGO2vJkhrCqAVNUNT7s21gbxBMgj1HZY9UwrSwYPIpr
	J9kSBncxTvetrnzEZ92yWgVW9nyQx57VI/IRhQO7EHJ8fjykPkVvR5TASlEDOa3u
	SVW0pwtjljikaxp5HTG+A+cScggJ11lVeRRDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0367D197B8;
	Wed, 24 Apr 2013 22:41:27 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FAB5197B4;
	Wed, 24 Apr 2013 22:41:26 +0000 (UTC)
In-Reply-To: <87zjwofken.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 24 Apr 2013 09:38:24 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19142DE8-AD30-11E2-8F2F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222334>

Thomas Rast <trast@inf.ethz.ch> writes:

> =C5=81ukasz Stelmach <l.stelmach@samsung.com> writes:
>
>> Enable sending patches to NNTP servers (Usenet, Gmane).
>
> I'm surprised Junio didn't mention this: your patch lacks the
> Signed-off-by.

Heh, that was because I took the patch as an early preview and not a
final submission.  It came without documentation updates, and also
it seemed to break t9001 for whatever reason.
