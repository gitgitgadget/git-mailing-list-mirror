From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH] t0008: avoid brace expansion
Date: Thu, 10 Jan 2013 00:22:58 +0000
Message-ID: <CAOkDyE_gSn488N9q1_PD40s+B9sRY32qMXddoC3fNUFD1jtbhQ@mail.gmail.com>
References: <50EC8025.8000707@lsrfire.ath.cx>
	<7vr4lvcstt.fsf@alter.siamese.dyndns.org>
	<50EC8BE7.2010508@lsrfire.ath.cx>
	<7vboczcq5a.fsf@alter.siamese.dyndns.org>
	<50EE01F8.1070109@lsrfire.ath.cx>
	<CAOkDyE_EuuV04KxkkLuHMV+VbDWsDMN1q3YShLtKaimaXH40Sg@mail.gmail.com>
	<7vsj693n6o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 10 01:23:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tt5vV-0005AT-OS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jan 2013 01:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370Ab3AJAXA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jan 2013 19:23:00 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:41658 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932330Ab3AJAW7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Jan 2013 19:22:59 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn17so906478wib.12
        for <git@vger.kernel.org>; Wed, 09 Jan 2013 16:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=NTkm5o9/+G5+jCouWVoulfhhdlIDYamT1eDbYnqS+4Y=;
        b=lIh3xKNWIHsQkmDys9aSbdjxRY7RdbD2AJYCZ68emlRMu4jnsW//VfcDlbPmZkVCVE
         Os3tDWcw/ItYu54J714j8+y92kSIrNsPoCcguGMEDduUbO3HJ2l5M/s/iYYQNV9byr91
         nWVtGiQRnFCN3df5E0Fb9yCUMHGfJywtcimZO4mfgKMcI48KOF+FMzD6YDnsCuUBLzLy
         vRIWAu0o+KJXGy6tPtDus49n+MIjLo6LfOHcgg4SqMun6v3UIjtXibsmADl9fUP6Rtbl
         JtFHm+Ei3yDmiQm9kGbBnYoIZRKcH9G4gsS9/VmBN2KxNHFT9x4fkqnzFurXbSCyPAEH
         go8w==
Received: by 10.194.236.68 with SMTP id us4mr111979111wjc.11.1357777378462;
 Wed, 09 Jan 2013 16:22:58 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Wed, 9 Jan 2013 16:22:58 -0800 (PST)
In-Reply-To: <7vsj693n6o.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: nyPUlnW397SIxAlRjJeKswP62Co
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213116>

On Thu, Jan 10, 2013 at 12:18 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> On Wed, Jan 9, 2013 at 11:49 PM, Ren=E9 Scharfe
>> <rene.scharfe@lsrfire.ath.cx> wrote:
>>> Brace expansion is not required by POSIX and not supported by dash =
nor
>>> NetBSD's sh.  Explicitly list all combinations instead.
>>
>> Good catch, thanks!
>
> Yeah; thanks.
>
> It would also be nice to avoid touch while we are at it, by the way.

Noted.
