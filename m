From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MSVC: fix build warnings
Date: Sun, 04 Oct 2009 23:31:21 -0700
Message-ID: <7vws3afj2e.fsf@alter.siamese.dyndns.org>
References: <d2e97e800910021440q46bd46c4y8a5af987620ffc5c@mail.gmail.com>
 <7v7hvd4flb.fsf@alter.siamese.dyndns.org>
 <d2e97e800910021628t13bba313he119ba59babdecee@mail.gmail.com>
 <7v7hvak1ec.fsf@alter.siamese.dyndns.org>
 <d2e97e800910042238t3ba02d59ud4e7f5b3b2b11183@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 05 08:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muh88-0006Tz-8L
	for gcvg-git-2@lo.gmane.org; Mon, 05 Oct 2009 08:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbZJEGcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 02:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbZJEGcM
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 02:32:12 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48464 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908AbZJEGcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 02:32:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F327C4C7CD;
	Mon,  5 Oct 2009 02:31:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NNlCZXmB9yjk0O0xQIWf7ce7D0Y=; b=G0TdAq
	NGVJWPVGx7YrhPAmvayO8ZngHpoxLcbAR7nNK3h6+iCgPcOgEfl8+IdhXXO9yFem
	5+AzAZxfQhZGbcLEUdaTLXaWV7IAQ++OHXmV/cvAXcuffStdBIXR7C8BlRtPXNHS
	0Ux8sbYOskj/hwB+DW0TMYZam2qieEUcxx/Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pmChUy76KJq4fj6KoVkLcoG0HQdctYAe
	gb1RY6/yi0KiU+OorFCIqEAZpRuRBCL4v7bLnhmvhYMhQ2QFX5ylkEFlXB93vsej
	F90eOEN2y66i2rRru1yIBG0rSnwQ99HcRUQWx3d7CiAQsKbxJRkYdljUpgbJNHbj
	CpATtXuLQkQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CCE8B4C7CC;
	Mon,  5 Oct 2009 02:31:26 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B3E34C7C9; Mon,  5 Oct
 2009 02:31:23 -0400 (EDT)
In-Reply-To: <d2e97e800910042238t3ba02d59ud4e7f5b3b2b11183@mail.gmail.com>
 (Michael Wookey's message of "Mon\, 5 Oct 2009 16\:38\:03 +1100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B58D9A90-B178-11DE-B109-92E639D9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129533>

Michael Wookey <michaelwookey@gmail.com> writes:

> I still get the warning with the current git.git:master (dbc1b1f7)

Hmph, I somehow thought Shawn already applied the patch I sent
$gmane/129285, but it seems he hasn't.
