From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: Teams of people using signed commits...
Date: Fri, 14 Jun 2013 15:25:27 -0400
Message-ID: <20130614192526.GA25486@google.com>
References: <CABQymNKuwiOz-MQuM12fWSgBvBsBrykNYBqPBxCuSuxAC5cZZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eric Fleischman <efleischman@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 21:31:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnZi9-0002zc-81
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 21:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753887Ab3FNTay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 15:30:54 -0400
Received: from mail-gh0-f202.google.com ([209.85.160.202]:56806 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab3FNTax (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 15:30:53 -0400
Received: by mail-gh0-f202.google.com with SMTP id g24so95974ghb.5
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JlKQL/ABv8sCIsF7Jdk9HT9GZ74mxDSP4FBR2Sn1r44=;
        b=M3zZ/yABmVL/rb5JxZWgOkouHrZKog+bRBIIrfV/H4pv2R0ZKamnI0qpfLj/SDKHRM
         Oz4YkVuJWopZC2J3yhGu3CBvTdiouUGUs7I2uTKYPt3xRD4StVTyZJkHBer1+Eo7a2kt
         jOeek2DPdRJ7ksGQy7pb4sUJWU///BGbmwjCfXdtEZTkx2DswlXk2p6afuzR/lHEwfD/
         p6JNFdZccK2Mh4G5agV8M5ucaz6yuSTLnlOrl3IcUDq90T98eHw6EXNNoxOOgahkBdrU
         771oa4KsUDfaXoBocXD8SbRe7Jba+O4Rkhev5G+40th9EQLXA9/GhTeWk4UtEbl1aPUY
         4Y9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent:x-gm-message-state;
        bh=JlKQL/ABv8sCIsF7Jdk9HT9GZ74mxDSP4FBR2Sn1r44=;
        b=jI9enn9jvpCI7ND5piOf6efLBf3L4/ofI8t7omJSaKC7i8IsIaN/mQFcIxHJcCrcCL
         OWP/tN9k+Hq5mJ06h1/kkSSlqgCgZwfXoqe+FXk/OkjgztgTBFTHN7jyTWWOwSPjrGBr
         Rws5siE950rhCrNc6I5ZZOYWiX4u8YBK7bO6Lq+Q5cumPUGs7HrBGtz8GbWYBb49GW3E
         PeuOyCLb0YDLPKb60j4FovXikTzYy/R5dttvpNOA+NQYMgoq86lbtAjfq+8OuoxajGTD
         T6Z4Cco4Gs3u2QATkLnjrx1/HeZIJLZUwJZ7tpy3frkhe6ANj6474R4tUROkIOcDoVe8
         PvwQ==
X-Received: by 10.236.112.33 with SMTP id x21mr2091541yhg.57.1371237927585;
        Fri, 14 Jun 2013 12:25:27 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o42si227323yhe.5.2013.06.14.12.25.27
        for <multiple recipients>
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Fri, 14 Jun 2013 12:25:27 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 709F431C022;
	Fri, 14 Jun 2013 12:25:27 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id 1CECD4069D; Fri, 14 Jun 2013 15:25:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABQymNKuwiOz-MQuM12fWSgBvBsBrykNYBqPBxCuSuxAC5cZZw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQkRJPbbA/PKnX5adrYXxkbpW0tIsOH1KifKVgYWCH5q9GHwz4uL8zDR2bNrHKCBO0Df3nGEI9/lQ8Yb/G/F1SHNKvRic3utEKprREqGAzaG1RNt2innyix8Qv4MdKRJ5OVz69afgadab4Kn182WZov2/IMopMf6gx3udNvrR+m5TwvY/2l9sCFWmsK8pjjnmBtSDKfe
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227913>

On Friday, June 14, 2013 at 15:02 EDT,
     Eric Fleischman <efleischman@gmail.com> wrote:

> We're very interested in using signed commits but are struggling to
> figure out how to use it in the real world. Would love some advice
> from those who know more.

What do you expect to gain from using signed commits? I'm not saying
they don't have a place, but depending on why you find them attractive
there might be alternatives. For example, won't signed tags do?

> We think we know how to deal with signed commits & auto-reject such
> commits at build time, as well as clean up. But we're worried that
> folks won't sign on the way in accidentally. We don't know of a good
> way to force the team to always sign commits yet, especially as they
> get new machines and what hav eyou.

Hooks? A pre-commit hook that runs on the machine and/or a server-side
hook (pre-receive or update?) should be able to enforce this. Well, a
client hook is trivially bypassed so it would just be useful against
mistakes and forgetfullness.

> Is there a way to add something to the repo config to force, or at
> least default, this?

I don't believe you can configure Git to sign commits by default, but
if you control the machine of your machines (assuming a corporate)
environment you can set up a template directory for hook distribution.
Again, that's only for client hooks that are okay to be circumventable.

[...]

--=20
Magnus B=E4ck
baeck@google.com
