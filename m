From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: 2.8.0 gitignore enhancement not working as expected
Date: Fri, 18 Mar 2016 21:52:37 +0700
Message-ID: <CACsJy8BfySC0extNWmKHgF1QOoEzGtg5RxgpfsNxjp8HJ_rdXQ@mail.gmail.com>
References: <4a4980485c234280bce91be87d213216@XCH-RCD-003.cisco.com>
 <CACsJy8Bjv=fF0CSNF_QNTCYCqQjy=j0ZEyjYOBFscz0HEYATig@mail.gmail.com> <551499517627471db2c8434077eb16db@XCH-RCD-003.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Richard Furness -X (rfurness - ENSOFT LIMITED at Cisco)" 
	<rfurness@cisco.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 15:53:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agvm6-0008Hc-G3
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 15:53:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866AbcCROxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 10:53:10 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:36265 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751838AbcCROxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 10:53:09 -0400
Received: by mail-lb0-f170.google.com with SMTP id qe11so35825482lbc.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 07:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ys2isdffIOZx4YwMBSdZEHIMm4Y6SfxdQ69rORwHyP8=;
        b=HB5vDhtvgIoR3HzA60vOmjv9Q/+EjiBSP6r8xRX6i2Dxhz/Wvo+OmJ/POZomQgUvKg
         XqYlvcbi8GzlUwoOOcWq2Wi40KmpBsSlFyx1SnHsBdtvTIMCbLghelUUeqmZvEPHHxHh
         FVK6zUcV+u9Gn8FEZAoduJfrR4GqdxwI6yf9b2l2U9lTM5YAMdK/cBrwUlSsxKTbIqfO
         ZtVKrRF6ZKflzKC7IEg3KGZgN+5CEFRF7rR248T83zPVBcgGw/BPjSc7MxVmlomeL9Uw
         886s8YCaIaNBMb4eqQiUKgtYS6EucHgO8fdhmimKRVUjw3FSyfpHsZDuDD2uieesuUg7
         /NBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ys2isdffIOZx4YwMBSdZEHIMm4Y6SfxdQ69rORwHyP8=;
        b=gMO2Zt1Vga57xUd6buzpRnRw6nspu71HBlxQQ6xpWSFH8/prYFW0iDkpuxMIVVDyTN
         SMEF+X9RHZJEdhdn1SKArML5UWSOKTAq1LtsR/R0kmD7riK5lF2aMIdhpHza1mo2E3/t
         QjzFbq4McU0WCM24A0n2RCsZ1P7Nlfy/F0yGOk1l3YMjOkAFJSNltUX55gRvtrm7q90m
         pI9E0LCoUBLNKE1JEFbWJmraLYwDZAQI5QduTurwWk10ivV7nmuAzIUN7yQwqqLaDcaO
         EBZfauGCCnLg5le1sXrDpdUeHBiuo7gDFfFuSulYlreUMpQ+1mQSJV/NpzYKK75QJ/Gc
         dv/g==
X-Gm-Message-State: AD7BkJKZjCYHXTs1i0mZTWi5itGsIIyApx65n3sb/rPVpywIuafyVkIab/p2MdEtEOHPL/avNv04AfoS4RlUOw==
X-Received: by 10.112.130.41 with SMTP id ob9mr5864688lbb.81.1458312787010;
 Fri, 18 Mar 2016 07:53:07 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 07:52:37 -0700 (PDT)
In-Reply-To: <551499517627471db2c8434077eb16db@XCH-RCD-003.cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289221>

On Fri, Mar 18, 2016 at 9:32 PM, Richard Furness -X (rfurness - ENSOFT
LIMITED at Cisco) <rfurness@cisco.com> wrote:
> Hi Duy,
>
> I tried your exact example and it worked correctly. But then I tried adding some more files/dirs at the top level and I still see an issue:

Thank you. Phew.. I bet you hit the same bug we found yesterday (your
trace suggests so). Can you try this patch [1] just to confirm?

[1] http://article.gmane.org/gmane.comp.version-control.git/289101
-- 
Duy
