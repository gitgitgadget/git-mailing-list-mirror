From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/14] lockfile: introduce flag for locks outside .git
Date: Wed, 3 Dec 2014 15:41:05 -0800
Message-ID: <20141203234105.GK6527@google.com>
References: <20141117233525.GC4336@google.com>
 <CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
 <20141118004841.GE4336@google.com>
 <CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
 <20141203050217.GJ6527@google.com>
 <20141203051911.GP6527@google.com>
 <xmqqvblsuy2e.fsf@gitster.dls.corp.google.com>
 <xmqqr3wguxhv.fsf@gitster.dls.corp.google.com>
 <20141203232951.GJ6527@google.com>
 <xmqqmw74uwx0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:41:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJXm-0000V5-Nf
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:41:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554AbaLCXlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:41:10 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:48053 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbaLCXlI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 18:41:08 -0500
Received: by mail-ig0-f182.google.com with SMTP id hn15so13704903igb.15
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 15:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=sC2B2892i9/SaDHxvIIFomCq2QK0YDkQaHgEpomNLDs=;
        b=M+olJiUvFK5Npx/GTdC6dUldOowNr6F3TFeJ5cy0ULCCcq5SVKrmAz+BHMMReZXyEu
         Yi990m6RPzRDqW+fD6L5RPdUaFVPqoSIQ8VnwVIynpOM5eGsyeYu6rjVEYiUUxDZQsqT
         YsTcXFi27jiWmfP00gLPGBalYREOY5dFcEeay8PSpPWG6VgIpBaQH8L7XknYPmTxbJPJ
         /ILJvxPzwmpAPFxBbPI19ArkJvMdL3VTrr3/hd9ATzV7Vj+JjlBLKJWC9ndUqMCCYNio
         yZXrHLNHC7I2ts6n1aLtfbnssZaLo0SxwDJsZx0vmJZS0RP/whHnM2pNdp1F645vStlQ
         zf6w==
X-Received: by 10.42.210.5 with SMTP id gi5mr9234233icb.58.1417650067860;
        Wed, 03 Dec 2014 15:41:07 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:c1ad:3fe5:3da3:c161])
        by mx.google.com with ESMTPSA id r12sm13492074ioe.43.2014.12.03.15.41.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 03 Dec 2014 15:41:07 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <xmqqmw74uwx0.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260713>

Junio C Hamano wrote:

> I was under the impression that the purpose of the series was to
> propose an API update to be used together with the remainder of the
> system, not just "update code in master, breaking unstated set of
> topics and leaving them behind without updating them for now".

Got it --- before the reroll I will try a test-merge against 'next'
and 'pu' (and likewise when sending future patches).
