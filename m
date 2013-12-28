From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/3] t0000: drop "known breakage" test
Date: Sat, 28 Dec 2013 12:51:04 -0800
Message-ID: <20131228205104.GA5544@google.com>
References: <20131228092731.GA26337@sigill.intra.peff.net>
 <20131228093340.GC21109@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Thomas Rast <tr@thomasrast.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 28 21:51:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vx0r9-0000ar-SY
	for gcvg-git-2@plane.gmane.org; Sat, 28 Dec 2013 21:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750818Ab3L1UvN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Dec 2013 15:51:13 -0500
Received: from mail-yh0-f44.google.com ([209.85.213.44]:32931 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab3L1UvM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Dec 2013 15:51:12 -0500
Received: by mail-yh0-f44.google.com with SMTP id f64so2158925yha.3
        for <git@vger.kernel.org>; Sat, 28 Dec 2013 12:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/+NLyxzFQ63AfGElKQmWnJ+GBFPYkfHtoVHuLSNJSS4=;
        b=pDgYGs9XTd/B4X/aZ9Crl174bmsH6BvAEaFXosNJuoUBQL6hOS6ZExd9IlJ5CZrh/K
         wdussbO5FoZXbV4Af5hhnS2K6LHNATmiQdsrXmKUqW8uaIpETHQuORq8C+HtyIjITdDq
         Q+cHAsLkL4zCyvvSrhKKwD6pBf/UgFQMdUIqjoEHs+X6Og1uL3J9QVEvEXceMz3yhlSp
         Av2XSIoOXrU3xceTziVuTFsxRJMBSEyIo823QajDjbDp/Zj289/MIaKrJ3UuT6IgXUA7
         om9xeyiF9rUd8WYyz1IMwnHiRG0VPtaIjff7pEELhM56dv+qfEdW2zNWLDd5JWOZf88K
         ePcQ==
X-Received: by 10.236.44.102 with SMTP id m66mr2946449yhb.89.1388263872030;
        Sat, 28 Dec 2013 12:51:12 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id 9sm53156536yhe.21.2013.12.28.12.51.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 28 Dec 2013 12:51:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131228093340.GC21109@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239788>

Jeff King wrote:

> I am not _that_ bothered by the "known breakage", but AFAICT there is
> zero benefit to keeping this redundant test.

Devil's advocate: it ensures that anyone wrapping git's tests (like
the old smoketest infrastructure experiment) is able to handle an
expected failure.

But in practice I don't mind the behavior before or after this patch.
If the test harness is that broken, we'll know.  And people writing
code that wraps git's tests can write their own custom sanity-checks.
