From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/2] submodule: drop the top-level requirement
Date: Fri, 19 Apr 2013 14:03:14 -0700
Message-ID: <7vehe6z10t.fsf@alter.siamese.dyndns.org>
References: <cover.1365539059.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<cover.1366314439.git.john@keeping.me.uk>
	<6e4122f3eedec3f520028b5598b78e0d59e5d12b.1366314439.git.john@keeping.me.uk>
	<7vfvyn4g46.fsf@alter.siamese.dyndns.org>
	<20130419074632.GC2278@serenity.lan>
	<7vmwsu31vh.fsf@alter.siamese.dyndns.org> <517199AB.50109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 19 23:03:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTISp-0006Ov-61
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 23:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262Ab3DSVDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 17:03:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754203Ab3DSVDR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 17:03:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56E00177EE;
	Fri, 19 Apr 2013 21:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TtRAsclU9iMJRzhd3TcODejRFvw=; b=VflN1x
	7qWW1C5B7S+R3vXAdU0xJq15Nm1nsNLzPweg4SZDvidYfRb8aQcNrSdWgodZ8nyS
	Ztx2gvdURUUuCYp2o3CgSmA4sPbf6pRFnIfgJprOR/YOQsFaEonRaMNNErcrDUmg
	R1fjMIsJSL/PpdwZmYnPKdC54OSRZwWZC0+lw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mIUyK0D46in83rLDc9O+EuF55jxn/xkS
	57gZY2b1EM11RZtW6bhkQAFeZavm0WI0uHWC1vKeTaGAFU0SPifCA0Lr2jUnuTIO
	CdsMkipB+YGUYzGs7agmSaeO96KaHjpgrBWjc9KbFIajwVXk7N6NjNCaHwqFiFdf
	DZG//E4kDyI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BD44177EC;
	Fri, 19 Apr 2013 21:03:16 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C70DF177E7;
	Fri, 19 Apr 2013 21:03:15 +0000 (UTC)
In-Reply-To: <517199AB.50109@kdbg.org> (Johannes Sixt's message of "Fri, 19
	Apr 2013 21:23:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DE10C5E-A934-11E2-9F64-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221819>

Johannes Sixt <j6t@kdbg.org> writes:

> Why not just replace the six-liner by this one-liner:
>
> 		target=${target#"$curdir"/}

Simple enough ;-)
