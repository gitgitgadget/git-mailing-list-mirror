From: Diogo de Campos <campos@esss.com.br>
Subject: Re: git rebase --interactive using short SHA-1's internally
Date: Sat, 10 Aug 2013 10:17:54 -0300
Message-ID: <CAMebvcTJ0kRzV2zWLaFzsXY+fBpdwaGiyuBJsx0=hYd350zOpg@mail.gmail.com>
References: <CAMebvcT7Tb1PXsKmRuSNCqOhJEbkPJAG2tzW6FjWCa6hH-+ffA@mail.gmail.com>
	<CAMPXz=rdaAZVb8UJJ+KcBZFR2wdnqTWbMKt07snPGEuCDz9q5A@mail.gmail.com>
	<7v7gfu2jy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: David <bouncingcats@gmail.com>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 15:18:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V893n-0006Oj-Lc
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 15:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933608Ab3HJNR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 09:17:57 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41447 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933459Ab3HJNR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 09:17:56 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so533705wiw.0
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=esss.com.br; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2hxSrCNxBQi5VIYiBTXhVOPq3vlFofvuAgOf4A62C5w=;
        b=VKNMx76vshTVNCggspxURe758UUrbsIErXi5S4N4T2Jt0uh5nDnSvdFZbzXtXDPqXN
         L+mNVAJx9hcXvONA2zBVaC82S5Lvp9cr946Ybvf/tMm8P3ghV3m1HeZgvL/pZWoOeXkm
         7AUNhnz8isZioHtLYpeeC97m3f31iz4i+o0/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2hxSrCNxBQi5VIYiBTXhVOPq3vlFofvuAgOf4A62C5w=;
        b=bctJtoDRKtnJ8/zL6s8DkcDmL1gSvHManx/VIvEmIapzE7VG26Qbr45Samtcds9Mom
         fjOTtkiB115pr03f2MDw7JVKjSn7eIsFcLuBbck7pAVPgM1BP1McaO0qVBWcKYRy2rNq
         6Fm178sdbYXfRTrlZAjGG5fm/q+ZbjWhFxVQTz4jdlupdNSHFXIkbxj8K5kA2v9qSdbq
         C+g8o91GH43GEG2R6hV7y8tDogkPjJ3kkt2T1swfKs6pUSfuxmDMoxnYWA5v8ITtD39M
         X1AK7oI7LHb5tQ917bDyIftK8cy1s0zT0Smkl4KnjrsoVb39YebaUEX+cE2kzaV8KUS0
         HZQA==
X-Gm-Message-State: ALoCoQkqwkpyMYch6aKtphhvX1HpPLXRA5R95chxJ5/RBmsg18pQZB1pKbHYCwbz0cLMx0H5P3r0
X-Received: by 10.180.210.243 with SMTP id mx19mr2498205wic.35.1376140674619;
 Sat, 10 Aug 2013 06:17:54 -0700 (PDT)
Received: by 10.216.159.68 with HTTP; Sat, 10 Aug 2013 06:17:54 -0700 (PDT)
In-Reply-To: <7v7gfu2jy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232097>

Ooops, that's exactly it =)

On Sat, Aug 10, 2013 at 2:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David <bouncingcats@gmail.com> writes:
>
>> On 10 August 2013 05:22, Diogo de Campos <campos@esss.com.br> wrote:
>>> Had some problems rebasing a large repository, fatal error because a
>>> short SHA-1 ref was ambiguous.
>>
>> This recent disussion might also interest you:
>> http://thread.gmane.org/gmane.comp.version-control.git/229091
>
> I was wondering why the topic looked familiar ;-)



-- 
Diogo Campos

Engineering Simulation and Scientific Software

BOS - Business Operation Support
Software Engineer
