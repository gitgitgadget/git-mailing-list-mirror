From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/3] rev-parse and "--"
Date: Mon, 9 Dec 2013 11:23:34 -0800
Message-ID: <20131209192334.GT29959@google.com>
References: <20131206211222.GB20482@sigill.intra.peff.net>
 <20131206211509.GB20536@sigill.intra.peff.net>
 <20131206220520.GA30652@sigill.intra.peff.net>
 <xmqqmwk9zvyy.fsf@gitster.dls.corp.google.com>
 <20131209191224.GR29959@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 09 20:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq6Qi-0004nJ-5T
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 20:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760252Ab3LITXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 14:23:40 -0500
Received: from mail-yh0-f41.google.com ([209.85.213.41]:52735 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756015Ab3LITXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 14:23:39 -0500
Received: by mail-yh0-f41.google.com with SMTP id f11so3087831yha.0
        for <git@vger.kernel.org>; Mon, 09 Dec 2013 11:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=GjS83aKw6BzMV6AeJxg7TZ+BBAnBxcabYswHhQMoixM=;
        b=WGs0Q4htKZI7Mhft4MVgElO3sdwfOhDsUui1VhaO4pihwHJwdsnrhf45vvIpnC0iup
         eXuSihUIfdoTwYeTAdDQO9JdzGeFL/IQjkQY/761g7NjImjz/MlO9k5vFV2Q6XLMHWOP
         ROzPG0Vp3OuQV/Oqi3evQIw4aPSUp/mEScAvBj2YwwPnwmOslpJH8PVVSun2WI0/HLs3
         8NWFRfpEiCtWaW7QLjqtp6Q7o6H3H3LLfohqT+CkAEjJnVUmhYxOTYYh9nA/0vL6iu41
         e1pCDoF+Qe7YiR2dUGKz3ehfOG0IJVKobpno1mul78aID2yCmRFnN9DVTRZYhwlAa0uv
         daaw==
X-Received: by 10.236.122.165 with SMTP id t25mr16601830yhh.46.1386617017524;
        Mon, 09 Dec 2013 11:23:37 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id e39sm18056105yhq.15.2013.12.09.11.23.36
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 09 Dec 2013 11:23:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131209191224.GR29959@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239082>

Jonathan Nieder wrote:

> Isn't this essentially breaking a contract

To clarify, if there were some strong motivation --- e.g.  if this
were resolving some security problem --- then I would be all for
breaking compatibility in this way.  What's confusing to me is that I
just don't see the motivation.  Why wouldn't someone that wants this
functionality be able to pass a flag for it?

Is the idea that without a flag it's easier to teach or something?

Hoping that clarifies,
Jonathan
