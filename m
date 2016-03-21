From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [PATCH][Outreachy] branch: allow - as abbreviation of '@{-1}'
Date: Mon, 21 Mar 2016 18:12:36 +0300
Message-ID: <CAJPOeMd-zeThDhx-OWW_6LwG9A+U3UU-oKPOZGcycR-xQRPcgg@mail.gmail.com>
References: <1458305231-2333-1-git-send-email-elena.petrashen@gmail.com>
 <xmqqvb4jrcle.fsf@gitster.mtv.corp.google.com> <CAPig+cQYYPmUtOoTGDzzQJC8n+9UoVEskmnZ19E=rroyU5+Pkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 16:13:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai1WH-0006zx-2R
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 16:13:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078AbcCUPNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 11:13:09 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:36709 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755967AbcCUPNH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 11:13:07 -0400
Received: by mail-qk0-f169.google.com with SMTP id s68so80342365qkh.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yRStpJ/2Ae8idQtYYHKJCBMKDuFa6aKwgIuXfnuGiAE=;
        b=E9rA5/eDmbIU5OGfP6v8GEJ7IYHmlt9od4b4DQ5xBjI07a0HVYKt4wZyieoe0vYCfX
         R3y4eR1H6WQg8PeTjBVKUYtHaXJALNZGqZdGjhk1eA/jcJal9hGyi5lHTo/NTBshj3uX
         huHcjAh3XwE4+RMU8IR+s3FF/LC8HE+6QW1CXZr6v7p9oVp8E7BxzYBJ2+AXvUA0KjC2
         cUruIIYblesGy6biiKmgLNCl++x4ccGf+k0hXKzdNyXmswHROEANM9uUaF2SU+rddNH4
         Ri+fs+ZDBhfFlpMXp7Cv+DML8a3EuhuDsX/+1ddzwxNkibyCcnf4p9IenRNizLHfIvr2
         oHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yRStpJ/2Ae8idQtYYHKJCBMKDuFa6aKwgIuXfnuGiAE=;
        b=Tzh9z8oGthX1KZ0PjAXXT65CqA8CgQXV4E+sO9HMSGdlmt8zZnCyu9CFHktUZ7rI55
         0weyrMR+S31MsfEE91j4CE8bNP9G+kLv/U9DS941f3Uf0BAQNjaQqJUnvR7BhykTivTt
         sLryvazLZXlejTd0QJHuKdD1EwEQtTdYTLuCmcOWRK4zK20GGkOKiQVTKBmtfi/zmTA3
         7pCRRhp9so+92bOasMONEYkIwijOBxlt4rtHC+jtHkQH6aMMX0QoFYoyTwHlj3sQuKho
         rxqFs25oWDfbfNzuT62n7Xuiuh2pREO8g6wj7vLv/WN0Rt0DvXFJ3oWur6T4Xy/7NmP3
         +kAA==
X-Gm-Message-State: AD7BkJJfsxtqTsc4e9sEHIH3I6GCDD7M4VwD0VDSLoH2DqVBxfquwjzOTTg7YKMHxPi3ssYxf4m14phOm1ZAXg==
X-Received: by 10.55.75.85 with SMTP id y82mr40621597qka.29.1458573185517;
 Mon, 21 Mar 2016 08:13:05 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Mon, 21 Mar 2016 08:12:36 -0700 (PDT)
In-Reply-To: <CAPig+cQYYPmUtOoTGDzzQJC8n+9UoVEskmnZ19E=rroyU5+Pkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289419>

Hi Eric, Junio,

thank you very much for your feedback! I honestly apologize I
got so many things wrong.

I'll try to minimize the scope a little bit for the next attempt to
make sure my approach is good first and then expand:
i.e will only teach git branch to delete "-" & give out an
error message in case there is no previous branch
to make sure I got the basics correct.

Elena

On Fri, Mar 18, 2016 at 9:13 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Fri, Mar 18, 2016 at 12:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > On the submitted patch itself, in decreasing order of importance:
> >
> >  * The approach you took turns every "-" that appears as a command
> >    line argument into "@{-1}", but it does so without even checking
> >    where "-" appears on the command line is meant to take a branch
> >    name.  This closes the door to later add an option that takes "-"
> >    as an argument that means something different (e.g. one common
> >    use of "-" is to mean "the standard input" when a filename is
> >    expected).
> >
> >  * There is no explanation and justification in the proposed log
> >    message why you took a particular approach.  Why is that a good
> >    approach?  What are the possible downsides?  What were the
> >    alternatives (if any), and why is the approach chosen is better
> >    than them?
> >
> >  * We forbid declaration-after-statement in our codebase.
> >
> >  * When you do not yet have the "branch I was previously on", I
> >    imagine that your implementation would give you this:
> >    [...]
> >
> >  * You do not need the brace pairs around the body of these new
> >    "for" or "if" statements.
>
> Also for consideration: You'd probably also want to add a test or two
> or three to verify that "-" works as intended, and a documentation
> update may be warranted.
