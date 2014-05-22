From: David Turner <dturner@twopensource.com>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:07:49 -0400
Organization: Twitter
Message-ID: <1400785669.18134.21.camel@stross>
References: <1400775763.1933.5.camel@stross>
	 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
	 <1400782642.18134.8.camel@stross>
	 <20140522183930.GB1167@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 22 21:08:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYLP-0006ob-BB
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:07:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752671AbaEVTHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:07:54 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:58172 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650AbaEVTHw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:07:52 -0400
Received: by mail-qc0-f172.google.com with SMTP id l6so6366008qcy.17
        for <git@vger.kernel.org>; Thu, 22 May 2014 12:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=FfjpGwyk7s5rcrXu60nyVS8GtnD6UY2FijyGTmahm/k=;
        b=bdgfQnEX0fAID0lEWEbz6esA4zDmxULo9z7XExQXeH9rHbnGRXga2imJ/Sf0GFt85V
         0vDDOFo6IU8t+FVtfPS4VfMjHCiTPWOieW891DaHv0X1Gf10JnqQJJzdWYQvHibEPEtU
         Mqo8fWtdEQsyd47ZffueQz48AnyqE9vOjlX22YtWcIhs6RJYIWTUfmnD7OD7Z4CEZvc9
         GlJjG3Iq5RaETuvxcqyiGOa2X+UjfVcwV6/tiE4CMxi7PnD3DgjjlvqrtKtx0eme7E0g
         4o8+AN0F5kZDco4BvlwNsWjoBylAc2XL81go05epzH07qKG29gCy1JwWB58TpKwg3pWZ
         ABbg==
X-Gm-Message-State: ALoCoQm1CwbWjOVGm66Lg96n11vHEEUIIQJdnRaDUhiEFM/mS0CIjMCfHL4ZFhG/Y9D0aApY2mRG
X-Received: by 10.224.87.132 with SMTP id w4mr17370252qal.89.1400785671335;
        Thu, 22 May 2014 12:07:51 -0700 (PDT)
Received: from [172.17.3.46] ([38.104.173.198])
        by mx.google.com with ESMTPSA id j110sm411500qga.40.2014.05.22.12.07.49
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 12:07:50 -0700 (PDT)
In-Reply-To: <20140522183930.GB1167@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249934>

On Thu, 2014-05-22 at 14:39 -0400, Jeff King wrote:
> does show some improvement. Perhaps "git reset" is not writing out the
> cache-tree extension?
 
Yes, that seems to be exactly what is going on; the two indexes are
identical up to the point where the TREE extension appears.

Thanks for clearing that up!  

Do you think that this is a bug in git reset?

(I'm also going to reply to your other mail because it seems like it
maybe points up some related bug)
