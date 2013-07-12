From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/4] t4203: test mailmap functionality directly rather
 than indirectly
Date: Fri, 12 Jul 2013 02:05:18 -0400
Message-ID: <CAPig+cSfqONOFmmXX=s+HWKnLr5eG27jU9xgE7Dki0sycPPz1g@mail.gmail.com>
References: <1373554528-15775-1-git-send-email-sunshine@sunshineco.com>
	<1373554528-15775-4-git-send-email-sunshine@sunshineco.com>
	<7vhag0rk3u.fsf@alter.siamese.dyndns.org>
	<CAPig+cS7rxFzY8Q3gfTtJkggp-K62SVqsjCotbM3Bkm47L44gg@mail.gmail.com>
	<20130712005517.GA8482@google.com>
	<7v7ggwpbut.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 12 08:05:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxWTx-0004xv-AR
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jul 2013 08:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab3GLGFX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jul 2013 02:05:23 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:63403 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197Ab3GLGFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jul 2013 02:05:19 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so7464000lab.4
        for <git@vger.kernel.org>; Thu, 11 Jul 2013 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=w2F/DTCjSoIn8HRCH/r+D/3eIiI3It0aiHepF8DGgds=;
        b=m+XYOozeMd8IWbWVHYs9DUiaYyIetBCDGNvG6JQOqGqTwrewMK6oNjozJ9IE711JtN
         5vfugpNU3+LxCVjA0GarUfd2jLOArlDIWUZq52+XPoVhO10nINn5OmrLz0JtLQb5gYtY
         jgPJM8Qqd/eSPY1Selv/nfzk0G1d1jwZdNvPyxcjG8jxJ+X5UAMSpt+R7OAT0VBTIUfR
         DreJ2kUEV3SL4VWkSJQbnHmelXmSQaSBN0vDZzMqNgi+VVI5x3aH+vS7HvR/PY080IZI
         EMGtY6VzSrXMu8QlKbdD0CkERYantUIZ5S4a78z+nLqQBpjhxQa0Kv6NQ0yoBVMj7FpP
         vnKg==
X-Received: by 10.112.97.132 with SMTP id ea4mr18183249lbb.80.1373609118471;
 Thu, 11 Jul 2013 23:05:18 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 11 Jul 2013 23:05:18 -0700 (PDT)
In-Reply-To: <7v7ggwpbut.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: b91ymIiS9ompIVJHrwytZJGXvdo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230164>

On Fri, Jul 12, 2013 at 1:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> My current thinking is "no" --- the patch has as a justification "Now
>> we can test these aspects of .mailmap handling directly with a
>> low-level tool instead of using the tool most people will use, so do
>> so", which sounds an awful lot like "Reduce test coverage of commonly
>> used tools, because we can".
>
> Yes, that was exactly my reaction that prompted my response.

Does any of my follow-up commentary result in a different reaction? If
not, I'll drop patches 3 &4 in the re-roll.
