From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 15:34:00 +0100
Message-ID: <6672d0161002130634j6d9b4994w5cd44405fe9b98a1@mail.gmail.com>
References: <4B768807.3030003@gmail.com>
	 <20100213112342.GA1299@coredump.intra.peff.net>
	 <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
	 <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com>
	 <20100213115512.GA5472@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 15:35:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgJ5z-00083Q-FY
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 15:35:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772Ab0BMOeF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 09:34:05 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:62428 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab0BMOeC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 09:34:02 -0500
Received: by ewy28 with SMTP id 28so2570476ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 06:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wM5Y2A0t0f+irY9fWFnYzMzqkP0YQcnxO+HVPc00GvU=;
        b=QgmzSp79SbeuPI+aZVYCJLzqBGkCO2dAnJGSn3CT+YRyZ4en/5LaqFIhX1HxdYmnbt
         pjHmiRPYWQ0a9nODFfJ01x9HsRpUXGgt4pvVYDKz+u6/sjaqTKKnsSKKEeBSrgE44J/o
         GaURtMc45lhexQ3P2RZvhYo4DeiTRboDIgQSM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qDWAVUnen4oFdxBMlyDvbgqsB8SZ8E/hv0q79WNz86D9quTyZMIdn2cY/w+4d0+d8C
         MhpgJxLIdWvGQcnIi5PuYLyV3+YwEpPMWbkuP1IY+PHS133TjkMnftfRzdRwuqFuk4cR
         26LrjSja/5/z3sAiptC68q4K31yuSJU2w+or8=
Received: by 10.216.88.205 with SMTP id a55mr1719661wef.122.1266071641015; 
	Sat, 13 Feb 2010 06:34:01 -0800 (PST)
In-Reply-To: <20100213115512.GA5472@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139803>

2010/2/13 Jeff King <peff@peff.net>:
> On Sat, Feb 13, 2010 at 12:42:56PM +0100, Bj=C3=B6rn Gustavsson wrote=
:
> If you are using color.interactive (or color.ui), that should already=
 be
> "bold blue". You can change it to red with color.interactive.prompt.

Oops! Turned out I only had colors for "diff", "status", and "branch",
so the prompt had had no color. I configured my color settings the
day I started using git last spring (according to some tutorial or
getting started document) and haven't looked at the color
settings since.

Now it looks much better.

Personally, I would prefer if more colors were turned on by
default, or if there were a master setting to turn on all colors
at once.

Thanks for the help!

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
