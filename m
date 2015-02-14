From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] transport-helper: ask the helper to set the same options for import as for fetch
Date: Sat, 14 Feb 2015 00:12:23 -0800
Message-ID: <xmqqoaowlxnc.fsf@gitster.dls.corp.google.com>
References: <xmqqlhk2ri1j.fsf@gitster.dls.corp.google.com>
	<1423805086-807-1-git-send-email-mh@glandium.org>
	<1423805086-807-2-git-send-email-mh@glandium.org>
	<xmqqwq3lmwnb.fsf@gitster.dls.corp.google.com>
	<20150213221450.GA24285@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Feb 14 09:12:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YMXq7-0006gG-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 14 Feb 2015 09:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753243AbbBNIM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2015 03:12:26 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752633AbbBNIMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2015 03:12:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B05D62E707;
	Sat, 14 Feb 2015 03:12:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9KLmIjQHLyd0Q53V3DcQKp2rh8k=; b=o+J4FB
	2aFKhY0yOOPWMsNPvwlt2acSMcDlayEMSegV3K4N75CyFWYWPU8q5IcRd8KBe0vn
	w3VDfYipEBE1lULkwbCorevSsL6XF3ngSK/2JrustHGvV9aGN4IevHXJA9SNQopg
	VhUoozstDiig72yPdp0H8ptYARo8RUJj71Zf4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bpjMvLDmMp12ZmiOIWeesCngh1aeVuUC
	AcYmz12AXymezMR5QsbjI08eOIz7PiiBpziW//FGd1Kvmuo+eHjRCxghfrCnnPI9
	PkUUQN8efUKSf0wjyp/KAjrsVlgcQYFDihytDQenwTa7wn0I/PrSG7BNmPkFNx3U
	niJfEwYf+o8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A0A652E706;
	Sat, 14 Feb 2015 03:12:24 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29C072E704;
	Sat, 14 Feb 2015 03:12:24 -0500 (EST)
In-Reply-To: <20150213221450.GA24285@glandium.org> (Mike Hommey's message of
	"Sat, 14 Feb 2015 07:14:50 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34DD62CA-B421-11E4-BA50-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263849>

Mike Hommey <mh@glandium.org> writes:

> I haven't looked exactly what cas does and if it makes sense for export.
> (FWIW, I'm using push and import at the moment, so it's not a direct
> issue for me ; I don't support cas anyways)

The question primarily came from curiosity to gauge how much
potential work remains in the area (of course, people are welcome to
share the curiosity and get motivated to fill the gaps as
discovered).

In other words, I didn't mean to say "complete other methods in
transport helper while at it; otherwise your patches are incomplete
and unacceptable".  It is better to concentrate what you use whose
desired behaviour you are sure about, and these two patches do
exactly that.

Thanks.
