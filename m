From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Mon, 24 Oct 2011 13:09:19 +0200
Message-ID: <87wrbu4peo.fsf@gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
	<7vobx863v3.fsf@alter.siamese.dyndns.org>
	<CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
	<7vipng5k80.fsf@alter.siamese.dyndns.org>
	<CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
	<7vehy459bg.fsf@alter.siamese.dyndns.org>
	<20111023160744.GA22444@sigill.intra.peff.net>
	<7v39ej5uqb.fsf@alter.siamese.dyndns.org>
	<7vy5wb3sto.fsf@alter.siamese.dyndns.org>
	<CACsJy8AsfQnS3L1fabzB-z7BdH=jvB=XNnmP2RZu0qp7C1uGYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 13:15:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIIUs-0002oQ-U8
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 13:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755140Ab1JXLPI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Oct 2011 07:15:08 -0400
Received: from mail-dy0-f46.google.com ([209.85.220.46]:36339 "EHLO
	mail-dy0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab1JXLPH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2011 07:15:07 -0400
Received: by dyk29 with SMTP id 29so57180dyk.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 04:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=gWAT20jVY+SES86vQlFzKXlEUCtJKqVSd7b+C9/tShI=;
        b=RoghKipglaVjG6oZRTceLCq20PoPLH/f04cOBoJbHkFTsoYdryDUY1qqwM/CeXEeuL
         SBz0FGDefLxmFg5Bwj3QNdxF+PzITM6lSw+8Xgfx3JEpmCqhJz3knESCYyS22XaXSdWG
         B0Smoyq2fSh3JIYCirXnC9vFnAbgZWQrGf7Os=
Received: by 10.223.16.82 with SMTP id n18mr42761791faa.2.1319454904945;
        Mon, 24 Oct 2011 04:15:04 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz. [90.177.119.176])
        by mx.google.com with ESMTPS id n25sm31208050fah.15.2011.10.24.04.15.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 04:15:03 -0700 (PDT)
In-Reply-To: <CACsJy8AsfQnS3L1fabzB-z7BdH=jvB=XNnmP2RZu0qp7C1uGYQ@mail.gmail.com>
	(Nguyen Thai Ngoc Duy's message of "Mon, 24 Oct 2011 16:10:08 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184171>

On Mon, 24 Oct 2011 07:10:08 +0200
Nguyen Thai Ngoc Duy wrote:

> This is argument for the sake of argument because I don't use utf-16
> and do not care much. UTF-16 can have more code points and some may
> prefer utf-16 to utf-8.

I suspect this is really tangential to this thread, but I can't make
much sense of that last sentence -- if you meant that UTF-16 is somehow
more apt at encoding Unicode code points than UTF-8, then that's not th=
e
case. Both can represent all Unicode characters. If anything, things ar=
e
_more_, not less complicated in UTF-16, which apart from the NUL and
endianness complications has to jump through the "surrogate pairs" hoop
for code points bigger than U+FFFF (so you'll actually find many apps
with buggy UTF-16 implementation which break for those code points,
unlike when using UTF-8).

--=20
=C5=A0t=C4=9Bp=C3=A1n
