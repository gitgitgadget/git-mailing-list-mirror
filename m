From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: add show-tracking option
Date: Thu, 16 May 2013 14:54:46 +0700
Message-ID: <CACsJy8BnwFXsXYXPe7driH9q9e4otMuMvr4sJdLQWxhf0owCDA@mail.gmail.com>
References: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 16 09:55:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uct22-0000DH-6m
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 09:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291Ab3EPHzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 03:55:18 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:57659 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957Ab3EPHzR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 03:55:17 -0400
Received: by mail-oa0-f43.google.com with SMTP id o6so3362587oag.30
        for <git@vger.kernel.org>; Thu, 16 May 2013 00:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FXym/GXoGZb8xC3kt+0oXEEvuLCbOSWaJCQ1wXU6lI8=;
        b=BOQN+NYDjHViUxMDRNyDYKGpIOQe9eYu4YJNQN6rJDVNZsX92ZDi887AXerjcomyvt
         Qao3mSHxPrVZl2Go+Tmy/aWxhdEbn6VbO9MHQprE5SzE3xtCOgEsl6RNzqhrKPPqfhpi
         /SnJu3IF+e7pbVkL4yMks5ThNGGJLoGRAosntAfKYy5k08ksGyrnPS1TNpIrC8Wcj1FU
         NRUNpwPLL1X39ADS28Hv7tWYUZa3UwolVlF1snFWgtHhokzS3tuwRj4rQMgXQrPIRqZK
         l1SmfvU8nyd0RpSKm3+D7CuDYip2ETIrLTQ+t58bI1JMBjZMbJKFavNjduOmdCIcwEuE
         1v6g==
X-Received: by 10.182.49.201 with SMTP id w9mr6580397obn.38.1368690916520;
 Thu, 16 May 2013 00:55:16 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Thu, 16 May 2013 00:54:46 -0700 (PDT)
In-Reply-To: <1368690532-12093-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224491>

On Thu, May 16, 2013 at 2:48 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Showing the tracking information for all the branches takes significant
> amount of time. The user might not want that. The --no-show-tracking
> option allows that.

Or we could cache the information somewhere in .git. If a ref still
points to <SHA-1> as recorded in the cache, use the cached tracking
information, otherwise go the slow way.
--
Duy
