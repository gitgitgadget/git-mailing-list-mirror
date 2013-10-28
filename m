From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] t/README: tests can use perl even with NO_PERL
Date: Mon, 28 Oct 2013 21:43:11 +0000
Message-ID: <CAP30j14cRXkmp24AcFHya89pA3N6cpfbHhdrpaKbPHj4MPJP7w@mail.gmail.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
	<1382951633-6456-1-git-send-email-bdwalton@gmail.com>
	<526EA7C8.2020607@kdbg.org>
	<20131028182718.GA4242@google.com>
	<xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
	<20131028192216.GB4242@google.com>
	<20131028195429.GA8299@sigill.intra.peff.net>
	<20131028210420.GC4242@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:43:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vauai-0001dp-5C
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810Ab3J1VnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:43:13 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:58190 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab3J1VnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:43:12 -0400
Received: by mail-qc0-f178.google.com with SMTP id x19so4138425qcw.23
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WXnlH4doul4r52zauxwRS8xn32z0jVITKi5HAuJNatY=;
        b=ZVayv1r5RuK0FhplSgGmZ4bULvI8pxzMaPGRDTdhNh2RSSrgCTMJ5KSqTE9sdgjt9h
         szTV+tBZrA1AylPuLo13BMLV7P5UagYAT7W7TXRrJG8keV5V1s7+64p83RRRyj2NAyxR
         4iV/76WDwcBw3Ib/Qh43WyqziYvBkGnAqvuk9J7j+KdTUR7h6iHc1eZA1ZLRwskLb9De
         26qj2JA8ibnUcTuJqV/PY/67GAdq/xTNZUv5mSRRkZoc9gednyvHH2d0ojbEmihbNVOf
         DN/r2lD7/rXlf0xVrFpgNN0K69Q223pnNZOsiiKRCtXkTAaq050oyZ5x/ARhb/DYf4zN
         LGiA==
X-Received: by 10.49.24.43 with SMTP id r11mr31744425qef.70.1382996591820;
 Mon, 28 Oct 2013 14:43:11 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 14:43:11 -0700 (PDT)
In-Reply-To: <20131028210420.GC4242@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236866>

On Mon, Oct 28, 2013 at 9:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>
>> Speaking of which, is there any reason to use the ugly "$PERL_PATH"
>> everywhere, and not simply do:
>>
>>   perl () {
>>     "$PERL_PATH" "$@"
>>   }
>>
>> in test-lib.sh?
>
> Sounds like a nice potential improvement to me. :)

+1.

-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
