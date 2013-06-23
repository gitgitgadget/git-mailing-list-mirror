From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 04/16] t/t5505-remote: remove dependency on $origin_url
Date: Sun, 23 Jun 2013 13:21:50 +0530
Message-ID: <CALkWK0k4kJi8iXkNHT4CWoXD3eZHwUYk58iVZyOUycXbUd5HjA@mail.gmail.com>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
 <1371813160-4200-5-git-send-email-artagnon@gmail.com> <7v61x7ktcw.fsf@alter.siamese.dyndns.org>
 <CALkWK0mKQnyDXe6AfVzNbh7qOdYbyrVrgt9GMgT2c9u+1jykJg@mail.gmail.com> <7vbo6xkg13.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 23 09:52:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uqf6A-0000vh-L6
	for gcvg-git-2@plane.gmane.org; Sun, 23 Jun 2013 09:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab3FWHwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jun 2013 03:52:31 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:50178 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955Ab3FWHwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jun 2013 03:52:30 -0400
Received: by mail-ie0-f182.google.com with SMTP id s9so22727997iec.27
        for <git@vger.kernel.org>; Sun, 23 Jun 2013 00:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XSbMyKl4thBVZN0HMetqT8Th4TOkZ60jRsAzVf42414=;
        b=WIYnuCfpRPmR3tTvb291A7lktdHNr4F0erCIBMWS6T9KVY6it2AaME70mZQ9HAmn14
         qVNSSpZGGwwiL6LUrORUD12CX7r7g5EC9opKxpSQh8Dfi+x2n+kLfLZI2uUmcL7VzfEv
         l0yJ6IXhJ86P5bZQSNSQxA3rUNMv5vZaN8NdZ7tkgDF7S2Ogmsue3RMs8SnhnJyfoPm8
         /UgLcuGRFXHUfaS/u9lqv8oz7R1f1wqAfnMsoVdhGkCmdXS8vlaD+DmjaLTMf1MvnPLc
         QzL+TWD7eB5iGcCJmpxlUN4dL9vWVJUxS7ebDb7ty2Hx2x5fxR6f1DE5no6oN9Di3fF3
         wE6g==
X-Received: by 10.42.190.74 with SMTP id dh10mr9361198icb.35.1371973950101;
 Sun, 23 Jun 2013 00:52:30 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 23 Jun 2013 00:51:50 -0700 (PDT)
In-Reply-To: <7vbo6xkg13.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228727>

Junio C Hamano wrote:
> I do not think you are creating a quux repository to be pushed into
> and fetched from with this change. Placing 'quux' in the "URL:" field
> feels a lot more misleading to me.  What am I missing?

Dropped.

I'll send in a re-roll based on what you put up on pu.
