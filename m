From: Dave Borowitz <dborowitz@google.com>
Subject: Re: Working towards a common review format for git
Date: Fri, 8 Jan 2016 14:26:26 -0500
Message-ID: <CAD0k6qQLM=Fh_FGU6JN8=52Kjab6AqMfFTaK7DiNYgpWa5nJpg@mail.gmail.com>
References: <20160108140831.GA10200@salo> <CAD0k6qRFPMZxLh4MtwkXwrk4GCjf64vWEd=9NPn-t_-uVHWz9g@mail.gmail.com>
 <CAD0k6qQBcfq0++d=-uyGpakmd+bsxuWYUWcn8auYJPy_HLddTg@mail.gmail.com> <20160108192339.GA3514@salo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Edwin Kempin <ekempin@google.com>
To: Richard Ipsum <richard.ipsum@codethink.co.uk>
X-From: git-owner@vger.kernel.org Fri Jan 08 20:26:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHcgV-0003o6-JR
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 20:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbcAHT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 14:26:47 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:34548 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932228AbcAHT0r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 14:26:47 -0500
Received: by mail-io0-f182.google.com with SMTP id 1so249183398ion.1
        for <git@vger.kernel.org>; Fri, 08 Jan 2016 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q34ScPT2v0UZvPgiMdelk8OvXShdIAeEpZ7s6ZCnBBg=;
        b=bT8kvygaQtpsq1AFqk6gK+SjmKkspL7cC7eHirP72u8bGI58rnc9bwekJVWRqywfbM
         fH4sJuzOPEnWYkMqTMo+m/5AJ0LzRfQ5d1Bk2V/bUqrYqhrer2F1BM29B74dsMKURy6U
         PE6C5WLcf28wGBpepE1x7V7tEbHzxcnvBE1WU3ZprvtK1XWcHH9t8I4a+Uy+uS4OoTXQ
         PiRL+NMX4HbSmj4Drq3lWVRYjwnUTAfpcqeRnfKVf2ar1PoH/Dz50v4BzDOG87BHkRjH
         /eUj7FARRoZubMlXtkGBOOxpBXrWQeHACuIs1+Qsy0EqoiVOZSFKGVDZ86UKn6atWfpp
         4mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=q34ScPT2v0UZvPgiMdelk8OvXShdIAeEpZ7s6ZCnBBg=;
        b=d+LVNlOc8yDiok/8kLArL3s5agVq3KUI4GNBA/tOk3ncwkbIbo4iGMs6I5x4+TM8WQ
         GJulCKZIEqPH6tUqHb35Zyds1xzFy6zsiGBkwo/XbWmB/WA6p2H6B6uh7QxwNZB7RXg/
         Bfmo4JOvwil93mfRo3iDPjJ8dWXF76dLdUPkenzE3DUUzHW7siX1gXtOHOEXLxWD0U0K
         l1/l+FJcTQQRLYq77+N+RBXq4uSwVeaQaSTgDsIpKor2XHpkhUKek1ZnB2NbeihB47Zr
         E3bhzBuWGKCSL2o6hMqZ6s1nsfnR09ak4o7C/tTPSUqa6HYS8xPg9kNUtrCCxwR8c+FK
         oxpg==
X-Gm-Message-State: ALoCoQkl23bSHbQI9Xx6TOJ1pAWV7skgSKiU5vx/8UYptIVnNRJzsMPKoacEzNRsw33oqndLgBfpkbQ40GxnOjnoIQJRDQH9rWQ6OM3cDwqbW/nbGgnU6J4=
X-Received: by 10.107.128.104 with SMTP id b101mr70140385iod.37.1452281206404;
 Fri, 08 Jan 2016 11:26:46 -0800 (PST)
Received: by 10.36.122.193 with HTTP; Fri, 8 Jan 2016 11:26:26 -0800 (PST)
In-Reply-To: <20160108192339.GA3514@salo>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283577>

On Fri, Jan 8, 2016 at 2:23 PM, Richard Ipsum
<richard.ipsum@codethink.co.uk> wrote:
>> You know what would probably also be a good idea would be to spec out
>> the entire format in a standalone document. That way when Gerrit
>> doesn't have something implemented, it's clear that Gerrit is wrong,
>> not that it's trying to fork the format.
>
> I think that would be good, I could attempt to write a spec for the format
> and post it here for review? I expect I'll want to work a little more on
> perl-notedb before I do that though.

Sure. I don't want to necessarily make more work for you, but it's
probably a good exercise to have someone write a spec who did not also
write the first implementation :)

You may post it here but you would probably get more feedback on
repo-discuss@googlegroups.com.
