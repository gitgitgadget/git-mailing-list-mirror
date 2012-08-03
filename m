From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Fri, 3 Aug 2012 10:16:20 +0700
Message-ID: <CACsJy8AQUwb8noutwdcN-6Piyo1rrj7_EUMjrXB-83J9AtM6kQ@mail.gmail.com>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 05:17:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sx8OR-0006CG-P2
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 05:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab2HCDQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 23:16:53 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:60827 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752229Ab2HCDQw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 23:16:52 -0400
Received: by ghrr11 with SMTP id r11so299716ghr.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 20:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FNVbm1A4KdHc7aNbREDocE7mJEjL8CPJSjC4sE3ijnE=;
        b=Urd42Lu3KXgkZnRazSYLqbvsl+qUM3bNXpapTwBROcMaXXspRKphzd3YAHMplfmaQY
         F2tRhpf1GvoF4gvIAsGbfLQrlPiQtMaDalM3Y815WkvKNWvPMty1J+gAMOJPR5MA6DyY
         CtEErtrPoC3A+Q4+1z3vE2Kjl05Ql+wo7Q3WWXg+XDaJON6I/spZtKxS0yLhovr/55Al
         77hL3PnWEyduNLB2ZHbj3gDq6VOrWRfi1AczyXqMS7Ym/miu2aKGB06zzJGC+NU3ZH0Q
         oLYI6SEi4oZAl5BmQEPHxe03vanV2cCfW9MrIMIa7dm8M8e0tkKEXRFW6Gk3lUjnBx99
         CBHw==
Received: by 10.50.100.129 with SMTP id ey1mr471676igb.35.1343963811355; Thu,
 02 Aug 2012 20:16:51 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Thu, 2 Aug 2012 20:16:20 -0700 (PDT)
In-Reply-To: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202816>

On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> Series of patches to introduce the index version 5 file format. This
> series does not include any fancy stuff like partial loading or partial
> writing yet, though it's possible to do that with the new format.

I applied the series on top of master. I had to manually resolve
09/16. You may want to rebase the series on master for the reroll
(less work for Junio) and remove trailing whitespaces in the patches.

All tests passed (with v5 by default (*), I notice it now), which is
wonderful. I'll have a closer look on the following days. Thank you
for working on this.

(*) while it's good to run tests with v5 by default. I'm not sure if
we should make it by default in the next git release that comes with
v5. For one thing it'll stop older gits from using shared repos. And
we're not sure whether v5 introduces significant overhead in common
use cases.
-- 
Duy
