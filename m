From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git has a healthy truck factor..
Date: Tue, 28 Jul 2015 14:11:01 -0700
Message-ID: <xmqqk2tkc7iy.fsf@gitster.dls.corp.google.com>
References: <2E436A2846834D6CBD77FBEAD1EFB43C@PhilipOakley>
	<20150714153950.GA17709@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 28 23:12:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKCAI-0005Pc-3j
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 23:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbbG1VLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 17:11:54 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34822 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbbG1VLx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 17:11:53 -0400
Received: by pabkd10 with SMTP id kd10so75641108pab.2
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 14:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=oWB4pS7f6qm10MFmBjPIVgIajw9DjZo3n60A2LeROno=;
        b=mjEpJ9kyL6D666djgcPrysNsGhpfnPMCrL/K+R7Grn4TdZevserghmQFCmELufTSOQ
         sM0HQHmN/fUNv0B1TGX1JgP/orlI7A9k6yzIBMmGsZhIow6fyAnFrkQKoqj66DP0qTfp
         +v9GQ2+/aoq5cZxgBIb/A2S69gFQDtlALk6ZjM2F/wBhB1tYfaPgHaoXZPnUBTDKc+Df
         mlMDBb020ex5Cl4r7gUm10v7fIpYnQ10M2UyAiqoXtPljUN5SOAXZT2QEwwL6CJ6eai2
         bn4grw8cVteqgyojQI46LrOXe8A1J41axN7C8xhxFFyceBO52iKfSMr8TwWcH3t5kD30
         E+kg==
X-Received: by 10.66.249.101 with SMTP id yt5mr84815247pac.116.1438117913268;
        Tue, 28 Jul 2015 14:11:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id ff10sm36982460pab.13.2015.07.28.14.11.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 14:11:03 -0700 (PDT)
In-Reply-To: <20150714153950.GA17709@peff.net> (Jeff King's message of "Tue,
	14 Jul 2015 08:39:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274850>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 14, 2015 at 12:05:58AM +0100, Philip Oakley wrote:
>
>> It looks like Git has a healthy truck factor of 8, as reported in
>> https://mtov.github.io/Truck-Factor/, which has Git eighth in the list of
>> projects it analyzed, with Linux at second place.
>> 
>> The analysis method paper is behind a pay wall, so I couldn't see how
>> sensible the methodology, but it's nice to know Git's a broad team.
>
> One thing I noticed is that Homebrew has an extremely high number. But I
> suspect this is because it has a very large number of somewhat silo'd
> files. That is, people work on package formulas for projects that
> interest them, but what you really care about for the health of the
> project is who is working on the base system. Maybe those formula
> authors could step up, or maybe not, but I'm not sure that is reflected
> in this analysis.

We can actually say the same thing for us.  We do have a high number
of people who are competent, but I wish I can really say that I can
readily name 8 people who can act as an interim maintainer when I
disappear for a few weeks from the list.  I unfortunately can't.

Oh that reminds me.  I plan to do that disappearing thing this year,
around mid-November for a few weeks.  You, Shawn, and Jonathan have
took turns playing interim maintainers in the past years to help me.
As we do not see much of the latter two these days, I am wondering
perhaps it may be better to ask somebody new this year, which would
hopefully bring the actual number closer to that mythical 8 ;-).
