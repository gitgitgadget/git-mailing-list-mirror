From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] transport.c: mark push status strings for translation
Date: Sat, 16 Nov 2013 10:21:10 +0700
Message-ID: <CACsJy8DNAOO8mFPyDOLc_y6x7wAUze=MHYp=mVDQ=N8jkFcKbA@mail.gmail.com>
References: <1384345833-8345-1-git-send-email-pclouds@gmail.com> <20131113232529.GQ10302@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 16 04:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VhWSN-0007Wj-Qh
	for gcvg-git-2@plane.gmane.org; Sat, 16 Nov 2013 04:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753634Ab3KPDVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Nov 2013 22:21:42 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:34700 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3KPDVl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Nov 2013 22:21:41 -0500
Received: by mail-qe0-f50.google.com with SMTP id 1so2814506qee.9
        for <git@vger.kernel.org>; Fri, 15 Nov 2013 19:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bfuufO6WWrN+M5iT+a2YosaPDT83oQxQtPSz5OVeZDo=;
        b=JLoLxdr076Vbrvy1AJVKhPmfvZkz/rNPkCM7MizwOPRlarbdjlDGuyktndTMZohDCn
         /CTfQbaW6Xx3+8y7pf5qNmiZeRuHCCbdsqsIXuplPJTjSV+oUF5x/ZJD8II+dk5Goq2x
         go/rIsQkQ8cXWWN2rNLWGwBwTgHf5NvlBWXungTv8EB840iQ378hFNhaYqHXrcY3M7kt
         wfuoqIKAw8YWP3nEiHUMtAvisX+tv6BztVa06lMurnOuuiZzXPcjDvoVWOLfwNJ9go1I
         NISxKLQ0pkqOTu3NWosEEtN8BQ+Pn02o6idB0FzbL2lKugfhrqDCTTyNoWCjtPwEudik
         pcqw==
X-Received: by 10.49.24.202 with SMTP id w10mr16212846qef.12.1384572100426;
 Fri, 15 Nov 2013 19:21:40 -0800 (PST)
Received: by 10.96.134.68 with HTTP; Fri, 15 Nov 2013 19:21:10 -0800 (PST)
In-Reply-To: <20131113232529.GQ10302@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237922>

On Thu, Nov 14, 2013 at 6:25 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>               if (from)
>>                       fprintf(stderr, "%s -> %s", prettify_refname(from->name), prettify_refname(to->name));
>
> I'm not sure this is correct for right-to-left languages.  Something
> to solve another day.

I don't speak rtl languages and don't know the support status for
them. But to me rtl on terminal is a terrible idea as it's assumed
everywhere that the terminal prints from left to right. Anyway let's
wait until a rtl translation comes to git, then we'll have somebody
knowledgable about the languages to talk about.
-- 
Duy
