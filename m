From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] lock_ref_sha1_basic: simplify error code path
Date: Wed, 19 Nov 2014 17:07:14 -0800
Message-ID: <20141120010714.GA6527@google.com>
References: <20141119013532.GA861@peff.net>
 <20141119013739.GC2135@peff.net>
 <20141119020009.GR6527@google.com>
 <20141119020451.GA2734@peff.net>
 <20141119020713.GT6527@google.com>
 <20141119222852.GA12236@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, sahlberg@google.com,
	gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:07:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGDQ-0002xi-4u
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbaKTBHN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:07:13 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:36154 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976AbaKTBHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:07:11 -0500
Received: by mail-ie0-f173.google.com with SMTP id y20so1797061ier.4
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=5+/8kMCp/Wzy830+/McTrvFcYRW+gkXaHUryJIhvoNI=;
        b=q/S9RBielhbIAjIqco/ffIMQ8WoC0/Ur+CAltTxQNuj3J30nq8QkF8tvZTwp5wiBNr
         x8tYUStH/oZP89bZUblc9P3pL1l5qsPVYBTOoPNTLZxvEAI64saB1OK1ur+IkeXzBSgG
         TuYPYdeHOzuUUXD9r9jkN5Jg8b/bTeuT+y2OplvkW45bRkGFAP+pFjezFYY6l6WjCgCh
         nAO8nEJFczx0FAz3lqtyF84iSAD0/GJq9HUiTJ//uKSplkTRywLxvdUG+DNnhQdYdo1j
         S/Y/FVdPnQo+PLeThLv8uoIclTkwMfqtmJcm8fMwbUNEJpHU+9tcWWq3k3iQS0eLKiZ5
         EnZA==
X-Received: by 10.42.137.9 with SMTP id w9mr5618539ict.20.1416445630892;
        Wed, 19 Nov 2014 17:07:10 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id jd6sm755412igb.16.2014.11.19.17.07.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 17:07:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141119222852.GA12236@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  refs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

(modulo the author attribution nit you noticed)
