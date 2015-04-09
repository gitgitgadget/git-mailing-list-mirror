From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] fix global bash variable leak on __gitcompappend
Date: Thu, 9 Apr 2015 15:26:50 -0400
Message-ID: <CAPig+cTE+UbNaY3rewqCFjZW7nAYOTP167W3Bhp4AEZoVBt0tA@mail.gmail.com>
References: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
	<1428471958-12339-2-git-send-email-marcio3w@gmail.com>
	<xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
	<CAOsHV+tCHrbmapXU+eei7v1jfiwdpK8jT+ue=kb_dm9nDXtq_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Marcio Almada <marcio.web2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 21:26:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgI6L-0003SY-S3
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 21:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbbDIT0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 15:26:53 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36491 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbbDIT0w convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 15:26:52 -0400
Received: by lbbqq2 with SMTP id qq2so90154775lbb.3
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 12:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=hpDHD6XLE+1rNV+q7HzPmLKPz9oFBssNQBmMAM2eiAU=;
        b=I4l+6igysXleoOtFo9wR5+JVPitXRtZZL28W5sz7EMY+jFg5uCEWm2xnGstUAXuhR/
         HRrfx7fw5/XOGkBcg5u0oQKDeyT+ChttbgjNOlDr9iWOToMnvTCjdrI7OKJGuSm/HEHT
         J8b5pgVKgnztEnehhGtDZmmcWbi6+YB8j6VclhaC61R0Kc2YrQDuH7T3SpndrLdDyL6/
         B9irwUhdiTDOQHSXz3/SAwcZMYSVeS7nLhFuu6Ld/QPKY3ZZobWBYSip2K4d17dyX2ID
         BxrEaQ5GGAbIfaDiG1cOQ/Kt6FdmG4I+7ZnsoDuMz17uZ4dBmafO+HJRa4xSYiWpBE5g
         f/zg==
X-Received: by 10.112.173.41 with SMTP id bh9mr29105802lbc.107.1428607610691;
 Thu, 09 Apr 2015 12:26:50 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Thu, 9 Apr 2015 12:26:50 -0700 (PDT)
In-Reply-To: <CAOsHV+tCHrbmapXU+eei7v1jfiwdpK8jT+ue=kb_dm9nDXtq_Q@mail.gmail.com>
X-Google-Sender-Auth: WHmyM_Px-WDlc-FBlhF4XKd--qU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266999>

On Thu, Apr 9, 2015 at 9:52 AM, Marcio Almada <marcio.web2@gmail.com> w=
rote:
> 2015-04-09 0:56 GMT-03:00 Junio C Hamano <gitster@pobox.com>:
>> "M=C3=A1rcio Almada" <marcio.web2@gmail.com> writes:
>>>  contrib/completion/git-completion.bash | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Nicely found and corrected.  Please sign-off your patch and Cc area
>> experts if you can find them (I'll do that this time for you).
>
> Ok, I'll remember this next time. Thanks for your incredible work her=
e.

Junio's implication was that you should reply to his message with:

    Signed-off-by: Your Name <your@email>

Or re-send the patch with your sign-off added.
