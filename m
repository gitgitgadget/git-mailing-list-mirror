From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Store EXC_FLAG_* values in unsigned integers
Date: Tue, 01 Mar 2016 10:26:12 -0800
Message-ID: <xmqqr3fu6omz.fsf@gitster.mtv.corp.google.com>
References: <1456851779-38548-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 19:26:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aap02-0004AS-So
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 19:26:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbcCAS0Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 13:26:16 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751361AbcCAS0P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2016 13:26:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 124C04932F;
	Tue,  1 Mar 2016 13:26:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=n+/KvWaO1gHR
	UOGTpRm+wcvf7vc=; b=HXqf0RAS0jkH7BDetHzZpPYgcd7bvauGi2t90WCqDTPi
	RLLZC2mCAxBzvOe6wlNrxpv0E+QuvsFt+s/wXm76zTUUexO7S7WXl5Bt1SAZCSQ+
	4cw9ndiaSs8lxi+O5jRE3z7t4qnGYmnoMSICtkfXZvsZE/dVLbCwd2BNNkwPB14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fH5u1a
	ik7gYwxAnS0bk0vcxcq+M0wpMPD0JmDUjBezTtGor2wD+ufDyqUMyOCRP3ZFAGku
	PVr1HQJnKoIHVY5Hrh7tXTu5OA1G7ElwWIGrKQp7FEh0Rbu2LcaAFINg/AS9Pe+J
	VRb/oQQ+YRXiBKUHrN8RbHmobUrTsmDI9GD0s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 07C684932E;
	Tue,  1 Mar 2016 13:26:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6C68B4932D;
	Tue,  1 Mar 2016 13:26:13 -0500 (EST)
In-Reply-To: <1456851779-38548-1-git-send-email-sauravsachidanand@gmail.com>
	(Saurav Sachidanand's message of "Tue, 1 Mar 2016 22:32:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 143636B4-DFDB-11E5-AF13-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288051>

Saurav Sachidanand <sauravsachidanand@gmail.com> writes:

> The values defined by the macro EXC_FLAG_* (1, 4, 8, 16) are
> stored in fields of the structs "pattern" and =E2=80=9Cexclude=E2=80=9D=
, some
> functions arguments and a local variable.

It's a minor point, but it is somewhat irritating that "pattern" is
enclosed in a regular dq pair while "exclude" is in a fancy dq pair.
I think our log messages tend to prefer the regular ones.

No need to resend; thanks.
