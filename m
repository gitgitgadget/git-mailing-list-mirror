From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/9] remote-bzr: trivial cleanups
Date: Thu, 25 Apr 2013 16:49:30 -0500
Message-ID: <CAMP44s296Fum_jKx51dhmmnz0jKkXG+P4XcE5xGen-euVUtYdg@mail.gmail.com>
References: <1366888849-19607-1-git-send-email-felipe.contreras@gmail.com>
	<1366888849-19607-2-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0meg1FgU=-4MFoFGjpDq_oa9XR_+qeiseR0J85mS71dNg@mail.gmail.com>
	<CAMP44s2nRHRFY_BRO7+x=CVKgrob78xZCpiV4Hk9sjWB_Q=vng@mail.gmail.com>
	<87bo92l5el.fsf@hexa.v.cablecom.net>
	<CAMP44s1uS23OvsDY+_YOBGMgc9t=FBEV3YvM34M9sLMEF9hnTg@mail.gmail.com>
	<7vwqrq1eco.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christophe Simonis <christophe@kn.gl>,
	Simon Ruderich <simon@ruderich.org>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 25 23:49:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVU2r-0001Me-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 23:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759319Ab3DYVtc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 17:49:32 -0400
Received: from mail-lb0-f171.google.com ([209.85.217.171]:60626 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758819Ab3DYVtc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 17:49:32 -0400
Received: by mail-lb0-f171.google.com with SMTP id v10so3235903lbd.30
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=v9JyeOLDNpglSFpINv7Eckp/Q00LBcz81rAZBKTVWZQ=;
        b=QAofMKCZxpDlqEQV3cGF2QhYH9/iGQr08AD5RL2GLkcNy+YnCUfeWMKYuKZCOtMzbs
         N5rdck+JrYuVNwvMkIz0DbwykzBc6CRvwLEejMuTwokAst9SIrCQb7cPhVdJ9tP6Kwuk
         WOb/PR1jgpYi2OeqFCv+76dpQh4n52UY7E/USWlObedmfivX7QXmKJO9bdcPhBa8DA2G
         QGE0ZCgHEuf7OqFPMLQfCsrhBnXnV42ltpOFXBw8MFtu67QRZ8GiG1gRMcCsRrx6f6qs
         aJTu6ShiwtDcNuu7kF6htFJEzH35zw4EUgiSnFQad5HG23vVc9jHCY+T/590+Le4GH0W
         LJNA==
X-Received: by 10.152.5.134 with SMTP id s6mr21281649las.24.1366926570822;
 Thu, 25 Apr 2013 14:49:30 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 25 Apr 2013 14:49:30 -0700 (PDT)
In-Reply-To: <7vwqrq1eco.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222455>

On Thu, Apr 25, 2013 at 4:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Thu, Apr 25, 2013 at 3:30 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> But I do not care that much really. The patch is good either way, if
>>>> you don't like it, you go ahead and fix it, because I won't. I have
>>>> 174 remote-helper related patches in my queue, and nobody benefits
>>>> from rambling about a one liner that is obviously correct, not you,
>>>> not me, not the users, not the developers.
>>>
>>> You don't stick to the rules of this project, which have been pointed
>>> out already:
>>
>> The rules of the contrib area are different from the ones of the rest
>> of the project.
>
> Yes and no.
>
> A contrib/ material may not be held to the same high standard, but
> that does not mean a contrib/ area maintainer has a blank check to
> do anything there.

Nor did I claim I had one.

> It would be pretty obvious to people observing what happens in the
> area after a while, if the quality standard the area maintainer
> enforces is too out of whack, and at that point the area maintainer
> deserves to be ridiculed ;-)

Of course, but the claim the rules are different still stands.

>> And I don't recall Peff ever doing this "constructive
>> fine-let's-do-the-work-for-him" on any contrib/remote-helpers stuff.
>
> I do not think Thomas was talking specific about contrib/ material
> but your interaction in general with other developers.
>
> Cf. http://thread.gmane.org/gmane.comp.version-control.git/220427/focus=220891

Yeah but how is that relevant in this context? We are talking about a
particular patch of remote-bzr. And he immediately used that claim as
ammunition to suggest the whole remote-helpers should be dropped. It
does not follow.

Any suggestion to drop remote-helpers should use facts and arguments
regarding remote-helpers.

-- 
Felipe Contreras
