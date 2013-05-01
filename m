From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Thu, 2 May 2013 01:25:25 +0530
Message-ID: <CALkWK0=EcKmWm5MTEHO0jXGnLkZ0Hpis__metA7pHOUo+AFJMA@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-4-git-send-email-artagnon@gmail.com> <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
 <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com> <20130501185414.GN24467@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:56:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXd8P-0006Jy-7x
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756897Ab3EAT4I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:56:08 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:46505 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755916Ab3EAT4H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:56:07 -0400
Received: by mail-ia0-f176.google.com with SMTP id l27so1645751iae.21
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7Opx1R3eUEdq0Of30twySffIhjuwbxXsNcR3nmzqQdE=;
        b=tYMwwcwUSJnUBdkZoS1XcWehRomDrn0M/RVYNGNuIe8ZiaVWGSCqhvetNmxJUDU5QI
         /BP3IP3sy6xhHqD9k7iZe0sQ6uyHkCBar8eY0JzuEJ5LTRxO7I/0kuPQbox/qYqThuX+
         gTeTxnLqUVlP6ngBbTU5jv+zFcjfb1UGdyMhM29JcCNkeIa/w/zBNS6pRVXZTSGGOeiC
         mb1vTKNk/aaFEQdi9OZKtXoGwcdBlG5OC8EZfvIaDkGbW5wp4HmFILDdQNKj0KEdB5iS
         NGjwKKVAnsS9rmD3oLA2yMaZa8QNLffflxJTkydmXyNDmM96v+KhT4KG0QgyUqZJvLC7
         uHZQ==
X-Received: by 10.43.125.199 with SMTP id gt7mr2023052icc.48.1367438166065;
 Wed, 01 May 2013 12:56:06 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 12:55:25 -0700 (PDT)
In-Reply-To: <20130501185414.GN24467@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223135>

Jonathan Nieder wrote:
> Since this has been coming up from time to time:
> [...]

Thanks, I didn't know about 'git gui blame'.

I think both comments and commit messages have their uses.  One cannot
do the job of the other.
