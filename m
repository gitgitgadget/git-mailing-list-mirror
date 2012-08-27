From: Dan Johnson <computerdruid@gmail.com>
Subject: Re: exporting a .git file ?
Date: Mon, 27 Aug 2012 10:45:40 -0400
Message-ID: <CAPBPrnu1FNbWP+k6Nq5NudBFYZu9njjbcL+oL7m-z5sajuXpBg@mail.gmail.com>
References: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Aaron Gray <aaronngray.lists@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 16:45:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T60Za-00028B-O9
	for gcvg-git-2@plane.gmane.org; Mon, 27 Aug 2012 16:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752035Ab2H0Opm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Aug 2012 10:45:42 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61207 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab2H0Opl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Aug 2012 10:45:41 -0400
Received: by eekc1 with SMTP id c1so982106eek.19
        for <git@vger.kernel.org>; Mon, 27 Aug 2012 07:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DkKIMonLET88sjwCpRM2uH1Z3lu8VWpeyJeQ9NgiMcw=;
        b=lqXk2Re9VaSVX+Ulm8jT9JyxFvymcpbpZc2e2pk0pBnH4MGjAT0UPS2OQNejn/QHjs
         9urgBBoXFDYkGVyXiL7nP5T2ry6PTNRZn5tchJ0J0dyc46s+etI9i0lbp8EqXc3N3vyX
         OKokDGFPwasb5+iUkoZS7Cnvu8AncGut8ZB2SRMn2YWLRHwTTfaNIaCDNUGwgxpNjEg/
         9/+aB6Aqwwtb3pHKt/V5DBetm0W+p7FgghtnSOFLARsKU3KxbT3Dyi8fJLUSRwS41feV
         ob8Df9fPUUNhCvovw9Ehc2wcBiWipRfqM5Z5ECOCG+63ANmB/zjI4Izi15ntL3+oAA0f
         qrLg==
Received: by 10.14.4.201 with SMTP id 49mr18142863eej.0.1346078740337; Mon, 27
 Aug 2012 07:45:40 -0700 (PDT)
Received: by 10.14.119.199 with HTTP; Mon, 27 Aug 2012 07:45:40 -0700 (PDT)
In-Reply-To: <CANkmNDc7VP4QiocxuB7JMuQyZy5nDT=ertow_ib2Hri_=XRMOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204346>

On Mon, Aug 27, 2012 at 10:32 AM, Aaron Gray <aaronngray.lists@gmail.com> wrote:
> Hi,
>
> Is there anyway to get my git repository as a single file ?

You're probably looking for the git bundle command (see git bundle
--help), but it's possible you might just want to use tar.

Hope that helps,
-- 
-Dan
