From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/14] copy_fd: pass error message back through a strbuf
Date: Wed, 3 Dec 2014 12:18:08 -0800
Message-ID: <20141203201808.GA6527@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:18:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGNN-0002IA-EJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781AbaLCUSN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:18:13 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:50085 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751390AbaLCUSN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:18:13 -0500
Received: by mail-ig0-f173.google.com with SMTP id r2so17528290igi.0
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=7+SbzjB0AfXtkR8MGs9QXT30i4yDL9wg5ZCI10YG6jM=;
        b=MTiiHt0XVKBcDeXuxWZVeizQrhsVvJZ1k0C9YJ21h5PrwBQJvwa8Jb92yaGR6Q4k7y
         ydMjo81tL/ea+rVcqRCqiynrUR/WCJvVOQoOrnSmpodx0R9LBSIT7yJSCiQWoEuI6lfZ
         8cZc1E+pcLvGLcoEDDbhVrMGTzFXhHq/lbWUP5a9cwHOSKVjxGpkCd94BOTWDmwdrsRw
         BHn7pZoekX31fNcWB4kHW7e7XWxSKzY1mYd2vyB9tDl5X2y+BGklegsPE0dl5ZnuLDh2
         m7j1vGq5WWc87VaZw7OZ7cBWYvssl+lR2P3IkgVVuykQj4CsCnJM63qg9MIIG04gi467
         81YQ==
X-Received: by 10.50.3.67 with SMTP id a3mr58162480iga.42.1417637892509;
        Wed, 03 Dec 2014 12:18:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:fd7b:507b:3c7b:554e])
        by mx.google.com with ESMTPSA id j2sm14101256igj.14.2014.12.03.12.18.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 12:18:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqr3wgh57t.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260687>

Junio C Hamano wrote:

> By the way, this seems to address the same thing as sb/copy-fd-errno
> topic that has been cooking in 'pu'?  Should we drop that other
> topic and use this one instead?

Yes, please.

I'll give it an hour or two to collect more comments and then send a
reroll reflecting them.

Thanks,
Jonathan
