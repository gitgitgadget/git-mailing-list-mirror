From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Has Git 2.0 started to be integrated?
Date: Wed, 16 Oct 2013 15:11:40 -0700
Message-ID: <20131016221139.GM9464@google.com>
References: <CAH5451=8BYN-Jsxsbw-3R36Kix__1kfW7r3_dtSbNhg+ukyNfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 00:11:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWZJk-00074K-16
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 00:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756223Ab3JPWLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Oct 2013 18:11:43 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:56365 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753468Ab3JPWLn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 18:11:43 -0400
Received: by mail-pa0-f50.google.com with SMTP id fa1so1680924pad.23
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JVo6lnoyzrlJlLfrbnfCwMgkFk1Aj1BX4n87E2nwvfw=;
        b=jRaej+sn1b1pFvj2NkgRUbIOAKnQEXpRx/3iJ8Jni5X44PUzOKSR/BcOGTbSYPjnFy
         lbt3c5lYAqGjAUhTkzOeMnJf2W6dJdaPL44o3sI2KVTVxsxhY2qY1g38acsChC5lP2b0
         9R8d2ojJgmOA5vAnVH65OGY2zzAfxJGFVTAZhz2w6WK2MhKD5kP0eiF8+TA/rW5cRkVs
         BPJ5JQp3qjHy469bGYBfyuiE7HVr0+zFEPG32i+Yux35lG9w0nfFmtElpi5ZWzqmzjAl
         +Pisnfcnun1stTloE4zbj521nGxiHDO5i1G0QD4wVzjbdGo+reUsQxhcAHAN8Y7MrEVF
         fJ5w==
X-Received: by 10.66.230.233 with SMTP id tb9mr5889133pac.38.1381961502714;
        Wed, 16 Oct 2013 15:11:42 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sb9sm93390288pbb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 15:11:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAH5451=8BYN-Jsxsbw-3R36Kix__1kfW7r3_dtSbNhg+ukyNfg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236277>

Hi Andrew,

Andrew Ardill wrote:

> There has been plenty of comments lately about how certain features
> will be released in 2.0
>
> Have these features been tied together anywhere yet?

They're in Junio's "jch" branch:
https://github.com/gitster/git/commits/jch

> If not, when might such an integration branch be created? Would be
> very interested in seeing how Git 2.0 plays, even in these early days.

I wonder if it would make sense to keep these topics in "next" even
though they will probably not be part of the next release, to
encourage people who test that branch to try them out.  (Just thinking
out loud.)

Thanks,
Jonathan
