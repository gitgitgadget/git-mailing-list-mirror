From: Junio C Hamano <jch2355@gmail.com>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 00:22:12 -0800
Message-ID: <25ea208e-353d-48f7-a849-143689fb2be6@email.android.com>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com> <1327880479-25275-4-git-send-email-felipe.contreras@gmail.com> <20120130025014.GA15944@burratino> <CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com> <871uqh3a8s.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 09:22:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrmVQ-00012f-CF
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 09:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab2A3IWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 03:22:24 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38540 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725Ab2A3IWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 03:22:23 -0500
Received: by iacb35 with SMTP id b35so4863391iac.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 00:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:user-agent:in-reply-to:mime-version:content-type
         :content-transfer-encoding:subject:from:date:to:cc:message-id;
        bh=vOTgbkZ03z0XhDZL+qzhzML/2ww0rcYGzRR8mY24Kac=;
        b=RwNhxFI+USjaCLHf7yqgLvQkO5XMqkLbSm/gKLfhD+bLSuK4/pM50khP80HvarRKSY
         xzeccz6qM7aPc8C4xpMbImdCljxmFA70WUUZTd4ivllVqOQvYDbcBU3BvXnJUmCvkMWD
         CeZm3ZzDPlC0drHd5DgQeo8Z0EfrFtUWi6nyk=
Received: by 10.50.202.97 with SMTP id kh1mr16281891igc.19.1327911743279;
        Mon, 30 Jan 2012 00:22:23 -0800 (PST)
Received: from android-1996152855784664 (37.sub-166-250-41.myvzw.com. [166.250.41.37])
        by mx.google.com with ESMTPS id ba5sm9005796igb.6.2012.01.30.00.22.20
        (version=SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 00:22:22 -0800 (PST)
User-Agent: K-9 Mail for Android
In-Reply-To: <871uqh3a8s.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189329>



Thomas Rast <trast@inf.ethz.ch> wrote:

>Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> No reason. I hope they read the mailing list, otherwise I'll resend
>> and CC them. A get_maintainers script, or something like that would
>> make things easier.
>
>I simply use
>
>  git shortlog -sn --no-merges v1.7.0.. -- contrib/completion/
>
>(In many parts the revision limiter can be omitted without losing much,
>but e.g. here this drops Shawn who hasn't worked on it since 2009.)

Or "--since=1.year", which you can keep using forever without adjusting.
