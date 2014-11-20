From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for
 ref_transaction_update
Date: Wed, 19 Nov 2014 17:37:55 -0800
Message-ID: <20141120013755.GD6527@google.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
 <1416433224-29763-2-git-send-email-sbeller@google.com>
 <20141120011038.GB6527@google.com>
 <CAGZ79kaW3xGjepcXFZYYUTuDqbEixVA4rH-FMcG0hyEoCVqizQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:38:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGhD-0004LH-9W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:38:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487AbaKTBhy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:37:54 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:54779 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbaKTBhx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:37:53 -0500
Received: by mail-ig0-f180.google.com with SMTP id h15so2026692igd.13
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=WhUlYK/lXPzbZcQP3NNzkDqBqZfqebxByI1bayKnLLg=;
        b=S84jM/sVOzZZPBa0q5fQD8WHc5hOcQ2EuWV8hGuy9r9QIrRjbVUNX3Mmku7ckMc4RK
         20d/P2QF4rkQbFv/UPyg0JA3yZ+zMACXYDHuNxmGM5pCO0m5wLn4egTHY2eusXF3jXmh
         wQzNKI7q02iYsu6KTevtimpYdyoG7YXuetpzoKvsCPCTGxNXuCskTua5j5ImXmxksbLI
         Tdn+YUG7fa68CyQA9ChtkCH6qXBKSF4UYx3Gfn95QVCilS/12PrHgtuGsrIiWyrX1FKz
         tDFt+m2+mHVu7sbd0qd9loGsplUdBCLHeN98ahexDAEr98JTuighlMRa7EuxU941BRSl
         OmTQ==
X-Received: by 10.50.79.166 with SMTP id k6mr13550817igx.0.1416447473015;
        Wed, 19 Nov 2014 17:37:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:31da:72d3:8c17:80bd])
        by mx.google.com with ESMTPSA id au2sm1769379igc.4.2014.11.19.17.37.51
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 17:37:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kaW3xGjepcXFZYYUTuDqbEixVA4rH-FMcG0hyEoCVqizQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(administrivia: please don't top-post)
Stefan Beller wrote:
> On Wed, Nov 19, 2014 at 5:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> I feel a bit ashamed to have my sign-off peppering all these patches
>> that I didn't have anything to do with except preparing to send them
>> to the list once or twice.  I'd be happier if my sign-off weren't
>> there.
>
> I am sorry for not having asked before.

Don't worry too much about it --- you were starting from commits that
already had my name there.

I was just mentioning my preference for the future (since there are a
lot of these patches).
