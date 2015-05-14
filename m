From: Alex Coppens <alex@nativetouch.com>
Subject: Re: [PATCH] rerere: exit silently on "forget" when rerere is disabled
Date: Thu, 14 May 2015 16:59:39 -0400
Message-ID: <CAPt1q6fNtTvjtXFs+BO1Kgpkn9pkdJkqN7uwJUK=zE4=atrOnA@mail.gmail.com>
References: <CAPt1q6fMMz61aZEJB9b+K6+kHFwkm+bMYXoKBj78GNJU+dWioA@mail.gmail.com>
	<xmqq7fsbkn9z.fsf@gitster.dls.corp.google.com>
	<20150514191637.GA9329@peff.net>
	<xmqqr3qjj7b6.fsf@gitster.dls.corp.google.com>
	<20150514192052.GB9329@peff.net>
	<xmqqmw17j6oh.fsf@gitster.dls.corp.google.com>
	<20150514202207.GA13541@peff.net>
	<CAPt1q6dhZarACvYQM5HFTGg3xA=LjnhF7DP8B6K+Fa1=m2Of9w@mail.gmail.com>
	<20150514205617.GA14836@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 14 22:59:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yt0EL-0000jO-2n
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 22:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933803AbbENU7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 16:59:41 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34655 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933583AbbENU7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 16:59:40 -0400
Received: by pdbqa5 with SMTP id qa5so103625299pdb.1
        for <git@vger.kernel.org>; Thu, 14 May 2015 13:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vkUdo6gt0r3hIq1uJrJcpCCqkjDEtamjo+4h45j6zlI=;
        b=N8ur4960rz/3ORK2o6riY4D0FEQ1NyuklPMH8Bw0I+GXaPqwRmhA44erUt5rpDXn3k
         Y1+s1Sky/01HHfhWI3pBhG9bGSWXkabznP9ON44jbnJRSnYlmrAVG71aQ30MVUzZHS5f
         PiJEr7+ZctJL5G5GV8MnIta8sgJJ2eS3s2v8e6hh9rFCDu/ovZOngEOY54VaTFwO9wiN
         MLTXFPULRPfdZBLBpox+rpKcp0vkh2EeaW3e+IlZ4CqIIG59748xPl2BpqNGNLpFDEDm
         FFF1hUSjJEWRifb7DHMG+uH6PmpuoTwHAeG6kPvKzvmHtNCVhewofCtHNjtWxI2WYKXx
         vR8Q==
X-Gm-Message-State: ALoCoQndqsNyXWyhNEIN1CMgBbm1GRRn9PocNLRDU/kuD8lIu32N1J2hrCMhNwR9cI+Wtl8LVuv3
X-Received: by 10.68.135.73 with SMTP id pq9mr11638228pbb.46.1431637179499;
 Thu, 14 May 2015 13:59:39 -0700 (PDT)
Received: by 10.70.45.135 with HTTP; Thu, 14 May 2015 13:59:39 -0700 (PDT)
In-Reply-To: <20150514205617.GA14836@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269094>

I really thought my boss setup rerere on my project a while ago.
I had a merge without conflicts that went wrong (the whole app
breaking because of a missing comma) so I assumed a conflict was
automatically resolved.

Alex

On Thu, May 14, 2015 at 4:56 PM, Jeff King <peff@peff.net> wrote:
> On Thu, May 14, 2015 at 04:51:25PM -0400, Alex Coppens wrote:
>
>> Here are the outputs I have:
>>
>> $ ls -d .git/rr-cache
>> ls: .git/rr-cache: No such file or directory
>>
>> $ git config rerere.enabled
>> $
>>
>> My repository is a ruby on rails project, I am currently on the
>> development branch. It's a private repository hosted on Github. Not
>> sure what other information you want.
>
> OK, so it looks like rerere is not enabled (and my patch will fix the
> case you saw). But then I am puzzled why you were running "rerere
> forget" in the first place. Just experimenting, or did you expect it to
> do something?
>
> -Peff
