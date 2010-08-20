From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] tests: fix syntax error in "Use advise() for hints" test
Date: Fri, 20 Aug 2010 14:22:02 +0000
Message-ID: <AANLkTi=WoMFYU6rDggyB+-s6F_LasUnc-N+gk9v+=C_r@mail.gmail.com>
References: <20100811083100.GA16495@burratino>
	<1282142204-14720-1-git-send-email-avarab@gmail.com>
	<20100819043036.GD25649@burratino>
	<AANLkTikDq4eJfm2RnbGDuJMHCR8_4cn6NfJpoYWHbWWN@mail.gmail.com>
	<87aaohwq0r.fsf@hariville.hurrynot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Raja R Harinath <harinath@hurrynot.org>
X-From: git-owner@vger.kernel.org Fri Aug 20 16:22:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmSTy-00038z-P9
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 16:22:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752692Ab0HTOWF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Aug 2010 10:22:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53376 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab0HTOWE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 10:22:04 -0400
Received: by fxm13 with SMTP id 13so1800337fxm.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ps808tqensiPhs0qTH8B9sWFvUUzNP2g8pcRgDTuDzQ=;
        b=CLmMDb3bXQToaJXRmzv8KhzFlQbxJuLzvXQpgFXjBijca1hdxFjaKyn7RYiICU4ObE
         yUmQUk+LGzR1uPMTMbBbbuDDSuEiGcKNKPfp9oRLWhR7NDW4an5HuBqfdO/ZuUP7AxbV
         JH3crKP3KbfBGC8m+yQLLH+884Jf/2WNJxkX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=D3Z3btYG8/zREByv7A1J5fYqONnuILCB3Ou264EGNPHkC+aG63tR4opskzBzch2ung
         ocw/IVhdaqDao3JNnaxDeCCO256v/8lljXiAVC0XA+HwbSWjjG1tY5WGHvfuHYMrGpLI
         X2HdcQt64TU7qRrr24kRPIpYIy08fwaSgQRJQ=
Received: by 10.223.98.66 with SMTP id p2mr1261687fan.18.1282314122678; Fri,
 20 Aug 2010 07:22:02 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Fri, 20 Aug 2010 07:22:02 -0700 (PDT)
In-Reply-To: <87aaohwq0r.fsf@hariville.hurrynot.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154043>

On Fri, Aug 20, 2010 at 10:13, Raja R Harinath <harinath@hurrynot.org> =
wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> On Thu, Aug 19, 2010 at 04:30, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> [snip]
>>> Although the style you chose is arguably the least ugly, nested she=
ll
>>> interpolation can be hard to follow. =C2=A0How about this?
>>
>> I think '\'' is harder to follow than \" and \$, but each to his own
>> :)
>
> There's also the slightly longer but somewhat prettier '"'"'.

I must say, you guys have an odd sense of aesthetics :)
