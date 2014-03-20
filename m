From: Justin Lebar <jlebar@google.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Thu, 20 Mar 2014 16:13:45 -0700
Message-ID: <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
 <1395353785-23611-4-git-send-email-jlebar@google.com> <CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: "Jason St. John" <jstjohn@purdue.edu>
X-From: git-owner@vger.kernel.org Fri Mar 21 00:14:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQmA9-0006Er-DG
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 00:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760063AbaCTXOI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 19:14:08 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:63118 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759810AbaCTXOH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 19:14:07 -0400
X-Greylist: delayed 3434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Mar 2014 19:14:07 EDT
Received: by mail-qg0-f50.google.com with SMTP id q108so4740804qgd.9
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 16:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QD1bkkbnSl/d64xmlm0PowrlW9q7EbZ6kcKgf7kckBs=;
        b=VC8vAUwJSX/kyk45dsy8oAq9/Rue27w803GpHu5EYYl/uZTDEPL2R41fxTG+CCUa6E
         DwbEfSQ3N+JrWgx8R8R7saH0QULo+obuBSpVYIVbuqTKJHGZomWzT+UYb0Pn4l/+eJBu
         tDY3txs0idMbsjLLmvgbWMY+rjbAvzxV3v7zD1n2ZqdgDS9gXWaX4cyn0GBeA+V0aXr2
         HY5g4g/SAs3m/rPsvHXnwUzlcYia0ov5VQhmsaqe2mrqI6XQ8C6NUZsx6q24hfW9n3FR
         0O0g9zI0V2G3d7eYIf8kN+L3cJE/xKQ2l6CpeMPFuMRjw210jDB/+Njf3EkB407iPMN2
         eqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=QD1bkkbnSl/d64xmlm0PowrlW9q7EbZ6kcKgf7kckBs=;
        b=mUcCB3O6Wl4F8YbkmFGLgWhJ0y3Lz/r47npm1tlw+QUTHessvL92uUuPVXbEsn9VcV
         AQCfkHBuF6m+NoIb47Cw20EdMEjl5zpL3smypF8xp+Xcdcr0YtGrswjcVhqICQyn0ZFX
         E0jb3kDX84B5Y0FbMsYdBHHT7SK4pfc/wwl/xR9Vae2u4FwIIh5GajXfs6BR/bLoKA8+
         qmbkv3eMO9S9yjlNeJcAfayVE3oeRc1xxnZns4yL1P5SHqODay4x9v0DVWw4LxFdMUfD
         6AFgTEXVM2K2WbebjYrYz37fgdLIeBmuzCvFPlUZfxpswbisKlJXNc/qrIZdSI/Os3UD
         2P2Q==
X-Gm-Message-State: ALoCoQn9gqzBpytWY0RkyooLyfBKmbbbmb4hH24tNy0b2OvbJ8J3HcaYOnu1cRIPFtovMJejH3b+MidVdrrQahHt7QPCgwSf2LOeAMtvDaPV9RqfHfrnlZUz98452jkPV6WgYrdd+6PbdLA5bu1GSUJf0Lst3iM8oZ48Io5hKxdQIJCr8XMowKCA81V+e4+AtMFqj1lINXER
X-Received: by 10.224.21.207 with SMTP id k15mr54195949qab.66.1395357245604;
 Thu, 20 Mar 2014 16:14:05 -0700 (PDT)
Received: by 10.96.69.36 with HTTP; Thu, 20 Mar 2014 16:13:45 -0700 (PDT)
In-Reply-To: <CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244604>

Thanks for the quick reply.

When I send a new patch, should I fold these changes into the original
commit, or should I send them as a separate commit?

>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index b0d0986..6013e19 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -4061,7 +4061,7 @@ static int write_out_one_reject(struct patch *patch)
>>                 return error(_("cannot open %s: %s"), namebuf, strerror(errno));
>>
>>         /* Normal git tools never deal with .rej, so do not pretend
>> -        * this is a git patch by saying --git nor give extended
>> +        * this is a git patch by saying --git or giving extended
>>          * headers.  While at it, maybe please "kompare" that wants
>>          * the trailing TAB and some garbage at the end of line ;-).
>>          */
>
> I don't think the change from "give" to "giving" here is grammatically correct.

Is it?  I might be misunderstanding the sentence, then.  I parse the
new sentence as

  Do not pretend this is a git patch by
  - saying --git, or
  - giving extended headers.

"Giving" is definitely awkward, but I'm not sure of a better word.

I'm happy to rephrase this, but I'm not sure how.  I don't think the
original makes much sense, but I'm also happy to leave it.

> How about ``If none of "always", "never", or "auto" is specified, then setting layout
> implies "always".``?

Sure.

> To leave "nor" here, I think you need to replace "not" with "neither".

I think it actually works after the change, but unfortunately Garner's
doesn't give me a lot of ammunition to back up that feeling.  :)

How about "We don't expect this to be set by the Makefile or by the
user (via CFLAGS)."

> This would be better worded as "If src_buffer and *src_buffer are not NULL, it should ..."

Done.

-Justin
