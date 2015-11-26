From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Wed, 25 Nov 2015 22:20:36 -0800
Message-ID: <CA+P7+xpp4mF5iuZ+i_8vuB4BoHBvpmS=jq-xAeae7bdT9UGHhA@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
 <20151124224709.GA13691@sigill.intra.peff.net> <20151124234206.GA31949@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 07:20:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1pvN-0006A5-EN
	for gcvg-git-2@plane.gmane.org; Thu, 26 Nov 2015 07:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbbKZGU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2015 01:20:57 -0500
Received: from mail-io0-f173.google.com ([209.85.223.173]:35647 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbbKZGUz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2015 01:20:55 -0500
Received: by ioc74 with SMTP id 74so75481402ioc.2
        for <git@vger.kernel.org>; Wed, 25 Nov 2015 22:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H6oIFGMzFaqhAzl+aTTNAmpx0kw6pf7We82VBuytcDc=;
        b=LnV8oxdnw7zDQcW+xDejQJchqM3NWBNi/chB/8Pxui68I6W/AbzktaZg+rzg4AeiYk
         iK0lUN2Q7y3FsYyBUnLG+kLV0rqf1lNZgs9LpUP8YPfLoLz7wagfyUMY7JfyIkiFMZN3
         8HCqu9neg962yyBq0frELXmJnnSUBPvtOc+BtUnUPReP6BKMgJxymusILTVjHRkURzb/
         M0hpCct4sqj3rghmatZxIodRsO31AAvKFSN5oqm2dazS+hSkUAnh5ECah201VGN6EA9M
         ZeUb+idXiDLBGEn1/EkVYl4zRjvoCrwWGs29eslzG45pZtBlEI7/C5aLfjIrcKcoBdUA
         uTKg==
X-Received: by 10.107.136.39 with SMTP id k39mr47476719iod.0.1448518855334;
 Wed, 25 Nov 2015 22:20:55 -0800 (PST)
Received: by 10.107.19.227 with HTTP; Wed, 25 Nov 2015 22:20:36 -0800 (PST)
In-Reply-To: <20151124234206.GA31949@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281761>

On Tue, Nov 24, 2015 at 3:42 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 24, 2015 at 05:47:09PM -0500, Jeff King wrote:
>
>> On Fri, Nov 13, 2015 at 08:34:22AM -0800, Jacob Keller wrote:
>>
>> > ---
>> > I do not remember what version this was since it has been an age ago
>> > that I sent the previous code. This is mostly just a rebase onto current
>> > next. I believe I have covered everything previous reviewers noted.
>>
>> Please keep topics branched from master where possible. And if not
>> possible, please indicate which topic in 'next' is required to build on.
>>
>> We never merge 'next' itself, only individual topics from it. So I can't
>> just apply your patch on top of 'next'.
>>
>> I did get it to apply on the current master with "am -3", but some tests
>> in t3310 seem to fail. Can you take a look?
>
> I just noticed v2, which I missed earlier. But the same complaints
> apply. :)
>
> -Peff

Yea.. sorry about that. I normally work off next since this is what I
use day to day for general git use, as I like to run the bleedy edge.

I can respin these on master, but it may take a bit of time as I am on
vacation at the moment.

I'm also curious if people would rather go the more difficult route
first or not.

Regards,
Jake
