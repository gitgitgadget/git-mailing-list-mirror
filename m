From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V2 1/2] t9801: check git-p4's branch detection and client view together
Date: Sun, 19 Apr 2015 22:43:49 -0700
Message-ID: <xmqqtwwbmk16.fsf@gitster.dls.corp.google.com>
References: <1429441009-17775-1-git-send-email-vitor.hda@gmail.com>
	<1429441009-17775-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Luke Diamand <luke@diamand.org>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:43:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yk4Uu-0005iG-Rg
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 07:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbbDTFnw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 01:43:52 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750779AbbDTFnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 01:43:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3B9BF3F16B;
	Mon, 20 Apr 2015 01:43:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Lho56D7ELHWfY7K9tY1uchn705U=; b=RmuqQL
	JO34WE1Gpyog45iuerMft4rDmwrO6ee1PomSZuAc0e07cTE38sm3Db/P/bS+lQHs
	CyteaxAnX9qChXVviM+R89+PsT9nxIN5T6NQBK8dWwQG3+kMMTvp03EJJVLlcV9J
	kad1gu3qdG3X7WlxZiGeLDUIzvCcWxOQrxjwc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ikZQJbkfFJoM5vhG8Q5Bh8eGysn1Q92n
	JA4JNbSwnm/BIS+sSKyff0yH/t8zW7Iy1BHkN6ZrmVqHYrytxEXPi0g9CzKocTaB
	ZaR5svV+P/NiPxCbl3/xpsdo+xjfp6zeHH3Tg6Jxyl/quauSrfHmyBFgWAo1U7d9
	UDTIbfbiBqo=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 32C323F169;
	Mon, 20 Apr 2015 01:43:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9ED623F168;
	Mon, 20 Apr 2015 01:43:50 -0400 (EDT)
In-Reply-To: <1429441009-17775-2-git-send-email-vitor.hda@gmail.com> (Vitor
	Antunes's message of "Sun, 19 Apr 2015 11:56:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38D881B6-E720-11E4-9087-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267452>

Vitor Antunes <vitor.hda@gmail.com> writes:

> Add failing scenario where branch detection is enabled together with
> use client view. In this specific scenario git-p4 will break when the
> perforce client view removes part of the depot path.

I somehow cannot parse "together with use client view", especially
the word "use".  Is it "user client view" or something (I am not
familiar with p4 lingo), or perhaps "use of client view"?
