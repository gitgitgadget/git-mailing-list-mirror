From: Stefan Beller <sbeller@google.com>
Subject: Re: Regular Rebase Failure
Date: Tue, 21 Apr 2015 11:34:37 -0700
Message-ID: <CAGZ79kY0pbC6qH+Refm8Py0PyF2xNMLfSarhA+3-7eaU==RK7w@mail.gmail.com>
References: <553685E0.8010304@gmail.com>
	<CAGZ79kadXgsdCLH-YFQ5RhyKbRv9-qmUOQo-9QkKM2=8p17j+g@mail.gmail.com>
	<55369509.2080200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Adam <adamgsteel@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 21 20:34:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykd0N-0006bO-FL
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 20:34:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755246AbbDUSei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 14:34:38 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34299 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbbDUSei (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 14:34:38 -0400
Received: by iget9 with SMTP id t9so90666311ige.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=AH2VwQ27sHjQF3pTT+/oNw6cYQdmvax61z9w6+HbI1Y=;
        b=B8bhR6N11ekK0Q6DQjmUMdqv4RCAKpEc27dJT9czHy1R7reltSlxI85LK0Pmh92/Cy
         n/z4xlh3EAxcRvOLcuOVieuduCfr9ENVmInkzhHkEDLT7VDuSbsJwYJ79wQDLMO9UhsP
         pKH4Bt1kxJgUObb8tDW7ag17a8cfFD9HuDN65hhH9tWl9vevix71991ZgmchqU5l80aL
         KGEbekDuDX8qdB+vHUnZ3mA5gyYRQFER4wI7xXYswX2AJeLi06WA1kqwVYhFZLostHz0
         AnEHhf4k/zHIr0Y0eQ4CaBekkKtOphQa4LAjbZQ7eHxPmKwADFyyZYgBKyr5ouVayqbc
         zJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=AH2VwQ27sHjQF3pTT+/oNw6cYQdmvax61z9w6+HbI1Y=;
        b=mvDDARIcET3qUD/di5/vhtqy+Ivk/iCelzlzEiQdt8QPHaYc/r8DWHAiD6jfCrCCk9
         yBVRvG6wClufrx7YD9u57+L14mdgYQ1QfSpycQUpEcITW/ewxwU3KlUYkVJ7sdzPOe5M
         DnWrX9dMZWIseQEUD5iCBhSQaXcNE99vdZInwnNbNXPBRaLoAII3ax43+L8ZXurCR8Jc
         lG4edFJAqpbefqFU6ez6zuchCH68I7Zqp1MrGQaPdoV31KPze7BcmnKC7tFSrPG+6Tk9
         RncmtAPX3iqd1/Hk/0nxAT9PR5D1PeVqdiWEhHpKQtgimmqgUX6Dbkr5LI1UeR4abX6J
         BoOQ==
X-Gm-Message-State: ALoCoQlgjvDGaSDUmxnsYRRKSimSVZNEupgV/YpNeBXuWi9WLe0LZqigJiNIEBdqUWZ4OXu8gMWN
X-Received: by 10.50.117.4 with SMTP id ka4mr29598662igb.10.1429641277306;
 Tue, 21 Apr 2015 11:34:37 -0700 (PDT)
Received: by 10.107.46.22 with HTTP; Tue, 21 Apr 2015 11:34:37 -0700 (PDT)
In-Reply-To: <55369509.2080200@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267546>

[+mailing list]

On Tue, Apr 21, 2015 at 11:20 AM, Adam <adamgsteel@gmail.com> wrote:
> I'm using git version 2.3.2 (Apple Git-55).

We should loop in the maintainers of the Apple Git version, they'd know
what changed in git about two weeks ago.
I have no idea who that is though.

>
> That explains why I can't find the index.lock file, since the error that was
> thrown deleted it. I'm still not sure what to do about this, though.

Complain at the right people so it gets fixed. ;)

>
> Thanks for responding.
>
> Adam
>
