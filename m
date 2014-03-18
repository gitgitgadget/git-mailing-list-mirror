From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] gc --aggressive: three phase repacking
Date: Tue, 18 Mar 2014 13:19:54 +0700
Message-ID: <CACsJy8BhqiZcJY2=VWzu=ENGbbigWAQXQh3fYxLEtUxDd=8Z+Q@mail.gmail.com>
References: <1394976904-15395-1-git-send-email-pclouds@gmail.com>
 <1394976904-15395-6-git-send-email-pclouds@gmail.com> <20140318045050.GB8240@sigill.intra.peff.net>
 <20140318050727.GA14769@sigill.intra.peff.net> <CACsJy8DZsH_2CpaUUpc5xyunHD42CN24m6Mb+9vsKyaRqJ6q3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 18 07:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPnO3-0005fs-R9
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 07:20:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbaCRGU0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 02:20:26 -0400
Received: from mail-qa0-f45.google.com ([209.85.216.45]:51584 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864AbaCRGUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 02:20:25 -0400
Received: by mail-qa0-f45.google.com with SMTP id hw13so6423113qab.18
        for <git@vger.kernel.org>; Mon, 17 Mar 2014 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=K5nzKIq6r2VA0DO3w30vzyYVL7XFB+MKoAaR6xTPAds=;
        b=vzuPGQ+k7Ssea1D+PTDwsPdOfE3QF86skvoeXXXKOQxAeBgP7nYBaycMrnvKL/cwBz
         sVQn3tVe1Y8/Q2P2VP+8mjr2+wZHcMhk9fdm9JoIUbADcsl2M4eYKAVSvhzNV8+xesZS
         pEShvGCKbqA47JCX7Kq0jAVC3FA35DzHy6pEegYrbNdCgpaujJNEvPXKiRtU+ji/sq4S
         jwspEcs7441I2rL2QnST+oKgFNQb0TlqjcesE06M8u4SAlsINk9ivEkv/pxSmwbb6SB3
         0XMCLT9tkCjUzkyRwCoGojtsQbgRXH/uAhQHQAd4ZML+2vJqx2Lbn7Gyl9gPM1n9iT+B
         emVA==
X-Received: by 10.140.41.134 with SMTP id z6mr26356qgz.112.1395123624776; Mon,
 17 Mar 2014 23:20:24 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Mon, 17 Mar 2014 23:19:54 -0700 (PDT)
In-Reply-To: <CACsJy8DZsH_2CpaUUpc5xyunHD42CN24m6Mb+9vsKyaRqJ6q3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244336>

On Tue, Mar 18, 2014 at 12:16 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> But I think it's orthogonal to gc --aggressive improvement.

There's another reason that improving gc may be a good idea (or not).
It depends on how other git implementations handle long delta chains.
If they hate long delta chains like current git too, then more reason
to make gc less aggressive.
-- 
Duy
