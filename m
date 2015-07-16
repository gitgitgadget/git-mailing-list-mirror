From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] gitk: Add a "Copy commit summary" command
Date: Wed, 15 Jul 2015 17:59:46 -0700
Message-ID: <CA+P7+xrKc_t6_ntc0jFoHJgYrira74+swqy5kFuuFn_gC9Ft2Q@mail.gmail.com>
References: <1436892150-24267-1-git-send-email-dev+git@drbeat.li>
 <CAGZ79kaB-vrarcCztD_7x5M1_dHWwMy=6vQ5EHHsWTJTWEyhOA@mail.gmail.com>
 <1436999097.12921.2.camel@intel.com> <CAPig+cTf3WDHf++Ck-SXgY4LRm7WRLLk2BvewUQZktfdpHL4BA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Keller, Jacob E" <jacob.e.keller@intel.com>,
	"sbeller@google.com" <sbeller@google.com>,
	"dev+git@drbeat.li" <dev+git@drbeat.li>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"paulus@samba.org" <paulus@samba.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 03:00:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZFXX5-0004ZF-Ov
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jul 2015 03:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149AbbGPBAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2015 21:00:08 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38724 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751857AbbGPBAG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2015 21:00:06 -0400
Received: by iggf3 with SMTP id f3so2480448igg.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2015 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1JOUixME6L8SXskkA1Bdh2uLVhIgwIuj94eMbO+yyCU=;
        b=H832xR0x0VnHKbrZoYFtdCTyKtASwySqcJDzdJDktEr9T11rNs9hljexiJA1AXU4Uh
         e8onRnrKrZtkKyzJKriffzN7uQ540b0KyktG5xYXWPZUiRaGvdHjGI7XlBw5L2d+wU5j
         /RrLXC89tYIikRqTht7xjIZNtwev6eBvUwL6OE0OmJM3UstvR6iibyU66A41Ni8hdP/P
         jJNTpj0JRAMRcMN6WM1HWYHHzaAbnSBH+3zs5Epa4R+Zc8Txr8U++/Ickls8glMiM8Zp
         SmZm7cEDpu20D9IQv6eOjII/N46kOQasDd5cayYSSfPJ29yuIaT++3cJJQw6Ghk6pPko
         7r1w==
X-Received: by 10.50.28.43 with SMTP id y11mr49768igg.8.1437008406101; Wed, 15
 Jul 2015 18:00:06 -0700 (PDT)
Received: by 10.107.157.75 with HTTP; Wed, 15 Jul 2015 17:59:46 -0700 (PDT)
In-Reply-To: <CAPig+cTf3WDHf++Ck-SXgY4LRm7WRLLk2BvewUQZktfdpHL4BA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274003>

Agreed. I haven't seen "commit" used much in the past, and you can
easily type that out as it is.

On Wed, Jul 15, 2015 at 4:58 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jul 15, 2015 at 6:24 PM, Keller, Jacob E
> <jacob.e.keller@intel.com> wrote:
>> On Tue, 2015-07-14 at 13:34 -0700, Stefan Beller wrote:
>>> On Tue, Jul 14, 2015 at 9:42 AM,  <dev+git@drbeat.li> wrote:
>>> > From: Beat Bolli <dev+git@drbeat.li>
>>> >
>>> > When referencing earlier commits in new commit messages or other
>>> > text,
>>> > one of the established formats is
>>> >
>>> >     commit <abbrev-sha> ("<summary>", <author-date>)
>>>
>>> That sounds like I would use it a lot! Thanks :)
>>>
>>
>> Yep, quite useful. Also, the kernel suggests using it as a tag like so
>>
>> Fixes: <abbrev-sha> ("summary")
>
> Dropping the literal word "commit" would make this use-case more
> convenient, as well as the typical use-case when composing commit
> messages: "Since <abrrev-sha1> ("blah", <date>), foobar.c has
> flabble-nabbered the wonka-doodle..."
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
