From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Testing for commit reachability through plumbing commands
Date: Thu, 6 Mar 2014 14:29:34 -0500
Message-ID: <CACPiFC+hajx+z_Yq8vC88Q2DsSyD6zg0uOcjMmo7Qhj2m7r4Fg@mail.gmail.com>
References: <CACPiFCJLyE6XC9dY_eawe2y9gS4YsPdTbqkKAd0dcPXd5-eMCg@mail.gmail.com>
 <877g879lwp.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:30:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLdzT-0007cU-Ax
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 20:29:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbaCFT3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 14:29:55 -0500
Received: from mail-ve0-f179.google.com ([209.85.128.179]:61880 "EHLO
	mail-ve0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbaCFT3y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 14:29:54 -0500
Received: by mail-ve0-f179.google.com with SMTP id db12so3109885veb.38
        for <git@vger.kernel.org>; Thu, 06 Mar 2014 11:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aHQVkFfK+O+yw5oNhiE+bUKhHSOReQ/t6dj6Wxggz7c=;
        b=SU4byrEszQTLxRiD+Qhe+ENQjJg3GScAaQTq6kKLmk1MO+6ioXeOfvlJXPwc+9KM7j
         3EFxYpGBbIU/VDbcVqkSILLLg6MpI9iaifsUACr2TD2/EHqVnBdPtyGxI4in8/likxPN
         W1Nko7v79mqjegSZ1A4UAvu8f3aEUhYdqxTJlR+uSONr3PhieRKI5J3OPcHvKlhgBCHc
         R9vUv4D5wHKK51zXHtTiruO4uSCGmJtheJzhZUdINmFO1sksQ/FWfVHUfTculut7k+yz
         AFmpGE+1Fhj6izZaSAX90xYaN537vkM1k64qrVQPGzcBiAz83CFB3plZrTqTW6CYQvVw
         XksA==
X-Received: by 10.58.48.133 with SMTP id l5mr1354991ven.36.1394134194205; Thu,
 06 Mar 2014 11:29:54 -0800 (PST)
Received: by 10.220.183.138 with HTTP; Thu, 6 Mar 2014 11:29:34 -0800 (PST)
In-Reply-To: <877g879lwp.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243537>

On Thu, Mar 6, 2014 at 2:17 PM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Does git fsck --unreachable --no-reflogs help?

Well, my script, called regularly, does:

 - adds grafts
 - git repack -AFfd (which unpacks unreachable objects)
 - git prune --expire now

.... hmm, I guess could prune the grafts using git fsck --unreachable
--no-reflogs before pruning the objects themselves.

we'll find out if it works :-)



m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
