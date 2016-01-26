From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/19] Let Git's tests pass on Windows
Date: Tue, 26 Jan 2016 14:12:21 -0800
Message-ID: <xmqqbn88at2y.fsf@gitster.mtv.corp.google.com>
References: <cover.1453650173.git.johannes.schindelin@gmx.de>
	<cover.1453818789.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:12:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOBqi-0008Kt-5X
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 23:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbcAZWM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 17:12:26 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56991 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752586AbcAZWMY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 17:12:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D16E43FA7B;
	Tue, 26 Jan 2016 17:12:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cDy3BMJh/mNIJ/dZgRzsIKfjv8M=; b=nawbel
	PzDU8Egg9oTkzAms/FhxsPDZ98B8ZCNFzB7hZ+fnEU2UMj/f5XMf5eQ/puq2SugP
	VFB8+qz2b5rDQemX0cQOucTm7fmzTgdkmTCdIqjhKHGA0Rd+74n7OeL8jh1tIlL1
	nOzDOoLM5faOLwXQ03A0xVA9JHkiWS2N1X3jU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dLX9Z3JEme7tm/gTe6muvvtG+syAlOEg
	sQyY1ywezN3/yhdDv6AkYjTo/RWICwu1juJeFEX8o5ZRDdqmJeP6M2tUMwSs/D00
	sWTUgQHZEDDenY+lctwmuhOGM0h4oGEKqwkwZGpBLv4mwRKh9vVPj5hLNVx/afce
	SydJjFWzc6s=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C989D3FA7A;
	Tue, 26 Jan 2016 17:12:23 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 33E803FA77;
	Tue, 26 Jan 2016 17:12:23 -0500 (EST)
In-Reply-To: <cover.1453818789.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Tue, 26 Jan 2016 15:34:07 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DFF73FC8-C479-11E5-98D2-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284863>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> This is a big milestone. With these modifications, Git's source code
> does not only build without warnings in Git for Windows' SDK, but
> passes the entire regression test suite.

Thanks.

Without a few fixups, the result of applying these patches made
tests fail for me (so presumably for everybody !MINGW), which I
think I fixed all, but I may have broken things on MINGW while doing
so.  Please re-fetch from my tree when I pushed the integration
result out with this merged somewhere on the 'pu' branch, retest,
and if I broke something please re-fix them ;-)
