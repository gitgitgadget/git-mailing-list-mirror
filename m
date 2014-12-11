From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 1/2] t1400: add some more tests of "update-ref --stdin"'s
 verify command
Date: Thu, 11 Dec 2014 11:19:41 -0500
Message-ID: <5489C41D.103@kitware.com>
References: <1418255272-5875-1-git-send-email-mhagger@alum.mit.edu> <1418255272-5875-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Dec 11 17:19:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz6T0-0001oG-1U
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 17:19:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933070AbaLKQTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 11:19:46 -0500
Received: from mail-qc0-f173.google.com ([209.85.216.173]:45408 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932897AbaLKQTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 11:19:45 -0500
Received: by mail-qc0-f173.google.com with SMTP id i17so4094028qcy.32
        for <git@vger.kernel.org>; Thu, 11 Dec 2014 08:19:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=hC5zWzCZ7SyNFb+aOJViT7UlAXkfxAQkafbBwtoKUCw=;
        b=b2fgPaXk9hlRg2whs2eyzWsXrf+nkvQHW+dJ3dq0KzUMa1yKT30ojQduIO85iG0gCo
         YU0nGr+lOtc7O/6nmsMXQNrgv7RZt5tWnJcBvUcsuN7sEe/xtwowzwTMrFFnnb+YI2S3
         1ahZVEI9Sb2CLVescPxY/X17jj8PRGEMm0kSC9FH2EiQ39KO16Iw0YjhAGsUNfRzJt2y
         QQwm+0OzMVzQftX4tpiLSCcH6XMtje39zHpONyCwwPg9Ig8S3UlR07XPQhCCMdpPGRcu
         9cNTBgWV+ZZiY+KzsG2fyV326m1bu0cinqKQOxFh9ZrO1n6MoUBSkTPVMMUu0ekciyTd
         5xpQ==
X-Gm-Message-State: ALoCoQkF7Ycfwg7NtA0zdH2Oizmm9jPzr+ws8ErFAFhWWi99Rq6ZM/Mfvhk0Z3bo+0z7Ox37CAll
X-Received: by 10.229.16.197 with SMTP id p5mr21452167qca.3.1418314784773;
        Thu, 11 Dec 2014 08:19:44 -0800 (PST)
Received: from [192.168.100.143] (cpe-72-224-128-246.nycap.res.rr.com. [72.224.128.246])
        by mx.google.com with ESMTPSA id 36sm1434128qgn.10.2014.12.11.08.19.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 11 Dec 2014 08:19:44 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <1418255272-5875-2-git-send-email-mhagger@alum.mit.edu>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261283>

On 12/10/2014 6:47 PM, Michael Haggerty wrote:
> Two of the tests fail because
> 
>     verify refs/heads/foo
> 
> with no argument (not even zeros) actually *deletes* refs/heads/foo.
> This problem will be fixed in the next commit.

Reviewed-by: Brad King <brad.king@kitware.com>

-Brad
