From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] strbuf.h: reorganize api function grouping headers
Date: Fri, 12 Dec 2014 14:46:08 -0800
Message-ID: <20141212224608.GF29365@google.com>
References: <20141212212726.GA26284@peff.net>
 <20141212213235.GD27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:46:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYyX-0006i0-KH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:46:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbaLLWqN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:46:13 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36129 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752349AbaLLWqM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:46:12 -0500
Received: by mail-ig0-f177.google.com with SMTP id z20so2301012igj.16
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=YTltNocA9lkpz+dgczZ8NqtGoastjOQM+DC7tA+EgZY=;
        b=sip7zK3Ll4A6rPPpjf1vu0uxx2f9wezdJtc+fRyQwwIhOUB2Ff0jSyOamsy2quMy/U
         VK0YvEpxV2a/Nlvrqfjr+D3H3pSrwdFV+1dglwJu5OVzC3hKCeW9wsherNcmblZfmv79
         RV8f26KxysHoETTuwMf2IF4/OQRvdzx1FrFHtKfcAweq2ugrQTcsM9Ld3pVDS6NPIlc9
         rOhuig7OAf+VG7oePTUj2ai0EVphCVGsKoG7BIQ74iemfllaGKBU96ICpvCANR6Exoy7
         WDvEeef+5FlkSGp7IeR0vefj6PnVhxKaBvCPEYElGELwSGE4Uu4oqjM9YGh3wCRVBdBY
         VehA==
X-Received: by 10.43.66.9 with SMTP id xo9mr18510840icb.67.1418424371560;
        Fri, 12 Dec 2014 14:46:11 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2400:9730:c8d1:a786])
        by mx.google.com with ESMTPSA id g5sm1264041iod.25.2014.12.12.14.46.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:46:11 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212213235.GD27451@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261389>

Jeff King wrote:

> If you look at the original header file, these groupings actually did
> exist (though we did not remotely follow them as functions were added),
> and looked like:
>
>   /* ---- content related ---- */
>
> I'd be happy with something like that, too, but went with the style that
> matched the "Data Structures" header.

I'd be happy either way too.

>  strbuf.h | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

This is missing the "Adding data to the buffer" section.

Except for that,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
