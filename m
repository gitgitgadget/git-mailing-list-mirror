From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: [PATCH 3/3] difftool: Disable --symlinks on cygwin
Date: Wed, 25 Jul 2012 21:39:03 +0200
Message-ID: <50104B57.5050206@gmail.com>
References: <1343186064-49350-1-git-send-email-davvid@gmail.com> <1343186064-49350-4-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Tim Henigan <tim.henigan@gmail.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 21:39:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Su7QT-0006h2-7g
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jul 2012 21:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947Ab2GYTjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jul 2012 15:39:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41283 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab2GYTjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2012 15:39:09 -0400
Received: by bkwj10 with SMTP id j10so784443bkw.19
        for <git@vger.kernel.org>; Wed, 25 Jul 2012 12:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Y9wAEr9aJ0ijczFtkphhmnA+xCDy0GhG9tYraiGhG6s=;
        b=KB26P8EO6tMnkoUXGUI/r8XtptrNhtH5skGD9Btby4WAhF/qnR6d8aBAnQYEVARrbj
         lpM4IcJbDLTh8uCUh9IiOtHMQoEAu/OuQ/Ur/EqTzX2RMxZt5RLB6+JEAjEYQNaX2TTt
         bg68Mrou/9Gg5RSJpUJkzlLi/7BFs280ATmjgXJCg3Teb9Hj+TKPRZsv7J3eWXP96k5A
         3SVms7R9u0FqihbY4oGAUAyRjApzKy2eqP8sTC06wscyFy0oNDyjLbA0udSd4CFuqXqv
         POd1plsXlQf9D5ikZ+ARceFr8UtC8SDsE3cOJgg+9uaHdF1QoB1JUG31ByubLXQ+ftI1
         xH0A==
Received: by 10.204.129.14 with SMTP id m14mr12423840bks.7.1343245148149;
        Wed, 25 Jul 2012 12:39:08 -0700 (PDT)
Received: from [192.168.178.21] (host105-96-dynamic.4-87-r.retail.telecomitalia.it. [87.4.96.105])
        by mx.google.com with ESMTPS id y20sm13476469bkv.11.2012.07.25.12.39.06
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jul 2012 12:39:07 -0700 (PDT)
In-Reply-To: <1343186064-49350-4-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202187>

On 07/25/2012 05:14 AM, David Aguilar wrote:
> Symlinks are not ubiquitous on Windows so make --no-symlinks the default.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> I don't have cygwin so I can't verify this one myself.
> Is 'cygwin' really the value of $^O there?
>
Apparently yes:

  $ uname -rso
  CYGWIN_NT-5.1 1.5.25(0.156/4/2) Cygwin
  $ perl -e 'print $^O'
  cygwin

Regards,
  Stefano
