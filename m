From: Stefan Beller <sbeller@google.com>
Subject: Re: What's cooking in git.git (Nov 2015, #02; Fri, 6)
Date: Wed, 11 Nov 2015 11:21:19 -0800
Message-ID: <CAGZ79kZC9kf4VyyHx65EAwjSeiiX-OXQo0Bca0fZozMaDa9iVw@mail.gmail.com>
References: <xmqq4mgy3dcr.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaK==GhD4nUTh4nnd_NPTNsUG15kS61hAhmP=K6MdHmYg@mail.gmail.com>
	<20151111191151.GA29543@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:21:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwaxQ-0006rI-4V
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:21:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbbKKTVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:21:20 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:36458 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509AbbKKTVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:21:19 -0500
Received: by ykdr82 with SMTP id r82so65579848ykd.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 11:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=s8G5fbYD7o8GIH+XIfa9OP+BV2G1bSjNzXbpC0dTxpY=;
        b=UvaTkprDyx+uYeBGCHFvcm5t/soDiyS3rnE+Q3fX6vhth95H9Sto/wQaUfV78KQ1zh
         U74ImDq5AH2BUzn+NNERILDGo0EbewSB7rMEYckyjAiKfdxAy8oO+2OGV6fzcGTpK7mR
         T3un47scq/PQtKj20wi3mVTpkmlhhBZTh2c+kqlmXfaiQSD50iOwAd1+dAQbjOq8B3Os
         uzRGiEaxp7TfKICz7999YLallQOsu2bdLTcHK6t4ly0Zee7riwVZCc9HhqNMXDXAwm9a
         cpnB5e/R9vO5FJze8kP4gO9goRB9BHHRjmO14CjYwP9kyNSDKidOSihgqCusUIUz1dq3
         n3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=s8G5fbYD7o8GIH+XIfa9OP+BV2G1bSjNzXbpC0dTxpY=;
        b=Ubmd49TLA+pSfEM2IHEAmzX7arX+U0Dsp/BaSDT+gL2L7yl/3ioangkJoiVxFgra5h
         03mkwqFqHr659z6T5aYkhHuTkbhCx0EKb8xWF27Sjlny9aL4lw44pq9iUcRJE3bN1Fhs
         gD0dI0qpJZpdGrMCrpiHLg7DY6lOvFOBzPhqhr84xuSQFLJ5wrtSuyGor813+ivoBYah
         J+T2qs99kQkHaixEx9dFa+PjROyubC2erOInB+jgxYEkTkvgz/0KEFazI04c7Y9TnWY3
         5SoVGcqfFc8FVebdcqZtXjEWB4QvMMuQ0YAP8R0QsxRxIo3U2iyBnJ/RXtVYQGbQOsia
         49Pw==
X-Gm-Message-State: ALoCoQl3Kw3D7N0syuIHyC9lrEk3GL/w+MyHmnQeWhtKHmRo8/LMaXX25O2plrj20anWTSM74hQz
X-Received: by 10.13.214.19 with SMTP id y19mr11804340ywd.63.1447269679319;
 Wed, 11 Nov 2015 11:21:19 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 11:21:19 -0800 (PST)
In-Reply-To: <20151111191151.GA29543@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281179>

On Wed, Nov 11, 2015 at 11:11 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 11, 2015 at 10:59:26AM -0800, Stefan Beller wrote:
>
>> On Fri, Nov 6, 2015 at 3:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> > I'll be offline for a few weeks, and Jeff King graciously agreed to
>> > help shepherd the project forward in the meantime as an interim
>> > maintainer.  Please be gentle.
>> >
>>
>> Jeff,
>> gently asking where I can find our interims maintainers tree. :)
>
> Sorry, I was traveling Monday and Tuesday this week, so I haven't pushed
> anything yet.

No worries, I just started Git again today, too :)
Shawn tricked me into doing Gerrit for the last few days.

> I hope to do a cycle today and push out the result. My
> plan is to push my workspace up to git://github.com/peff/git.git,
> including topic branches and the usual master/next/etc.

ok remote added.

Thanks,
Stefan
