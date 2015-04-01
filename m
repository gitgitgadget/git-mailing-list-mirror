From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to push into empty repo, get fatal: bad revision 'HEAD'
Date: Wed, 01 Apr 2015 11:00:33 -0700
Message-ID: <xmqqd23nn2ym.fsf@gitster.dls.corp.google.com>
References: <CAHkN8V8cpZUmCi6=MUcsCOCBe6H_G6btr6WaV2vVrO1Nm_r4tg@mail.gmail.com>
	<xmqqego4ogxw.fsf@gitster.dls.corp.google.com>
	<xmqq8uecocjg.fsf@gitster.dls.corp.google.com>
	<cb4098391d46cc25b3d4d059e35dc806@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Samuel Williams <space.ship.traveller@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 01 20:00:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdMwY-0004gD-7R
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 20:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752984AbbDASAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2015 14:00:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59220 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752535AbbDASAl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2015 14:00:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EF7642B3C;
	Wed,  1 Apr 2015 14:00:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=luctKfSKq3QJNFHdW9+7DKGq/eQ=; b=oef/b/
	hlHBjLxX4AbkSexqxk8bC1XbohX/ezmBkxJjgjllbe4Ib3haXt0pxsjTji8ysmcW
	UFCktgTTpceZV3lYSB55cHujRpNMLNXelbS3DG9MVrsgzQMzfEP30oLwwx6rg3M+
	hfbnCgokRT/GOBv1TSpwtEbhyRLC1DT45XQ4U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5cmdjsRs8dINfn+y3OeGD44L9hK2MMG
	ujMd+M7HyQn9SFoFHE/eUv1c0dbPG1vUZQU/EF46pE/pA+PafXjyhq3tLpIWVPsn
	X70s5QP2jbcXkRkzDzUkK1knWDakEVbFZjGeYtp6oeAX0xEihRTZuNEdH1tpvqAg
	x4koAl3OH3w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3650742B3B;
	Wed,  1 Apr 2015 14:00:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8A84942B39;
	Wed,  1 Apr 2015 14:00:34 -0400 (EDT)
In-Reply-To: <cb4098391d46cc25b3d4d059e35dc806@www.dscho.org> (Johannes
	Schindelin's message of "Wed, 01 Apr 2015 10:51:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FE95BAA4-D898-11E4-8263-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266615>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Yeah, and we could refactor that into a global function, too. But for
> the moment, I think your proposed patch is good enough.

OK, so can I forge your Acked-by?

Thanks for double checking.
