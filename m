From: Junio C Hamano <gitster@pobox.com>
Subject: Re: C99
Date: Sat, 04 Apr 2015 13:06:43 -0700
Message-ID: <xmqqtwwvejzg.fsf@gitster.dls.corp.google.com>
References: <1428097515.31333.2.camel@ubuntu>
	<xmqqfv8gg9bp.fsf@gitster.dls.corp.google.com>
	<1428107083.31333.11.camel@ubuntu>
	<20150404190400.GB10125@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Apr 04 22:06:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YeULC-0002bD-TI
	for gcvg-git-2@plane.gmane.org; Sat, 04 Apr 2015 22:06:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbbDDUGq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2015 16:06:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51537 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752528AbbDDUGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2015 16:06:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F049545D42;
	Sat,  4 Apr 2015 16:06:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ly22de1YlxoNuj8Pq095PrUFss8=; b=TFlC9b
	GNdUui3MwXQ2WduPts4UPy/BYT8s9coldxt0HhpOx4ETSQVP7LcltbmKj1rZGRsy
	qqk4l9sNI3KcGC9eFHB6K+gwWXch3JfKfteBM/MfuS8Dg8kkzoTIihe+NHKUCH07
	3pwm2vRLcgH1gv0ItMpQ3nutYkHejlWZP8hS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iPR2cqjJwmhx3cjC2/vgDJUyeo/fMMel
	sj5I8FLWSfOUcJsiA+df3h6gGhvRtaLSC9TTj8ZFSWVBtSSn4Z/yH1dveh6YetjZ
	GVDBsGUOV6QLUvfW74G0B8lCDcYYpXn+zw50pTSh+SsOvwf67KuYlkT9SgP4Fqzf
	Pr2ZcIDOC/o=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E86FB45D41;
	Sat,  4 Apr 2015 16:06:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 58CC545D40;
	Sat,  4 Apr 2015 16:06:44 -0400 (EDT)
In-Reply-To: <20150404190400.GB10125@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 4 Apr 2015 19:04:00 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1DC63E16-DB06-11E4-833D-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266784>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> So it isn't as much of a "we don't want to move to C99" as much as "we
> aren't yet willing to drop support for older versions of MSVC".

I do not particularly like that 'we' in that sentence, which would
give a false impression to people that we all want to switch and
MSVC is the only thing that is holding us back.
