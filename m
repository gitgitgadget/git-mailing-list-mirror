From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 7/7] i18n: mark checkout plural warning for
 translation
Date: Tue, 12 Apr 2011 00:19:35 -0700
Message-ID: <7vipukq6m0.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-8-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:19:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9XtC-0001t8-ED
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab1DLHTt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:19:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35181 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab1DLHTs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:19:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8543D2743;
	Tue, 12 Apr 2011 03:21:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PBX7pdfia9d8
	PJAz03CCOzCid2o=; b=XesAIZ+q2l5R4ZZOfSD/ttGAMTLQzQ8KdqgvUSy5Xc+n
	sjZEqkS1LVNhOUmmFY1TcfpkG70MsnQCxmzP2XI2ZhXelX7wKiqeap3GbJjS54jk
	BIPT3IReBFfrkjIWKb1hM8W2LF1gRTZurkZGJhJgR/W5YAHswvZweXBW3tU2Egk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=C2Drdi
	OVfRS1uIjNSSOKjqNJpP82nOfAm7XdcdU7/4q412cF+iQE8nq9zvvxeTKkRvgjMl
	0xN4V2DrenWrPJGfDsRcUSScKsfFzDzfEyKtCruJjss6e9zFdMNkSYd0wy+PELbE
	XhgaTJVzWFYOpTvUpZfgz7qxQh3pUXQjBHfus=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 61E072739;
	Tue, 12 Apr 2011 03:21:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 241402737; Tue, 12 Apr 2011
 03:21:33 -0400 (EDT)
In-Reply-To: <1302464048-21806-8-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 10 Apr
 2011 19:34:08 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8169A152-64D5-11E0-B86C-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171378>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Mark the "Warning: you are leaving %d commit(s) behind" message added
> in v1.7.5-rc0~74^2 (commit: give final warning when reattaching HEAD
> to leave commits behind) by Junio C Hamano for translation.
>
> This message requires the use of ngettext() features, and is the firs=
t
> message to use the Q_() wrapper around ngettext().

Thanks.

>  	fprintf(stderr,
> +		Q_(
> +		/* The singular version */
> +		"Warning: you are leaving %d commit behind, "
>  		"not connected to\n"
>  		"any of your branches:\n\n"
>  		"%s\n"
>  		"If you want to keep them by creating a new branch, "

s/them/it/ as this is a singular case, no?
