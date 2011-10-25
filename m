From: =?utf-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Tue, 25 Oct 2011 12:16:00 +0200
Message-ID: <87sjmh4brz.fsf@gmail.com>
References: <1319277881-4128-1-git-send-email-pclouds@gmail.com>
	<7vobx863v3.fsf@alter.siamese.dyndns.org>
	<CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
	<7vipng5k80.fsf@alter.siamese.dyndns.org>
	<CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
	<7vehy459bg.fsf@alter.siamese.dyndns.org>
	<20111023160744.GA22444@sigill.intra.peff.net>
	<7v39ej5uqb.fsf@alter.siamese.dyndns.org>
	<7vy5wb3sto.fsf@alter.siamese.dyndns.org>
	<20111024224558.GB10481@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 12:21:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIe8m-0004Ev-OR
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 12:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282Ab1JYKVs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 06:21:48 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45011 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753298Ab1JYKVr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 06:21:47 -0400
Received: by faan17 with SMTP id n17so343905faa.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-type:content-transfer-encoding;
        bh=mgUDu5Bvtdo0wJjH4Xq4l6bQmVN5yuTAcCFO01CTocQ=;
        b=C+Q399bUr4qLvFa6PqoSNUqHnIwIjbE3MV4gSwijG+yABo4bZTAJ2NT8cykdCo7TUn
         dDYzU8BSMe7QckFikCjVSmja8acFuyQLSSDY1JtJGhie8h2fgPCdN81lAVgNW6/mBTgE
         01Ls5KcAcXswIYnPcR/g38PxNXh4fti3k1Yf4=
Received: by 10.223.76.201 with SMTP id d9mr50140266fak.12.1319538106443;
        Tue, 25 Oct 2011 03:21:46 -0700 (PDT)
Received: from localhost (176.119.broadband10.iol.cz. [90.177.119.176])
        by mx.google.com with ESMTPS id n25sm37551308fah.15.2011.10.25.03.21.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Oct 2011 03:21:44 -0700 (PDT)
In-Reply-To: <20111024224558.GB10481@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 24 Oct 2011 15:45:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184200>

On Tue, 25 Oct 2011 00:45:58 +0200
Jeff King wrote:

> [1] English is my first language, so it's rare for me to even step
> outside of ASCII, let alone latin1. But aren't there some languages i=
n
> which utf-16 is more efficient than utf-8?

You sometimes hear something along the lines of the second
"disadvantage" listed in the article below, i.e. "Characters U+0800
through U+FFFF use three bytes in UTF-8, but only two in UTF-16.":

https://en.wikipedia.org/wiki/UTF-8#Disadvantages_4

--=20
=C5=A0t=C4=9Bp=C3=A1n
