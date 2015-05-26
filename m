From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/1] send-email: Add sendmail email aliases format
Date: Tue, 26 May 2015 14:47:28 -0400
Message-ID: <CAPig+cT3-=05xpeBUMEo3cT8-i=EQKv=XD7cKPDPuLbsfQX2=g@mail.gmail.com>
References: <49e9a95b52aa61ed4f37edf1dfa178186acb4a29.1432367540.git.allenbh@gmail.com>
	<xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Allen Hubbe <allenbh@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 26 20:47:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxJsz-0008G4-LN
	for gcvg-git-2@plane.gmane.org; Tue, 26 May 2015 20:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbbEZSr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 14:47:29 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36715 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbbEZSr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 14:47:28 -0400
Received: by igbpi8 with SMTP id pi8so65919784igb.1
        for <git@vger.kernel.org>; Tue, 26 May 2015 11:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Sgt5v69AXreK6MNXN/WzMD5G2rG//bKqpoR0+dknp8Y=;
        b=mhzcaE3ujB2leC/PHAVTHDviEIYnbkUmTfzKaAXOX7ySC160xyUxFy4ZeGSaYiDkNh
         dz12IpI11DUXdGn9cWtoqSwOcp9/l9NZ6GOUW2KzvthTxkU1t6OvsHrzoeogXZjB7PpV
         4lkn/VZfDHEb7GYbkyITu6CSmQthipq4XBUV+TGMShHXSyn9HW3jzOLW3HlZ48YoxtxI
         etxwCF4bFnC895VzNwr7vQXmJlFukpcanQrfKUKcuYKygPuD3zJ0PCnHH3rLs6MJF36H
         vWgfHy6m1jSZphmtHXqbpDKYV+34fgtJ4awgbfVU9ejsBHaobYwKdiKMHatWw49QzFfy
         ouRw==
X-Received: by 10.50.66.234 with SMTP id i10mr23950924igt.22.1432666048141;
 Tue, 26 May 2015 11:47:28 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 26 May 2015 11:47:28 -0700 (PDT)
In-Reply-To: <xmqqfv6nchmf.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: 9nuyOzJE_q4f9ZQGNLSAVZWzk38
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269964>

On Sat, May 23, 2015 at 1:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>> Note that this only adds support for a limited subset of the sendmail
>> format.  The format is is as follows.
>>
>>       <alias>: <address|alias>[, <address|alias>...]
>>
>> Aliases are specified one per line, and must start on the first column of the
>> line.  Blank lines are ignored.  If the first non whitespace character
>> on a line is a '#' symbol, then the whole line is considered a comment,
>> and is ignored.
>> [...]
>> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
>> ---
>
> Thanks.
>
> A small thing I noticed in the test (and this patch is not adding a
> new "breakage"---there are a few existing instances) is the use of
> "~/"; it should be spelled "$HOME/" instead for portability (not in
> POSIX, even though bash, dash and ksh all seem to understand it).
>
> I think this round looks good from a cursory read.
>
> Eric, what do you think?

Sorry for the delay. This round looks much better. I do have a few
very minor comments, which I'll post in reply to the patch itself, but
nothing worth holding the series up. Thanks.
