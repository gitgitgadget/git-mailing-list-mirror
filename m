From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG?] Spaces not allowed in directory names in .git/info/attributes
Date: Tue, 24 May 2016 15:54:38 -0700
Message-ID: <xmqqtwhn2hjl.fsf@gitster.mtv.corp.google.com>
References: <CAO8RVveOwrS6+pTnHY36d1Nk_B_VJD022W9i8STnNb-KyMkqNg@mail.gmail.com>
	<xmqqmvng8qle.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DXW-K-iNO65yuzMLPZS_8+R1gsQgNftwei1XUZNxhicg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Nathan Collins <nathan.collins@gmail.com>,
	git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 00:54:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5LDr-0005Yt-0H
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbcEXWym (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 18:54:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752427AbcEXWym (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2016 18:54:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A00541EFB3;
	Tue, 24 May 2016 18:54:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=slo8PiJNZAGVY94MKB90/GxZKMY=; b=aaYZr6
	FZ7Vth7D3qR9MhTH6S30uOa1saktpzJh/Qt/QTMOr6FykjnD47BsS4iLUEz3gCTZ
	49s/Au1jCepOvSikoVN2VSNKYWEa9eDmFXmw5KgbOzsM2osXPcr+hbAdcfnr3xs7
	PNq1JVLqnueHNU6pM4FR1BsLzST1+S81jLaoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KWHSCLNrPboChmCuznYv5TXotf8ADl/Y
	rZ9mm/cplhOsFJwzqaVWWrU2ehZMT4RXLl7UPrnKq2Xvf/a4Zr7JKqj+cHUaQVMx
	naqeUzFjVJFKhAItNE26v7Y4UDIyHn5AfOgrmVrnnTHd14nywFZb3RI4myVycA9h
	wSjzvuIQky8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 97EB21EFB2;
	Tue, 24 May 2016 18:54:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10B801EFB1;
	Tue, 24 May 2016 18:54:40 -0400 (EDT)
In-Reply-To: <CACsJy8DXW-K-iNO65yuzMLPZS_8+R1gsQgNftwei1XUZNxhicg@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 24 May 2016 08:37:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7FCD1A1E-2202-11E6-898D-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295542>

Duy Nguyen <pclouds@gmail.com> writes:

> Maybe bring back [1] (cquoting paths) and optionally optionally with
> backslash escaping? The conclusion at the end of that thread seems to
> be "ok, we may break rare setups, we just need to be upfront about
> it".

Yup, even though I do not think this is something urgent.

> [1] http://thread.gmane.org/gmane.comp.version-control.git/160597/focus=160720
