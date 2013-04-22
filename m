From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 21:20:48 +0530
Message-ID: <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUJ1h-0001kE-LL
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406Ab3DVPv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:51:29 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:39197 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3DVPv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:51:29 -0400
Received: by mail-ie0-f172.google.com with SMTP id c12so3242483ieb.17
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=BSPwRmIMurRC4py2J38zZ1pyyQE985E+S2ea0C0CKbM=;
        b=iMVK0JH+tmVWZBd0Li6r7iHkQsT2Z7VQeDQTeQnnJTR+paYAhatY1gnC7GtggO3tzx
         dtJwRV8ytXyG8jCmKbCGyc+kbaz6EynIJjy3lsd0yJJomccrM5HW13i802bvP766DDx9
         V2NOPWq5hqKg6vukkNd5rtU/f/6gyDNDKSdYbslS/0Xs7fgS4ZGzO7b1XAlvYphm3zgG
         nx5rpTTl4bdK2m5NRXTKQS7AOGmwYfw7hzwuy3LnFjaPVarRD7NNfcbuFtYXvmsfqzUJ
         Qs8DzA71IFXW8BvUKZ1jVc6HzPHLddVDrJASIr7zaJnOZUdeGEfxYgeDvhcK+mT2CcZq
         EFrg==
X-Received: by 10.50.108.235 with SMTP id hn11mr15129697igb.107.1366645888523;
 Mon, 22 Apr 2013 08:51:28 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 08:50:48 -0700 (PDT)
In-Reply-To: <87wqruk2pj.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222031>

Thomas Rast wrote:
> The only thing that's broken in any of this is that I think, as
> explained on IRC, that a hypothetical fixed --follow -C should be able
> to figure out this case.  By spending extra cycles on analysis,
> naturally.

For the 100th time, nothing has been "copied".  There is no need to
spend time on any analysis.  It's a very straightforward problem that
requires no computation or heuristics: it just requires you to strip
the leading "subproject/" when looking for pathspecs in the M^2
commit^{tree}s.  Done.
