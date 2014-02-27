From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4] tag: support --sort=<spec>
Date: Thu, 27 Feb 2014 20:23:17 +0700
Message-ID: <CACsJy8DZH_Bi3UCNuGTA4K47Qp=h+52kPxcuRDjFt19je3DWqw@mail.gmail.com>
References: <1393330935-22229-1-git-send-email-pclouds@gmail.com>
 <1393505812-7171-1-git-send-email-pclouds@gmail.com> <20140227131100.GA22783@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 27 14:23:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJ0wL-0007sy-1e
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 14:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbaB0NXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Feb 2014 08:23:49 -0500
Received: from mail-qc0-f177.google.com ([209.85.216.177]:65075 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbaB0NXs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Feb 2014 08:23:48 -0500
Received: by mail-qc0-f177.google.com with SMTP id m20so3145060qcx.22
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 05:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XrOZS45yhUtku7byMrnAKujLlLTMi2IIaUYzdI2TwvU=;
        b=g0bf099Ov9F5NtS3dPiAu2P50CKRFJ80tN41EhoB7oo7oY76vIGYYXPGdhNYa3Btmm
         sYsqaZXm3ZhVo46ee6T98ghm5cUGpZTFPi7UOZEWhD5RWURlie1AzslLeKS5pRqiOYGw
         ofBGgj911I7rvokAY7Pir2JAQzao4TtvE1Z3WU65r66xplSj9gBzlTnvP3qVLMy8HPZs
         nB3gqkrlTtTruHKlLS7jqWr24RXshXEi33WAH6zB/mzBGWpe9wDlOF2ikCEi6lfGl9ZW
         S3mGor/x1hXgdehE7AFLNeuDgSnKZ3whIQr5ZYpvQBZYrnivs6HSYc7UFPKojmEe0LDV
         3DMA==
X-Received: by 10.140.40.5 with SMTP id w5mr6867068qgw.65.1393507427889; Thu,
 27 Feb 2014 05:23:47 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 27 Feb 2014 05:23:17 -0800 (PST)
In-Reply-To: <20140227131100.GA22783@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242822>

On Thu, Feb 27, 2014 at 8:11 PM, Jeff King <peff@peff.net> wrote:
> You had mentioned earlier tweaking the version comparison to handle
> things like -rc better. I think that can come on top of this initial
> patch, but we should probably figure out the final sort order before
> including this in a release.

Yeah I have been thinking about it too. That's why I did not send the
reroll "shortly" as I said. So far I like the idea of using config
file to specify -rc and the like. If XX is in the configured list and
it's the last component in the version string, then reorder it. Seems
to work well with different versioning schemes listed at
http://en.wikipedia.org/wiki/Software_versioning.
-- 
Duy
