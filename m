From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 0/4] Auto-generate mergetool lists
Date: Sun, 27 Jan 2013 18:41:04 -0800
Message-ID: <CAJDDKr75K3RGgU79nrznbpjQMLQGkDs=W8XEofURNsS1X1bvjg@mail.gmail.com>
References: <1359334346-5879-1-git-send-email-davvid@gmail.com>
	<7v38xm12kk.fsf@alter.siamese.dyndns.org>
	<CAJDDKr7sQKDNPpaFJi+en479TF=aLXL2pvXODeo6CC3xD1KMGw@mail.gmail.com>
	<7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 03:41:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tzef4-0005Pa-6U
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jan 2013 03:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab3A1ClI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 21:41:08 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:44234 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049Ab3A1ClH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 21:41:07 -0500
Received: by mail-we0-f173.google.com with SMTP id r5so1166512wey.4
        for <git@vger.kernel.org>; Sun, 27 Jan 2013 18:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=zSqDdCFS5wsIjl+jBMxM5SCEh16yg+bP7DFX3/K2Yu0=;
        b=XbRmCwI8m9WyVPaU1Aw+rdTEuSGkZjDWoDHOLjvKR+26XEzI0vxVW71VaAJNUISUQK
         xHTJNX+zZDDp+i+OTSFnyj6d3IYbYA++Qz9ZtAFiszR3SnDLdAbRvgySes/9wAQ9bPbB
         ObbPrng9BuEg02rWaS8MqGl2PoGUrdcROoZOQT4wMhbgdNTdZwje28r3B2uvZfTZ59aI
         0mahhEBRkGfTlsLwHH7Jq/YQjwr47po3MTtasGkfnxL64aHvvRakCVC9b/i+eWcmoBRa
         EU4cfkt0fRKrrLg0bFjt8QMC95UeuEGXlUBw3k8a5E0eWCNRW1tZbZvWdaSC0YMbmXp6
         cklg==
X-Received: by 10.194.76.7 with SMTP id g7mr18591804wjw.50.1359340864682; Sun,
 27 Jan 2013 18:41:04 -0800 (PST)
Received: by 10.194.24.231 with HTTP; Sun, 27 Jan 2013 18:41:04 -0800 (PST)
In-Reply-To: <7vr4l6yrd3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214791>

On Sun, Jan 27, 2013 at 6:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> On Sun, Jan 27, 2013 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> I think our works crossed, while I was tweaking the previous series
>>> to push out as part of 'pu' you were already rerolling.  Could you
>>> compare this series with what I pushed out and see if anything you
>>> missed?  I think I fixed the (a && b || c && d) issue in the version
>>> I pushed out, but it is still there in this series.
>>
>> Ah, I see.
>>
>> I can add the addition of preamble for use by show_tool_help()
>> as a follow up along with using a here-doc when printing.
>
> I think the progression of the series is just fine as-is with the
> new series you posted (I didn't amend the old one with all the
> suggestions I made in the review, just only with the more important
> ones that would affect correctness, so please consider that the
> changes you have in this new round that I didn't have in 'pu' are
> good ones to keep.

Okay, cool, so no need to reroll, ya?

The one thing missing in my latest series was the fixed mode_ok()
which you corrected in cfb611b34089a0b5794f4ec453289a4764d94050.

Let me know if there's anything else I should send out or splice together.


John, I didn't completely address your question about keeping
the sort and prefix in show_tool_help() but I can stop poking at
it now in case you want to start looking at what it would take
to get custom tools listed in the --tool-help output.
-- 
David
