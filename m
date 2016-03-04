From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Change in .gitignore handling: intended or bug?
Date: Fri, 4 Mar 2016 10:09:05 +0700
Message-ID: <CACsJy8Csx5ZBQqp0cP0YE-b==Uwfj+fPa6EfHi-fht9oCHTK=A@mail.gmail.com>
References: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Charles Strahan <charles@cstrahan.com>
X-From: git-owner@vger.kernel.org Fri Mar 04 04:09:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abg7c-0006T8-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 04 Mar 2016 04:09:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbcCDDJh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 22:09:37 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34651 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751228AbcCDDJg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 22:09:36 -0500
Received: by mail-lb0-f179.google.com with SMTP id cf7so30048056lbb.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EW1WLY9C9Ql7kol1CmNkGg8tiN9H8iZ2vR6LIyBg7L0=;
        b=cmvofpzcUxV6+US2EpAPnpheZpX6cFLF70S+6lgMxeJZGgcFiD8i4eExto3Jz5QLo+
         fjjekfuADjVcgLlRYnyb1brC+Dbzp/MTbO87qpRS+w/F8E/AH6PPxJZg/pZziYllVi5+
         ZwSr2gPH7sLn6nNuPeP/D+UdOQW/UfTl5Z8fgN8stQGCxyUrz/SsQ2k8J76C3MmEu9h4
         nABUDoEzn9YO4DTSi1oUFk5C8vGMHFZgSMom456oNahLrGe2AuBBkAf1HONUxryreYR0
         oho0b8sTVq9blw4qw6Hzd6fMcL9RbdDCkKjV1AfY6R47LU5QyVx1yT+ZJ6LKkYsPSg3Q
         Tzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EW1WLY9C9Ql7kol1CmNkGg8tiN9H8iZ2vR6LIyBg7L0=;
        b=OIjfyC79xfZXvEUmOOKfHOdxHj0RpQifhW+l2lsExJygTli/JdZOsNjtScDE3p6kL4
         sYBtjhDLcSWcB4lpctO8bkArSMwqkofheCdM+fV3iKwiPHlMtSSJNig56clnCnLtenZU
         IIB3b+OOvI9r2iReSrW0xDVt5kVNiLvUpJJ9ofL90pZh8Igy9KW0zOpXVNmp58RRIVvY
         g9rjV5w6c6GfBr3JCvNP1Jz2s5X0/drYgzQXkRdUBPOvE8qg0vl6dwgYA27y5bybyKdX
         O94ARqmIn8UdtYhY/DH++VPta5sa20c3JKZceK19ivyEointETE0npiFhnlGb4/d8/Rk
         94Ag==
X-Gm-Message-State: AD7BkJJnIGlAJ9QQeTHWKPmqSPTKIQIvE4OzaEr01dL2D5FjPHaiRkcVOwKmKf8LNYnQ6Ghw10IoHhrPkNGyZg==
X-Received: by 10.112.171.163 with SMTP id av3mr2233478lbc.145.1457060974919;
 Thu, 03 Mar 2016 19:09:34 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Thu, 3 Mar 2016 19:09:05 -0800 (PST)
In-Reply-To: <1457057516.1962831.539160698.3C8B30BC@webmail.messagingengine.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288229>

On Fri, Mar 4, 2016 at 9:11 AM, Charles Strahan <charles@cstrahan.com> wrote:
> Hello,
>
> I've found a change in the way .gitignore works, and I'm not sure if
> it's a bug
> or intended.

Can't look into this just yet. Quick question, what's the git version
you're currently running?
-- 
Duy
