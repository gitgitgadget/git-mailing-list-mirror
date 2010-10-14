From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/3] push: pass --progress down to git-pack-objects
Date: Thu, 14 Oct 2010 08:59:41 +0800
Message-ID: <AANLkTikUne3NmDMEsq07oN+4pr9APQJFKhF-FKLmSUbh@mail.gmail.com>
References: <1286998311-5112-1-git-send-email-rctay89@gmail.com>
	<1286998311-5112-2-git-send-email-rctay89@gmail.com>
	<1286998311-5112-3-git-send-email-rctay89@gmail.com>
	<1286998311-5112-4-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 14 03:00:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6CAp-0003C7-P1
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 03:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab0JNA7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 20:59:44 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56271 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754029Ab0JNA7n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 20:59:43 -0400
Received: by ewy20 with SMTP id 20so2813159ewy.19
        for <git@vger.kernel.org>; Wed, 13 Oct 2010 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=bAy49EqKBgSoLCrbX6E7gYN+vknwEjrUcQU/2P5Go4A=;
        b=uo2376xMt1L9Etlvc+5LUdG6qmVtG3k3l4Y6WVzvM3Z/m/NaIkqj3hrUA+racF9aur
         BclWWmxhFTr3j5b8qG8AjhuVy9KDFFZspp8UbOA1J6FbBKXQQOVELXgn4XMBHypf66XC
         VarNr0EA9BjXQ3ir82EEdHJRYg/rZgaaIOD3c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Oyp8kpt0o/Cupmp2gvEm2tglSAJKc0YZye4KM3wSNw/F1gVRD2wAGfBXn3P+XVTdzH
         rGt+lvwIe3EehGKzjzMBfqM5so8JOp9lUZFIC68YQCoM0wrclPbAf7ZJ/DXgyf1K91yL
         XT+DuRVUO30Km/2f1kRnZRrDPlIsu3//XBjqw=
Received: by 10.213.14.70 with SMTP id f6mr583417eba.7.1287017981763; Wed, 13
 Oct 2010 17:59:41 -0700 (PDT)
Received: by 10.213.33.197 with HTTP; Wed, 13 Oct 2010 17:59:41 -0700 (PDT)
In-Reply-To: <1286998311-5112-4-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159010>

Hi,

On Thu, Oct 14, 2010 at 3:31 AM, Tay Ray Chuan <rctay89@gmail.com> wrote:
> From: Jeff King <peff@peff.net>
>
> [snip]
>
> Reported-by: Chase Brammer <cbrammer@gmail.com>
> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Chase, I switched the authorship to Jeff - after all, he was the one
who wrote the patch. I hope you're fine with that.

Jeff, if this patch is ok, since you're the author, perhaps you might
want to add your SOB?

-- 
Cheers,
Ray Chuan
