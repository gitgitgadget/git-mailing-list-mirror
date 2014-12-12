From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] strbuf.h: drop asciidoc list formatting from API docs
Date: Fri, 12 Dec 2014 14:37:01 -0800
Message-ID: <20141212223701.GD29365@google.com>
References: <20141212212726.GA26284@peff.net>
 <20141212212820.GB27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 23:37:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzYpl-00006k-98
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 23:37:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaLLWhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 17:37:06 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:51256 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbaLLWhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 17:37:05 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so7812369ier.18
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 14:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wf/Yxpd31tzyiUwREAiSABVf68jWWApfILpcSJx81h0=;
        b=Yh+B9PTRMyu4TcHTNz0HnDH69uxzXr+jr6FY7dAaCWekdd6Vu5TatYtumBHeWSpLUt
         YiiaeaWSGcECQG6D/vVbBgAjcg/O4XYWmHp+9ddvUDKRpojg3igzhN0Ul6xB995Bunq+
         wXsAqIK4T38rsEsRbDo6UCEVkXCxcAUc2DAq2tWWufBfSM4vE+/doHvN3TtAneU1Y0K1
         jB6aqtrRoFiEAn//MEpF2NUBvgEgDcze5SZc1XG8iyzFyrbbWx8GxA+BbxHXW3I3812+
         XE5ha7x9ybpXNwuZwvc1m0bszQCVydYGG5RvivnnxwDSvUDogzT9mFsoH0qa5myH9ilX
         NSWA==
X-Received: by 10.107.47.100 with SMTP id j97mr17642818ioo.32.1418423824283;
        Fri, 12 Dec 2014 14:37:04 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2400:9730:c8d1:a786])
        by mx.google.com with ESMTPSA id m15sm1241121iom.44.2014.12.12.14.37.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:37:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141212212820.GB27451@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261387>

Jeff King wrote:

> Using a hanging indent is much more readable. This means we
> won't format as asciidoc anymore, but since we don't have a
> working system for extracting these comments anyway, it's
> probably more important to just make the source readable.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  strbuf.h | 74 ++++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
