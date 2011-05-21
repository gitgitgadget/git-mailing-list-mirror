From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/48] i18n: mark core shell programs for translation
Date: Sat, 21 May 2011 11:56:38 -0700
Message-ID: <7v8vtzzxuh.fsf@alter.siamese.dyndns.org>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 21 20:56:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrM5-0004jF-Ue
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751804Ab1EUS4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:56:50 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51998 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab1EUS4s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2011 14:56:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 125F3421F;
	Sat, 21 May 2011 14:58:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CcvZfunPuX4a
	0EKwZSMH+k5jLFM=; b=BKAoA1BN90H3F/vBfEU4cwRwqctehSnpsJu7W8pqgDB/
	Cmnc8IMBYy6a9dF69hFSP/wnvAjA1DZO8Y10pDNs1qEo4C3/J4vz7UMgVVl8945D
	anS3hch0w3LH5xA/xgQPxD0PaA9W55wzrUCFLvpjGV7IUr4eY2hfwRbRVXkbEuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CvE6EQ
	Xj+iLM6OAg9xE5OYdG6ds4iDsNZl8WJUtH4Ha0pvAo5q2MbGvqIxeewSTTTB9jh6
	ngA6mRfMG/V0IOF5TCoQTbnWmi/PMYpVfmDJHLTC5XibRDT2Qq3OP6HGhoo0l4oT
	KKsaBQ6XF80CnhEjOrIC5dADbDusqvUbKfPt4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4B50421E;
	Sat, 21 May 2011 14:58:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D351A421C; Sat, 21 May 2011
 14:58:47 -0400 (EDT)
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 21 May
 2011 18:43:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E382A84-83DC-11E0-BD28-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174167>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series can be retrieved from:
>
>     git://github.com/avar/git.git ab/i18n-sh-only
>
> As explained above I didn't have time to fix all the blockers. Help
> would be *great* and very appreciated.

This URL still seems to point at the old series with echo >&2 "$(gettex=
t)".
