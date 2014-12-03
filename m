From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 13:51:26 -0800
Message-ID: <20141203215125.GE6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
 <20141203201808.GA6527@google.com>
 <xmqqiohswgsq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 22:51:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwHpe-0006N3-0s
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 22:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbaLCVva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 16:51:30 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:54635 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270AbaLCVv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 16:51:29 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so14777016iec.11
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 13:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a1I3GqUwZkfeB6uZD5tLz8dLD1kqkMPdguN+1h1vndw=;
        b=OuR8YKxKlsqtECUWpkBYyoLEuztSdBX1TCIIcVE5NjVvqXKpCzw8IRDOvkwcqVjNG5
         W3jxoY+4oNLpatqYAKt11aEl2ZDvfzW6YQqlpXVsr7wVhse9ZX9Kl9thehq6k2CYEQ7A
         Tg21q6jYlyQqHTCx8C5zpQhsKE7mh+VOrt+mU7/gpn6xaYN6wjdvMM1hG4UMZ0ziYmO1
         29Zi0LFhqnKgjP1ZKs5DU8rrtOwtelZq+tcIHjEfOsg+EaqwL1PEUKjLUA9Tr/INqGhP
         tBrapOSntwGG19OaMLacgC1wF8q67Xeh9Yyn4p+hg4IhKq/6YDlkEbC/5OsEI91d0bi8
         /zew==
X-Received: by 10.50.7.38 with SMTP id g6mr10612675iga.42.1417643489269;
        Wed, 03 Dec 2014 13:51:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id i184sm13353970ioi.33.2014.12.03.13.51.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 13:51:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqiohswgsq.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260698>

Junio C Hamano wrote:
> Jonathan Nieder writes:
>> Junio C Hamano wrote:

>>> By the way, this seems to address the same thing as sb/copy-fd-errno
>>> topic that has been cooking in 'pu'?  Should we drop that other
>>> topic and use this one instead?
>>
>> Yes, please.
>
> OK.
>
> It felt strange that two people in a same office stomping on each
> other's toes

I just did a bad job of explaining the context in the cover letter.

I wrote this series at Stefan's request (see the message that the
cover letter is a response to for context[1]).

Hope that helps,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/259695/focus=259710
and http://thread.gmane.org/gmane.comp.version-control.git/259695/focus=259703
