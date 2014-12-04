From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] doc: document error handling functions and
 conventions (Re: [PATCH 03/14] copy_fd: pass error message back through a
 strbuf)
Date: Thu, 4 Dec 2014 15:41:47 -0800
Message-ID: <20141204234147.GF16345@google.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
 <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051344.GM6527@google.com>
 <xmqqzjb4h823.fsf@gitster.dls.corp.google.com>
 <20141204030133.GA16345@google.com>
 <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 00:41:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwg1y-0004Hi-EZ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 00:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933429AbaLDXlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 18:41:50 -0500
Received: from mail-ie0-f169.google.com ([209.85.223.169]:46351 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933424AbaLDXlu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 18:41:50 -0500
Received: by mail-ie0-f169.google.com with SMTP id y20so16905999ier.14
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lAsT88Ay4Ltl/yjlIHO8XcHDLczR4ZMCjY6l33eFy2w=;
        b=cC710tp3d4+AI8qovgX0X5rnr71h7lNyacIzsg6CgmPffYs9yMBho6xN+3oe/e0ofF
         Y1lM0I0KV7iGeNnOlETRuRtS0fbI6WZ7BwvSFmRlwUphhFA/Ou+1pCXF3xLZYkKUWIbT
         cL2bjwL8t9XdCSCx/3t2cCxUUoKlNsxCo0pLYegJu1vSzB/5Gh/xt0B3oOpjbaNO+9q4
         oEl9/UFsFAh9SKQcmL6VfgJwWDzbEWMSjTTeHkmdFXFGgDt7nf+Ii/0suObuWevLrU70
         Wv+JtOIneFqT7aGrJTUzW18GOaDmJL0qTFIneXnLwESy7cuPU+7Yu5TsS2aTMcfaVuvR
         vQpA==
X-Received: by 10.107.160.69 with SMTP id j66mr12593818ioe.6.1417736509585;
        Thu, 04 Dec 2014 15:41:49 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:5da0:cb9e:66b:e537])
        by mx.google.com with ESMTPSA id 126sm4033016ion.12.2014.12.04.15.41.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 04 Dec 2014 15:41:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqy4qnq9m2.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260839>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Here's a draft for documentation on that.
>
> Thanks; looks reasonable; even if the discussion between you and
> Peff took us to a slightly different direction than what you
> described here, the earlier description of long established practice
> is a welcome addition.

I think I see what I misunderstood.  Do you mean "even if we settle on
a different API, this documentation of what you started with should be
easy to adapt and will make life easier"?

In other words, did you mean to say that things are still up in the
air (which I agree with) or that the project has already settled on a
different direction (which I do not)?

Sorry for the confusion,
Jonathan
