From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] strbuf.h: format asciidoc code blocks as 4-space
 indent
Date: Fri, 12 Dec 2014 14:39:03 -0800
Message-ID: <20141212223903.GE29365@google.com>
References: <20141212212726.GA26284@peff.net>
 <20141212213055.GC27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:39:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYrg-0003Qp-RX
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:39:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbaLLWjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:39:08 -0500
Received: from mail-ig0-f181.google.com ([209.85.213.181]:47569 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752605AbaLLWjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:39:07 -0500
Received: by mail-ig0-f181.google.com with SMTP id l13so2509167iga.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bNyGEoQXmMTNMNX3CU25kAN2kmJ90dc+qEVdgzwWQwk=;
        b=UaOFKBMLFx85gKDHfFbRAXng+WDeP0ipM04YlAmNeXv3EnmGql9gJLki5hl+vgCf6A
         0E+s67bLHBOa4LDlKXmnw09rSavzgzMES3tLLNDbwVvgZBgPYqCvm/oJass+kpEPSQnm
         OwrAd4jOWdmUdqvy7LNYUAADhq3xniJVwMMiltF2v/9oVn2Xbv17FSzvf1Qfq1k2FR4K
         lS6qH+GTZrzotVsz/VMLLKkMC1Xq96KeHUPOvh3rDRWyaIZyjF8DXqjZqLbkK91Qqfaa
         kk1x+vUr2tUguc/yUlkb9CG4n7qz+c+grwtotdBGvYBGWivl3MfJU+Q0TrEuAedODXqd
         6L2Q==
X-Received: by 10.42.26.147 with SMTP id f19mr17474514icc.84.1418423946423;
        Fri, 12 Dec 2014 14:39:06 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2400:9730:c8d1:a786])
        by mx.google.com with ESMTPSA id i3sm1260674iod.19.2014.12.12.14.39.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:39:05 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212213055.GC27451@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261388>

Jeff King wrote:

> This is much easier to read when the whole thing is stuffed
> inside a comment block. And there is precedent for this
> convention in markdown (and just in general ascii text).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

> As a side note, I actually find markdown much more pleasant to read and
> write than asciidoc.

I do, too.  Quoting in asciidoc is a nightmare.

Thanks,
Jonathan
