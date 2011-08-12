From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 0/6] Towards a generalized sequencer
Date: Fri, 12 Aug 2011 07:44:12 +0530
Message-ID: <CALkWK0nXAU+jFwyzmYC6XuPGy8Cdmbpis0Nvb-M+tQSNk_PXiQ@mail.gmail.com>
References: <1313088705-32222-1-git-send-email-artagnon@gmail.com> <20110811190312.GD2277@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 12 04:14:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrhGg-0007MD-I7
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 04:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab1HLCOd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Aug 2011 22:14:33 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:38489 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752610Ab1HLCOd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Aug 2011 22:14:33 -0400
Received: by wwf5 with SMTP id 5so2602690wwf.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 19:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ehNfNW2IlRDQI9Sj/w8zX95F6L8KqM5YAOviIQ2JW6I=;
        b=LLwpox+oC/gwDhJcZ6Dp7S8ZkSRxGdYjzYOem9UtMQrxBWIvv3llu16Jbp9xci6n/z
         wihJZKipAGL0UPHK8TQT2awFUE87sOAtilSASrdCvriwGRTIkTTGldYIXLoVUk7gJHJJ
         UbcGF2Xa/v7h8D77iEvspaQvrJGU7z5jFoNek=
Received: by 10.216.4.208 with SMTP id 58mr2307475wej.93.1313115272147; Thu,
 11 Aug 2011 19:14:32 -0700 (PDT)
Received: by 10.216.139.31 with HTTP; Thu, 11 Aug 2011 19:14:12 -0700 (PDT)
In-Reply-To: <20110811190312.GD2277@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179159>

Hi Jonathan,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Note: I didn't know what to do with the license header in the fifth
>> patch. =C2=A0I just assumed that it was some historical cruft and re=
moved
>> it.
>
> Please don't. =C2=A0Technically it's allowed by the license if I unde=
rstand
> correctly (since the copyright notices are not accompanied by a
> disclaimer of warranty) but it's almost always the wrong thing to do
> to remove a copyright notice without the author's permission.

Um, ok.  I still don't know what to do:
1. Should I leave it in builtin/revert.c?  There are only a few tiny
functions left there.
2. Should I move it to sequencer.c and and modify it accordingly?
It'll read Copyright (C) 2011 <Me>, based on builtin/revert.c which is
Copyright Dscho, which in turn is based on git-revert.sh Copyright
Linus and Junio?  Isn't this information redundant? Can't `log` and
`blame -M -C` do a much better job?

Thanks.

-- Ram
