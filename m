From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Tue, 9 Dec 2014 14:23:37 -0800
Message-ID: <20141209222337.GA16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 09 23:23:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyTC4-0003JL-UQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Dec 2014 23:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753291AbaLIWXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2014 17:23:41 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:33901 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792AbaLIWXk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2014 17:23:40 -0500
Received: by mail-ie0-f177.google.com with SMTP id rd18so1510902iec.22
        for <git@vger.kernel.org>; Tue, 09 Dec 2014 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=KtFr3G21lggZeJikHCDikY3EbPCY9UiPcwsB0hBtrcY=;
        b=ZZ01YviWj6Au/hXKN3zxz+N3g6DBKJ84c3YrqBHjDVEOle0cryTqDRR/l0Kn+xjNfZ
         jL59qnIhbZduLUIWqdLmWdhkt/niIeikdFhsPvLTT793WCTWu/pOvaa9HTACIlirNbgl
         CK3//7hMN5PA6w3JcPXWAO+VfAmK0MSWV3ygky9UcKUdOj17QNHkKdg3roGYEw6OCKbI
         Byn2GKhsVnizerCsgBYDhLIjwY3Lc+x2lUo/096b63eB/3UaER5MNYtsdEUvMHHJNtmB
         E4eWTVYIDIEpM8+Hg8n+FUp5pMmfciwO6Lo7hb7QtXlyyTaw/41PYbIlIy/qnBn7D025
         Xhtw==
X-Received: by 10.43.66.9 with SMTP id xo9mr4049054icb.67.1418163820018;
        Tue, 09 Dec 2014 14:23:40 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:a4ec:4fac:afb2:e506])
        by mx.google.com with ESMTPSA id 6sm1547680igk.11.2014.12.09.14.23.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Dec 2014 14:23:39 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141209202738.GC12001@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261170>

Jeff King wrote:

> Elsewhere I mentioned a tool to extract comments and format them. But do
> people actually care about the formatting step?

If formatting means "convert to a straightforward text document that I
can read through", then I do.

>                                                 Does anybody asciidoc
> the technical/api-* files? We did not even support building them until
> sometime in 2012. Personally, I only ever view them as text.

I also view them as text.  I tend to find it easier to read the
technical/api-* files than headers.  That might be for the same reason
that some other people prefer header files --- a
Documentation/technical/ file tends to be written in one chunk
together and ends up saying exactly what I need to know about the
calling sequence in a coherent way, while header files tend to evolve
over time to match the implementation without maintaining that
organization and usability.

I suspect a simple tool to extract the comments and produce something
like the technical/api-* files would help, since then when someone
writes a patch, they could try the tool and see if the result is still
easy to read.

Anyway, the patch I wrote was an attempt at a minimal fix (and an
attempt at getting out of a conversation that seemed to be moving
toward bikeshedding).  If someone wants to move the documentation from
api-strbuf.txt to strbuf.h, I won't object, since I hope that a simple
tool like described above isn't too far away.

Thanks,
Jonathan
