From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: simplify archive format guessing
Date: Sun, 07 Feb 2010 16:45:17 -0800
Message-ID: <7vfx5c368y.fsf@alter.siamese.dyndns.org>
References: <20100207070811.GA26338@progeny.tock>
 <4B6E8FD9.7060905@lsrfire.ath.cx> <4B6F4D0C.2010107@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Feb 08 01:46:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeHlS-0004tV-4X
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 01:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab0BHApb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Feb 2010 19:45:31 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:51704 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754949Ab0BHAp3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Feb 2010 19:45:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0AB5F9742D;
	Sun,  7 Feb 2010 19:45:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=hryfk6KDokW1Nq+wV+Qp3g0A8
	kM=; b=AuLKSeJwJDG8aaGXuAYLSIjvD4k6Q7H9XdrdD8MR7O0oxwyecwCVG2NNR
	F6a95A0xmQrqutTh5Qs3GFVHF9KFkr1tLWcU5M6W5AHcSp43yShv9cWQHao2KlFl
	y6r1H1mWnvSPik3g5AnZBUO2jNIx2hPhAolfVWX+zmDtnIfLMY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=Zug4T/0bANX8vadRG0w
	mh/mVXurpYSQ/gjrpmHqtVMyiS7naTYjuyZibAOWvgX056IioJQ2EMJilhyYoLCX
	uBOzm8PqSk8KqDMpp28F9Zh/AOXW3Wfadsz8hCTe/+Y6zSO8Gb3Rbu8G70Tkx9x5
	/rc2x7FVTa63EWvGqkO4tLk0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BA2309742C;
	Sun,  7 Feb 2010 19:45:23 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8EC39742A; Sun,  7 Feb
 2010 19:45:18 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3DDB90CA-144B-11DF-9B4B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139268>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Here's my patch again, with a reformatted comment, a renamed variable=
 and
> two simple tests.

Thanks; will apply to maint and merge upwards.
