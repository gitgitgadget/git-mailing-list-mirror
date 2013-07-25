From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/5] range-set and line-log bug fixes
Date: Thu, 25 Jul 2013 04:09:50 -0400
Message-ID: <CAPig+cQkoaCi1SHTDbHFy2Fjx09_WcOquaUti45_Z3UxOJQ33Q@mail.gmail.com>
References: <1374589688-27751-1-git-send-email-sunshine@sunshineco.com>
	<CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Bo Yang <struggleyb.nku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 25 10:10:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2Gcd-0006rb-6w
	for gcvg-git-2@plane.gmane.org; Thu, 25 Jul 2013 10:10:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754966Ab3GYIJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jul 2013 04:09:59 -0400
Received: from mail-lb0-f172.google.com ([209.85.217.172]:40389 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab3GYIJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jul 2013 04:09:53 -0400
Received: by mail-lb0-f172.google.com with SMTP id a16so1299987lbj.17
        for <git@vger.kernel.org>; Thu, 25 Jul 2013 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=jGvEq/dbMSOdmXb6U0qEBl55pYnMWDxfkSGl3PoJqBw=;
        b=GSTv0Fg1CBzHnTB3DQLjWhuTC1wUQU41c/yNGlWuJvsMSnOpacpmJ8EbK0lkbNA3jY
         3h3u6OVNsSAt6n8vcZAHUEuwGFZq10tstUJD35egdqxnpuw1kk7XWZwHQL9q2LaE1Uke
         isxC5dRtk6SFMvVWp/xdVCHy7unpJA+Z9uMKKYAk/FXdVDQ6L7Bbem6MX6gQa5ttF+Xv
         kEGszC+uuT+CJJDlb4mSpJC+zMVz7iP0MKVyIgVtt21Np2IMCeNE/vkngdwTDUJxq+Zf
         3QqZIvzod48Ss/OT0ycstJegESNOdTOSqMkXZqu0hsFs1E+kppYf7eLbuWXTkluHowv+
         QhrA==
X-Received: by 10.152.44.225 with SMTP id h1mr18140537lam.90.1374739790517;
 Thu, 25 Jul 2013 01:09:50 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 25 Jul 2013 01:09:50 -0700 (PDT)
In-Reply-To: <CAPig+cRWaKv6UN5pZLwonXBpHnFE7+4ELXTnE+2nLr8h83bX6Q@mail.gmail.com>
X-Google-Sender-Auth: hshZkEpYXdYYAC6_xc55x2ujW5k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231127>

On Thu, Jul 25, 2013 at 4:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> I don't
> really consider this a good argument in favor of -Lfoo,+0 representing
> an empty range, and it's a very poor substitute for Michael Haggerty's
> more expressive proposal [1].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/229755/focus=230967

And here's the correct link to Michael's proposal:

http://thread.gmane.org/gmane.comp.version-control.git/229755/focus=229995
