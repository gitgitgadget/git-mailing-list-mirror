From: Jeffrey Walton <noloader@gmail.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Mon, 14 Sep 2015 19:14:23 -0400
Message-ID: <CAH8yC8kaWi6F5iKhNQeJrG451hqS-3_crtA0c+xFner78E2CAQ@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
	<20150913101727.GB26562@sigill.intra.peff.net>
	<CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
	<20150914043016.GA10167@sigill.intra.peff.net>
	<CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
	<20150914045953.GA11039@sigill.intra.peff.net>
Reply-To: noloader@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 15 01:14:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbcxB-00046D-9c
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 01:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751633AbbINXOZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 19:14:25 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:36224 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbbINXOY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 19:14:24 -0400
Received: by ioii196 with SMTP id i196so183915571ioi.3
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=DwkEBSAneqjNsYSdaesB2hTEt9S9c3ZDTqmg6VaeWFE=;
        b=y7XG+CLvuVLTILlGGPL6pnZktqOBEANBF63QerMTwXDr6JTejm65vm/TZqdUCe9LTB
         Okf8YBePM9oo40p0e9+B1EOKwcdYP8yldMdCohNtRwIHywFdOPIqTwzChL0EkQrADUa3
         liMNYjjT2LrKXwTEG3+5ACSLW/r1auk0UfJAlBN3WjO9TRKBsWmLqN/JUiDu7BMgv037
         BtnbF3ogLzOsSxGTEGAfX/lUEFpmyCoz2VMDlXLJvlzFKlThCRL4JL2qbKgW8s+CZO8c
         bJvqxrP/Q+HIIXHsRN0kmzdMMvmsQvXjnNO/yEXh3mt7XYpsZ8jcNkZ5yGZ/a6oI9pry
         S9CA==
X-Received: by 10.107.14.196 with SMTP id 187mr31223377ioo.11.1442272463505;
 Mon, 14 Sep 2015 16:14:23 -0700 (PDT)
Received: by 10.36.123.131 with HTTP; Mon, 14 Sep 2015 16:14:23 -0700 (PDT)
In-Reply-To: <20150914045953.GA11039@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277876>

On Mon, Sep 14, 2015 at 12:59 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 13, 2015 at 09:57:08PM -0700, Junio C Hamano wrote:
>
>> On Sun, Sep 13, 2015 at 9:30 PM, Jeff King <peff@peff.net> wrote:
>> >
>> > Ah, OK. Today I learned something. :)
>> >
>> > Jeffrey, can you produce a tested patch which works for you?
>>
>> If I am not mistaken, I think I already have one on 'pu' (I think I did that
>> as an afternoon-tea time hack or something).
>
> Oh, indeed. ac179b4d9. Looks good to me.
>
> My follow-up question was going to be: is this something we should be
> setting in config.mak.uname for appropriate versions of Darwin? It
> wasn't clear to me from Eric's description if this is something that
> particular versions need, or just something that people who want to
> build Universal binaries would choose to use.
>
If you have something that needs testing, then please let me know. I'd
be happy to test it for you.

My OS X test environment includes OS X 10.5 PoweMac (PowerPC), 10.8
Intel x64 (ancient C++ stdlib that claims to be C++11), and 10.9 Intel
x64.

If desired, I can give you SSH access to a couple of the machines.
OpenSSL and Cryptlib uses them on occasion for testing, too.

Jeff
