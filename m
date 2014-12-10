From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] document string_list_clear
Date: Wed, 10 Dec 2014 13:51:54 -0800
Message-ID: <20141210215154.GF16345@google.com>
References: <1417830678-16115-1-git-send-email-sbeller@google.com>
 <20141206020458.GR16345@google.com>
 <xmqq7fy0mx70.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbk4SXEXKzn-V8c4zCQU8m8ub+VkKhmub-bFoLZT1WWpA@mail.gmail.com>
 <20141209201713.GY16345@google.com>
 <20141209202738.GC12001@peff.net>
 <20141209222337.GA16345@google.com>
 <20141210084351.GA29776@peff.net>
 <5488A87C.4030505@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Dec 10 22:52:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XypAv-0000Ky-VL
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 22:52:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933086AbaLJVv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 16:51:58 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56456 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932855AbaLJVv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 16:51:57 -0500
Received: by mail-ie0-f171.google.com with SMTP id rl12so3574514iec.2
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 13:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MO7UmBSIbwM/TGi3VobYll8UXQCm5AevfdeWRuyKz2o=;
        b=y31fhE+O83s68DB9wWiQw2H6rJ3iOa2uKgDeA7G89DMPWOrZhPPuaRKtT+PkUDQ8Vc
         y2eWthRRqLkuIA/YOuX6ra/bp+H8G+QzpqQ70UoVeBzepClPY7+pO4XxOoo8bZbrgCK1
         gvznt5omJHJjuSqrQhfXMrxIc7yoGmEe+3p8ZtbxQWtgQjcUKqTcPsd8yTCFSPhYVOkQ
         W+Uh3zdNgEcMmVlpb3GSayafEw7EbcQCZTrpK2VIeMjMtshQPnKd3ZbPokIvY1xqZfq/
         6I4eeOgXDSITcwGaHwcVYBehVdS8zt8X1NLIr0u57h7nyqrMfVJtz2RQrYPTwMQzQv0q
         DW4Q==
X-Received: by 10.42.25.144 with SMTP id a16mr9015647icc.66.1418248316850;
        Wed, 10 Dec 2014 13:51:56 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:ad0e:8148:e84b:d170])
        by mx.google.com with ESMTPSA id q7sm160642igx.9.2014.12.10.13.51.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Dec 2014 13:51:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <5488A87C.4030505@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261249>

Michael Haggerty wrote:

>                              I would find it a pity for that work to be
> squashed into Documentation/technical/api-*.txt, where in my opinion it
> is less discoverable and more likely to fall into disrepair.

I think we're in violent agreement and keep repeating ourselves.

All I said is that api-strbuf.txt is currently the most readable
documentation of the strbuf API I can find.  The patch to move the
text to strbuf.h looked rough and incomplete.  Therefore I don't think
it's ready to be applied as is.  If you'd like more details about why
I say that, feel free to ask.

Jonathan
