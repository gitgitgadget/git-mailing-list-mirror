From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] commit: correct advice about aborting a cherry-pick
Date: Sat, 27 Jul 2013 02:57:00 +0530
Message-ID: <CALkWK0mC0Zcxnq9c-SQc0zURs1Lu1PfL988vdw=Crvb4C7+Ctw@mail.gmail.com>
References: <1374862320-22637-1-git-send-email-artagnon@gmail.com>
 <20130726191631.GD29799@sigill.intra.peff.net> <CALkWK0=qYF=r+Ocb1Z1E=Oteau=AAXR7wnKakt-8Cejwz6Usrg@mail.gmail.com>
 <20130726212438.GA1388@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 26 23:28:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2pYJ-0000IA-6W
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 23:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847Ab3GZV1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 17:27:43 -0400
Received: from mail-oa0-f47.google.com ([209.85.219.47]:39879 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932662Ab3GZV1k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 17:27:40 -0400
Received: by mail-oa0-f47.google.com with SMTP id m6so1758581oag.20
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 14:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qRZValzvDhMb64grly8ZNPY3CGjwYi7h7UBnOo5L4ik=;
        b=s69kNaCGMrfec6sFFnnGt7cXTm0+9U/g7wYfxiARRiT/vYVkRrTTolBr235MToRnIO
         s12litjt90HlXu8UTX8WNtMxbDdToo+jtD/q0/0MKeFMb1gYNprzmi63vY71V2wrVPrU
         KQX7eEzbZyfg/EdrTIpr1Xc0J5x+FpN4UO7oF+B/xnsOhkXoBgRY7nK8KxfSuKAuj23R
         G9oL08/VtMdZqZFx2kEIpvtwvHIOeAq+FjbjQci/DFMv11O9VFktb0WdD/CPq5pScXX8
         VzRPvJXR4XEgvmKaocrVn4Zch2re4isiDixMLRYdi7lA/8ycl383ZjV2o8E9xM3LV1aX
         YakQ==
X-Received: by 10.50.47.12 with SMTP id z12mr44576igm.50.1374874060264; Fri,
 26 Jul 2013 14:27:40 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Fri, 26 Jul 2013 14:27:00 -0700 (PDT)
In-Reply-To: <20130726212438.GA1388@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231206>

Jeff King wrote:
> Ah. I don't mind improving the message in the meantime, but it sounds
> like this is a deficiency in sequenced cherry-pick that needs addressed
> eventually.

I'm especially irked by how slow rebase--am is, and want to replace it.
