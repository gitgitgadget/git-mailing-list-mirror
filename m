From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 7/7] i18n: mark checkout plural warning for
 translation
Date: Wed, 13 Apr 2011 08:55:39 -0700
Message-ID: <7vsjtmm9hg.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-8-git-send-email-avarab@gmail.com>
 <7vipukq6m0.fsf@alter.siamese.dyndns.org>
 <BANLkTimjYxz_7v8gyByjKX2Mf9vRzukWGw@mail.gmail.com>
 <7vzknvnq6o.fsf@alter.siamese.dyndns.org>
 <BANLkTimPzYA7oYkUZ3vwefb2HAKEHW-w7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 18:01:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA2Vt-0007pR-Rj
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 18:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758213Ab1DMQBL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2011 12:01:11 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152Ab1DMPzv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2011 11:55:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C8E13E42;
	Wed, 13 Apr 2011 11:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=gpku6DKtMzf/
	W4iEP+VZPPsrkgI=; b=Cp8E3qGwKks+mmgG6eZCVb1FglvWNGrtkT047rN388/V
	oakRoyhILcWeOMxMNHTyT3A71pAkMuqkDV0onToVuNukXVxcC2ZLsndhYtT5OkF3
	6v9I81HD0CbBBxGoYfZcqHaPDnyqRdOMUWcD0fAU2bOSy1kXWBiZDz7XWG8MhXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MDNuAn
	M4GGozwxuUb0ITzqqkAxJ6hQnCuFg+DSaShVkFmN74vRyb5pxAVVrvsOeggjYakY
	s1+LBy4Hd73GyZn5kBOyugUMBBufuuMLSpBmp5K/Ps/uQJyIV7rIfcSaN+paQbES
	7uQ6JaRs76P7nN1mEzBS5QZJPr+wCT+Iz1Uh8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 59A433E40;
	Wed, 13 Apr 2011 11:57:42 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6C16F3E3D; Wed, 13 Apr 2011
 11:57:39 -0400 (EDT)
In-Reply-To: <BANLkTimPzYA7oYkUZ3vwefb2HAKEHW-w7w@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 13 Apr
 2011 10:30:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3CB4160-65E6-11E0-BD42-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171464>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Anyway I could re-submit this or you could fix it up, either is fine =
by me.

Thanks.  I've queued a fixup together with the test_i18ncmp changes in
'pu'.
