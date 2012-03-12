From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re*: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Sun, 11 Mar 2012 22:46:53 -0700
Message-ID: <7vlin6v0aa.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
 <CACBZZX4q0Da=H=-fO86f2YN+CmE25QfEgAp8Efmdyf65CGckiQ@mail.gmail.com>
 <7v4nu0m5tb.fsf@alter.siamese.dyndns.org>
 <CACBZZX6W=-ZchaCsLGdpZ420L_9=w8AHD8BNVb7XV5M-hc0Qhg@mail.gmail.com>
 <7vd38okmp0.fsf@alter.siamese.dyndns.org>
 <7vlin94dbc.fsf_-_@alter.siamese.dyndns.org> <4F5BD585.5050007@web.de>
 <4F5CC08C.90703@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 06:47:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6y60-0002tR-SK
	for gcvg-git-2@plane.gmane.org; Mon, 12 Mar 2012 06:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663Ab2CLFq5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Mar 2012 01:46:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab2CLFqz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Mar 2012 01:46:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D76B36E6;
	Mon, 12 Mar 2012 01:46:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nQmmkuHEtgaE
	Xr3p/UQJdA3KlSs=; b=F3AO7vhTJ3lkbNIUwN0OiH7xCYQG6/rWKZagB8xvKBBC
	rIsqn9qKFicPdbUz9He9H522Hb1T0hJtlQC5yc0ycXvaag5BiyfzDbC3bhCiXpJH
	MFhfQegOLT6Y1SorCBR7NR3+uF9348a/h9BDn38yu1Poj9JAJyX5mOlWHg/sEag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=dj/DWn
	ynytKbkzNnCyfz9b/Cl1vRPITArSTDxalIUNHxZuN8B3Rl7k8ED0hzt8gXPNBapc
	7n15lop5sZ6l6r6arxDZYh2ChryvraEbX5pLHrWcu9ozUjqhQVGbXBG2265ACMx7
	lA6fOrCL6WOCxeGrPtkX81wIN64B1hjYqD9Os=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 747AF36E5;
	Mon, 12 Mar 2012 01:46:55 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0493436E3; Mon, 12 Mar 2012
 01:46:54 -0400 (EDT)
In-Reply-To: <4F5CC08C.90703@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershausen?=
 =?utf-8?Q?=22's?= message of "Sun, 11 Mar 2012 16:11:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C64C0894-6C06-11E1-8E4C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192839>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> May I say
> "Thanks for looking into it,
> please go ahead with your suggested re-roll" ?

Although I am not sure if we got everything right for your
particular platform, I think the patch I sent out to categorize
three-known plausible error behaviours is a much saner approach
than the current code, so I am fine with committing it.

I am sort-of waiting for comments from =C3=86var, though.
