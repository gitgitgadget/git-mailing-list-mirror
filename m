From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] branch: use $curr_branch_short more
Date: Sat, 31 Aug 2013 03:22:24 -0500
Message-ID: <CAMP44s1qyF70eSCM4L1Yr=U02AwFZ0TNqiDvag8Qdzzi9GS1Mw@mail.gmail.com>
References: <1377899810-1818-1-git-send-email-felipe.contreras@gmail.com>
	<1377899810-1818-7-git-send-email-felipe.contreras@gmail.com>
	<xmqq38pqwlyl.fsf@gitster.dls.corp.google.com>
	<5221A510.2020206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Aug 31 10:22:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFgS1-0001hc-Ux
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 10:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753796Ab3HaIW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 04:22:28 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:59480 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab3HaIW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 04:22:26 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so2520413lbh.5
        for <git@vger.kernel.org>; Sat, 31 Aug 2013 01:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2wVqRKFToRki69xH4FWBF2itViPyD0zQqY51Yfk29Uw=;
        b=WmBEsA2/VhK8Wq/f7dczXkHONaoe6mPgOcY+BnB0SIOPTFZstSB/upSYiWQq0jSf7J
         6j3lKgi5pY686KD9pbnJUsf3qAMDtqgrUwQXHatx051BS2gtfYOAsumq+DaJnLnhjfIU
         oVIIOV6VGC0PYiLloWaxSTYe/pkNGixALGxhA1FgzOx7eVWNuoOBS/m6mj+tLpIiWK30
         xpPF6GCH+icrXxaGJdkBD0WxmR+mA2UI65LXlc2nYxT/ypxq2h7e4lOhUIFQZSuvwSUu
         Vf7L3DpDZHFKTt7sPxFn1UfamaZ+tIQ+f5LJT1MBQh1LlRSjhDi/wz9LKrXjVad2tZ+h
         t0aA==
X-Received: by 10.152.30.74 with SMTP id q10mr1055519lah.27.1377937344209;
 Sat, 31 Aug 2013 01:22:24 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 31 Aug 2013 01:22:24 -0700 (PDT)
In-Reply-To: <5221A510.2020206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233511>

> Subject: branch: use $curr_branch_short more

Why? I don't think that summary explains the reason for being for this
patch, also, it starts with branch: instead of pull:

Subject: pull: trivial simplification

With that summary, people would have an easier time figuring out if
they need to read more about the patch or not.

-- 
Felipe Contreras
