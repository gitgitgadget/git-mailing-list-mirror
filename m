From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] date: make "local" orthogonal to date format
Date: Thu, 03 Sep 2015 08:54:57 -0700
Message-ID: <xmqq613rmram.fsf@gitster.mtv.corp.google.com>
References: <20150831204444.GA4385@sigill.intra.peff.net>
	<20150831204831.GB10338@sigill.intra.peff.net>
	<xmqq37ywoh0x.fsf@gitster.mtv.corp.google.com>
	<20150902213013.GB21612@sigill.intra.peff.net>
	<20150902220740.GN30659@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Sep 03 17:55:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXWr4-00076o-Hp
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 17:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932954AbbICPzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 11:55:00 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36569 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932942AbbICPy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 11:54:59 -0400
Received: by pacwi10 with SMTP id wi10so50482330pac.3
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 08:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w19j2bTV5nMWrHjDONQiJ0+0F4xsmtvT3ILXTTwcZtk=;
        b=UgIiP/8kWa3o3o9z33IiY7BFVPEq+F1Z1e++js0EHJeT3kop26v04B7sF0lZUQz0bo
         mpd6zdE/JDPcUhHOYH3wOg05C3/DGZ8NKSUCjX89tgdbX1hy2gb1OU7UYMj/z7YiKdEF
         H9UWCedz36perd0/DsESeTodA9gsVmT0YGvLT3WZSxXP8weK5IsFWHOcEpvEvD7KPFgS
         +mNT4oqePhwTi/coKxsSzuof+RZSS6kB+AUwsfjtohY7ufJCyV51naTIN7xmVsfllGx5
         9IQCMILxlWcfIuS1swQS4RlE/GlnQpgxhXpxZ8bU9eECC0+EWVk3fWBs2K6GjlVxTFtV
         23Sg==
X-Received: by 10.68.100.226 with SMTP id fb2mr68639879pbb.92.1441295698758;
        Thu, 03 Sep 2015 08:54:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:71da:b56c:f873:e611])
        by smtp.gmail.com with ESMTPSA id tq6sm25690230pbc.57.2015.09.03.08.54.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 03 Sep 2015 08:54:57 -0700 (PDT)
In-Reply-To: <20150902220740.GN30659@serenity.lan> (John Keeping's message of
	"Wed, 2 Sep 2015 23:07:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277213>

John Keeping <john@keeping.me.uk> writes:

> On Wed, Sep 02, 2015 at 05:30:14PM -0400, Jeff King wrote:
>> I think the error message would be a lot nicer if we indicate that "-"
>> is syntactically interesting, and say:
>> 
>>   fatal: unknown date-mode modifier: locale
>
> I wonder if we'd be better just saying:
>
> 	fatal: unknown date format: short-locale
>
> I'm not sure users will consider "local" to be a modifier, there is
> simply a list of formats that happens to include pairs of matching
> "-local" and "not -local" variants.

Either is acceptable and better than the 'e' output.  I think yours
is better because it would equally work well for those who think in
terms of "modifier" and those who think in terms of "flat list of
possibilities".

Thanks.
