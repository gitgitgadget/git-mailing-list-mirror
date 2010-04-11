From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Take it easy on unallowed access to non-existent 
	repository
Date: Sun, 11 Apr 2010 19:52:53 +0200
Message-ID: <u2ifabb9a1e1004111052s12949555wa063f214d742e5ec@mail.gmail.com>
References: <20100409001322.GB23501@coredump.intra.peff.net> 
	<1270983682-12215-1-git-send-email-pclouds@gmail.com> <l2ifabb9a1e1004110845l7cc89b70y9878dad9e1537e8d@mail.gmail.com> 
	<y2tfcaeb9bf1004111049m9703af3bs3dc668ec29ae3136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:53:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11LV-0000Ko-Nt
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752676Ab0DKRxQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:53:16 -0400
Received: from mail-yx0-f171.google.com ([209.85.210.171]:64497 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab0DKRxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:53:16 -0400
Received: by yxe1 with SMTP id 1so2170604yxe.33
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=7FvrMTfoDIMTRHuTV+VkdLL5jMIZEMMeOMmjNhWPODk=;
        b=g033LLQwHM0S1mAoFdxQ471AXpH5Rvl/H/kLcUu0oFoj6ua3t1P2D69ofxv7nvJh4H
         1PR8MjRH/JQuoFOWkT0szOp3junx8CO4hm+v+BQ1EaHQ9nuCqP82kfvJt4wxVOAQiUge
         hLnA+uK9JSfqk6BBaXYnYXFnL8UYqiryZU72U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=lR0HHutG5xbgKm5JKJHAkBn867kZ0NUpV7BoEu1U7PtZqiU5J2vZ5z5IdZFzsXMbI7
         pFWx+r6u/fOKexBowIWK2Ip0QZJeCTWEFDTVp4szl93uo/im8VSNh+M56TtJ9LFBkZg5
         c9z/B69OJONGmGMyOA24Oqwd2gYYNmNse4wZk=
Received: by 10.100.206.13 with HTTP; Sun, 11 Apr 2010 10:52:53 -0700 (PDT)
In-Reply-To: <y2tfcaeb9bf1004111049m9703af3bs3dc668ec29ae3136@mail.gmail.com>
Received: by 10.100.56.9 with SMTP id e9mr5022290ana.138.1271008393850; Sun, 
	11 Apr 2010 10:53:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144669>

Heya,

On Sun, Apr 11, 2010 at 19:49, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Gaah.. from a user point of view, correct. What do you suggest?

Simple, add a reference to the "code":

warning("broken repository setup code: early access to $GIT_DIR/config");

-- 
Cheers,

Sverre Rabbelier
