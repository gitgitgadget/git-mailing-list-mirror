From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 20/43] refs-be-files.c: add methods for the ref iterators
Date: Fri, 25 Sep 2015 14:33:53 -0700
Message-ID: <xmqqa8sa2nge.fsf@gitster.mtv.corp.google.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
	<1441245313-11907-21-git-send-email-dturner@twopensource.com>
	<xmqqeghm2p98.fsf@gitster.mtv.corp.google.com>
	<1443216533.8657.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu,
	David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 23:34:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zfacy-0005u6-17
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 23:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933344AbbIYVd4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 17:33:56 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35811 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933216AbbIYVdz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 17:33:55 -0400
Received: by pacfv12 with SMTP id fv12so118349286pac.2
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 14:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=C3n4P1pM1eyBZxLtB2VvmxMDO5VFi5zZf7zlTrkfiuY=;
        b=t8TdCk9b0w8PK5wF0MekiqwGq5DolJmheqIxWJyx9ktZTlsGRix89TLZJZWSexc7qQ
         u3tKgUB7gnaaDQrDih27B38hqGumjIO+EwdKFYemSiSxZ+JBo81zuKxvt8iLLZFoXXhb
         M8uV8KqdFGstVvCsNZNbOIE6XFYnz5HSPsayzaDyWuEF0n35f6VjX/Y2KTf/3zK3Ft7h
         6CrsglccTel35/KuWuwmMJCjB8B1cM/HDnH+im8XK2LfF0j6gP8QCpHbtxU0DMIFLE/r
         cXBb5d9lbbzzZe4sqMI8cPbqHByhxQn1QYcRKAJmN7ZIKPwE2CTwOqqxuuvHYUa0lS1x
         2wig==
X-Received: by 10.68.100.36 with SMTP id ev4mr9995917pbb.119.1443216834811;
        Fri, 25 Sep 2015 14:33:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:913:2c8:148a:1d8e])
        by smtp.gmail.com with ESMTPSA id y5sm5575622pbt.77.2015.09.25.14.33.54
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 25 Sep 2015 14:33:54 -0700 (PDT)
In-Reply-To: <1443216533.8657.8.camel@twopensource.com> (David Turner's
	message of "Fri, 25 Sep 2015 17:28:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278682>

David Turner <dturner@twopensource.com> writes:

>> * Pick 'next', 'jch' and 'pu' as the starting point, attempted to
>
> Do you mean that you merged these branches together, or that you tried
> each of the three?

I tried at least these three (and some other intermediate states)
before giving up.
