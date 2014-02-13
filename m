From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Thu, 13 Feb 2014 08:22:50 +0700
Message-ID: <CACsJy8Do0CRhhC+YvXSmihczOMDT9UpA4a4mEQ1z5MbR3TSXRw@mail.gmail.com>
References: <20140210191521.GA3112@sigill.intra.peff.net> <20140210212931.GA16154@sigill.intra.peff.net>
 <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com> <20140211200445.GA27946@sigill.intra.peff.net>
 <xmqq61oknoak.fsf@gitster.dls.corp.google.com> <20140212221258.GB6799@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 13 02:23:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDl1S-0002fL-AK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 02:23:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbaBMBXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 20:23:22 -0500
Received: from mail-qa0-f51.google.com ([209.85.216.51]:44075 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaBMBXV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 20:23:21 -0500
Received: by mail-qa0-f51.google.com with SMTP id f11so15037950qae.24
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 17:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UIAFW/itiOhDS1UpENhkEeKisRSQvBNZUbfn9mPgMpg=;
        b=O7T8E75Em7AXYwGKSrf8q+HxinaccadAnqWbx++psABGs5ioxFklfGDdSdUjh9cpH4
         uOHLv6L/XdP50K1YP0zqoRVOK0IUFctcLRV/VRqOC28eMvUtRemIHzupjGV44wWgau8T
         K0MtcayZaOJBAfZ0FVJfV9THH2sIKVK1ZvopYNedb8KQuGWH+gTPb78XBVV4MTsw01B4
         lldQiVNc4DUesuhCcQzI6kRKvsrsxZtWHykMQG91hxhdestx4tKExR4eBFdAYmZATimC
         /o4TIcwvzdXHt4wcW63xK2uWL5nfkqO5/LooVbl/wRjO7iqG2pYKT0qlOAzeEcJQTxbJ
         hkuA==
X-Received: by 10.140.40.5 with SMTP id w5mr69062476qgw.65.1392254600918; Wed,
 12 Feb 2014 17:23:20 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 12 Feb 2014 17:22:50 -0800 (PST)
In-Reply-To: <20140212221258.GB6799@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242038>

On Thu, Feb 13, 2014 at 5:12 AM, Jeff King <peff@peff.net> wrote:
> lib-httpd was never designed to be included from anywhere except the
> beginning of the file. But that wouldn't be right for t5537, because it
> wants to run some of the tests, even if apache setup fails. The right
> way to do it is probably to have lib-httpd do all of its work in a lazy
> prereq. I don't know how clunky that will end up, though; it might be
> simpler to just move the shallow http test into one of the http-fetch
> scripts.

I'll move it out later.
-- 
Duy
